#!/usr/bin/env python3
"""Write Confluence import mirror files from a batch JSON export.

Input JSON format (tools/.confluence_batch/pages.json):
{
  "snapshotId": "snap-YYYYMMDD-p0",
  "importedAt": "2026-06-27T20:00:00Z",
  "pages": [
    {
      "id": "123456789",
      "title": "Example Overview",
      "importFile": "123456789-example-overview.md",
      "webUrl": "https://...",
      "createdAt": "...",
      "status": "current",
      "version": 12,
      "versionAt": "...",
      "bodyMarkdown": "..."
    }
  ]
}

Usage:
  python3 tools/import_confluence_pages.py tools/.confluence_batch/pages.json
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
IMPORT_DIR = REPO_ROOT / "docs" / "spec" / "import"

MEDIA_RE = re.compile(
    r'data-type="media"[^>]*data-id="([0-9a-f-]{36})"[^>]*data-collection="contentId-(\d+)"'
    r'[^>]*>([^<]+)</div>'
)


def header(page: dict, snapshot_id: str, imported_at: str) -> str:
    return f"""<!--
  Confluence import mirror — do not edit by hand; re-import from Confluence.
  confluence-page-id: {page['id']}
  confluence-title: {page['title']}
  confluence-url: {page['webUrl']}
  confluence-page-created-at: {page.get('createdAt', '')}
  confluence-status: {page.get('status', 'current')}
  confluence-version: {page['version']}
  confluence-version-created-at: {page['versionAt']}
  import-snapshot-id: {snapshot_id}
  imported-at: {imported_at}
-->

# {page['title']}

> Confluence page [{page['id']}]({page['webUrl']}) — version **{page['version']}** ({page['versionAt']}).
> Snapshot [{snapshot_id}](SNAPSHOT.md) imported at {imported_at}.

"""


def write_pages(batch: dict) -> list[str]:
    snapshot_id = batch["snapshotId"]
    imported_at = batch["importedAt"]
    written: list[str] = []
    for page in batch["pages"]:
        out = IMPORT_DIR / page["importFile"]
        out.write_text(header(page, snapshot_id, imported_at) + page["bodyMarkdown"], encoding="utf-8")
        written.append(page["importFile"])
        print(f"wrote {page['importFile']}")
    return written


def extract_media_from_html(html: str) -> list[dict]:
    found = []
    for file_id, page_id, filename in MEDIA_RE.findall(html):
        found.append({"fileId": file_id, "pageId": page_id, "confluenceTitle": filename.strip()})
    return found


def main() -> int:
    if len(sys.argv) != 2:
        print(f"usage: {sys.argv[0]} <batch.json>", file=sys.stderr)
        return 1
    batch = json.loads(Path(sys.argv[1]).read_text(encoding="utf-8"))
    write_pages(batch)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
