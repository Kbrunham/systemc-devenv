# Confluence import snapshots

> TEMPLATE NOTE: Replace this placeholder after the first product HAS import. Keep one
> current snapshot section; archive prior batches below if useful.

## Snapshot identity (template)

| Field | Value |
|-------|-------|
| **Snapshot ID** | `snap-YYYYMMDD-phase` |
| **Imported at (UTC)** | `_ISO8601_` |
| **Fetch method** | Atlassian MCP `getConfluencePage(contentFormat="markdown")` |
| **Diagram fetch** | `make import-spec-images` (optional) |
| **Confluence site** | `_YOUR_SITE_.atlassian.net` |
| **Space** | `_SPACE_` |
| **HAS root page ID** | `_ROOT_PAGE_ID_` |

## Pages in this snapshot

| Import file | Page ID | Confluence title | Version | Version created (UTC) |
|-------------|---------|------------------|---------|----------------------|
| — | — | _none yet_ | — | — |

## Diagrams

Catalog: [`images/manifest.json`](images/manifest.json) (empty until first diagram import).

```bash
make import-spec-images
```

## Re-import

Follow [../../agents/CONFLUENCE_SYNC.md](../../agents/CONFLUENCE_SYNC.md). Assign a new
snapshot ID and log drift in [../../gaps/GAPS.md](../../gaps/GAPS.md).
