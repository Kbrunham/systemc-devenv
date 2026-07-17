# Tools

Optional helpers for product repos that mirror a Confluence HAS into `docs/spec/import/`.

| Script | Purpose |
|--------|---------|
| `import_confluence_pages.py` | Write import markdown files from a batch JSON export |
| `import_confluence_images.py` | Download attachments listed in `images/manifest.json` and rewrite `blob:` links |

See [../docs/agents/CONFLUENCE_SYNC.md](../docs/agents/CONFLUENCE_SYNC.md).

```bash
export CONFLUENCE_SITE=https://_YOUR_SITE_.atlassian.net
export CONFLUENCE_EMAIL=you@example.com
export CONFLUENCE_API_TOKEN=...
make import-spec-images
```
