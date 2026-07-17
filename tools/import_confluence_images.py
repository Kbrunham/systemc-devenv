#!/usr/bin/env python3
"""Download Confluence page attachments and rewrite import markdown image links.

Reads docs/spec/import/images/manifest.json (generated during spec import).
Auth via environment variables (create at https://id.atlassian.com/manage-profile/security/api-tokens):

  export CONFLUENCE_SITE=https://_YOUR_SITE_.atlassian.net
  export CONFLUENCE_EMAIL=you@altera.com
  export CONFLUENCE_API_TOKEN=...

Usage:
  python3 tools/import_confluence_images.py
  python3 tools/import_confluence_images.py --rewrite-only
"""

from __future__ import annotations

import argparse
import base64
import json
import os
import re
import sys
import urllib.error
import urllib.request
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
IMPORT_DIR = REPO_ROOT / "docs" / "spec" / "import"
MANIFEST = IMPORT_DIR / "images" / "manifest.json"
BLOB_RE = re.compile(r"!\[\]\(blob:[^)]*id=([0-9a-f-]{36})[^)]*\)")


def auth_header(email: str, token: str) -> str:
    raw = f"{email}:{token}".encode()
    return "Basic " + base64.b64encode(raw).decode("ascii")


def load_manifest() -> dict:
    return json.loads(MANIFEST.read_text(encoding="utf-8"))


def wiki_base(site: str) -> str:
    base = site.rstrip("/")
    if not base.endswith("/wiki"):
        base += "/wiki"
    return base


def download_image(site: str, email: str, token: str, entry: dict) -> Path:
    url = wiki_base(site) + entry["downloadPath"]
    dest = IMPORT_DIR / entry["localPath"]
    dest.parent.mkdir(parents=True, exist_ok=True)
    req = urllib.request.Request(url, headers={"Authorization": auth_header(email, token)})
    with urllib.request.urlopen(req, timeout=120) as resp:
        data = resp.read()
    dest.write_bytes(data)
    return dest


def rewrite_markdown(manifest: dict) -> int:
    by_file_id = {e["fileId"]: e for e in manifest["images"]}
    changed = 0
    touched: set[str] = set()

    for entry in manifest["images"]:
        md_path = IMPORT_DIR / entry["importFile"]
        if entry["importFile"] in touched:
            continue
        text = md_path.read_text(encoding="utf-8")
        new_text = text

        def repl(match: re.Match[str]) -> str:
            fid = match.group(1)
            img = by_file_id.get(fid)
            if not img:
                return match.group(0)
            rel = img["localPath"]
            return f'![{img["alt"]}]({rel})'

        new_text = BLOB_RE.sub(repl, new_text)
        if new_text != text:
            md_path.write_text(new_text, encoding="utf-8")
            changed += 1
        touched.add(entry["importFile"])

    return changed


def main() -> int:
    parser = argparse.ArgumentParser(description="Import Confluence images for spec mirror")
    parser.add_argument(
        "--rewrite-only",
        action="store_true",
        help="Rewrite markdown links only (images must already exist on disk)",
    )
    args = parser.parse_args()

    if not MANIFEST.is_file():
        print(f"error: missing manifest {MANIFEST}", file=sys.stderr)
        return 1

    manifest = load_manifest()
    if not args.rewrite_only:
        site = os.environ.get("CONFLUENCE_SITE")
        email = os.environ.get("CONFLUENCE_EMAIL")
        token = os.environ.get("CONFLUENCE_API_TOKEN")
        if not site or not email or not token:
            print(
                "error: set CONFLUENCE_SITE, CONFLUENCE_EMAIL, and CONFLUENCE_API_TOKEN\n"
                "  See tools/import_confluence_images.py header for setup.",
                file=sys.stderr,
            )
            return 1

        for entry in manifest["images"]:
            dest = IMPORT_DIR / entry["localPath"]
            try:
                download_image(site, email, token, entry)
                print(f"downloaded {entry['localPath']}")
            except urllib.error.HTTPError as exc:
                print(f"error: HTTP {exc.code} for {entry['label']}", file=sys.stderr)
                return 1

    missing = [e["localPath"] for e in manifest["images"] if not (IMPORT_DIR / e["localPath"]).is_file()]
    if missing and args.rewrite_only:
        print("error: missing image files (run without --rewrite-only first):", file=sys.stderr)
        for path in missing:
            print(f"  {path}", file=sys.stderr)
        return 1

    n = rewrite_markdown(manifest)
    print(f"rewrote {n} import markdown file(s)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
