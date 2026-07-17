# Confluence import mirror (optional)

> TEMPLATE NOTE: Adopt this directory when the authoritative HAS lives in Confluence.
> Leave empty (no product pages) in upstream `systemc-devenv`.

Exact Markdown mirror of the product Hardware Architecture Specification from Confluence.
**Confluence is the source of truth**; files here are git-tracked snapshots.

**Re-import procedure:** [../../agents/CONFLUENCE_SYNC.md](../../agents/CONFLUENCE_SYNC.md)

**Latest snapshot:** [`SNAPSHOT.md`](SNAPSHOT.md) — fill in after the first import.

## Rules

1. **Import-only** — update files here by re-fetching from Confluence (`getConfluencePage`),
   not by hand-editing spec text. Note manual fixups in [../rationale/source.md](../rationale/source.md).
2. **One Confluence page → one file** — naming: `{pageId}-{slug}.md` (page ID is stable).
3. **Do not import** pages listed as ignored in `source.md` (duplicate exports, drafts).
4. **Do not duplicate** — section indexes under `docs/spec/` link here; they do not copy prose.
5. **Diagrams** — store under [`images/`](images/) and catalog in
   [`images/manifest.json`](images/manifest.json). Markdown export alone often yields unusable
   `blob:` placeholders; run `make import-spec-images` after text import.

## File header (required)

Every import file starts with HTML comment metadata, including Confluence page version:

```markdown
<!--
  Confluence import mirror — do not edit by hand; re-import from Confluence.
  confluence-page-id: 123456789
  confluence-title: Example Overview
  confluence-url: https://_YOUR_SITE_.atlassian.net/wiki/spaces/_SPACE_/pages/123456789/...
  confluence-page-created-at: 2026-01-01T00:00:00.000Z
  confluence-status: current
  confluence-version: 1
  confluence-version-created-at: 2026-01-01T00:00:00.000Z
  import-snapshot-id: snap-YYYYMMDD-p0
  imported-at: 2026-01-01T00:00:00Z
-->
```

Batch-level provenance is recorded in [`SNAPSHOT.md`](SNAPSHOT.md).

## Status

No pages imported in the template. Product repos fill [SNAPSHOT.md](SNAPSHOT.md) and
[../rationale/source.md](../rationale/source.md) on first sync.
