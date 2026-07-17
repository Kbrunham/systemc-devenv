# Confluence spec sync — agent runbook (optional)

> TEMPLATE NOTE: Use this runbook **only** when the product HAS lives in Confluence and
> you adopt the two-layer `docs/spec/import/` mirror. Leave unused in upstream
> `systemc-devenv` itself. After **"Use this template"**, fill site / space / root page ID
> below for your IP.

Step-by-step instructions to **import** (or re-import) a Hardware Architecture Specification
from Confluence into `docs/spec/import/`.

**Confluence is the source of truth** when this pattern is used. Git holds versioned
snapshots for modeling, verification, and offline review. One-way sync: Confluence → git
unless the team explicitly defines bidirectional workflow.

For layout and traceability rules, see [../spec/README.md](../spec/README.md). For the page
inventory, see [../spec/rationale/source.md](../spec/rationale/source.md).

---

## Product configuration (fill in after Use this template)

| Field | Value |
|-------|-------|
| Confluence site (cloudId) | `_YOUR_SITE_.atlassian.net` |
| Space key | `_SPACE_` |
| HAS root page ID | `_ROOT_PAGE_ID_` |
| Ignored page title patterns (optional) | e.g. duplicate export copies |

---

## When to run a sync

| Trigger | Scope |
|---------|-------|
| Planned phase import | Pages listed in [source.md](../spec/rationale/source.md) as **planned** |
| Confluence page updated | Re-fetch affected page(s); new snapshot ID if batch |
| New HAS page under root | Add row to `source.md`, then import |
| Drift investigation | Compare live Confluence version to import file headers; re-import if behind |

Document any pages that must **not** be imported (duplicate exports, drafts) in `source.md`.

---

## Prerequisites

### 1. Atlassian MCP (page text)

1. Cursor **Settings → Tools & MCP** — enable the **atlassian** MCP server.
2. In Agent chat, trigger OAuth (e.g. *“Fetch Confluence page \<rootPageId\>”*).
3. Confirm tools: `getConfluencePage`, `getConfluencePageDescendants`, `searchConfluenceUsingCql`.

### 2. Confluence API token (diagram PNGs)

Markdown export often embeds unusable `blob:` image URLs. Download attachments separately:

```bash
export CONFLUENCE_SITE=https://_YOUR_SITE_.atlassian.net
export CONFLUENCE_EMAIL=you@example.com
export CONFLUENCE_API_TOKEN=...   # Atlassian account API token
make import-spec-images
```

Never commit tokens. Use environment variables only.

---

## Snapshot identity

Every sync batch gets a unique ID and UTC timestamp recorded in
[`docs/spec/import/SNAPSHOT.md`](../spec/import/SNAPSHOT.md).

**Naming:** `snap-YYYYMMDD-{phase}` — e.g. `snap-20260627-p0`, `snap-20260715-phase2`.

Each imported page file must include in its HTML comment header:

- `confluence-version` and `confluence-version-created-at` (from fetch response)
- `import-snapshot-id` and `imported-at` (this batch)

Prefer a new snapshot ID for multi-page or release-aligned imports.

---

## Sync procedure

### Step 1 — Plan the batch

1. Read [source.md](../spec/rationale/source.md) mapping tables and import phases.
2. List target page IDs and files: `docs/spec/import/{pageId}-{slug}.md`.
3. Assign snapshot ID and note intended `imported-at` (UTC, ISO-8601).

Use `getConfluencePageDescendants(pageId="<rootPageId>", depth=2)` to discover new children
if the HAS tree changed.

### Step 2 — Fetch page text

For each page:

```
getConfluencePage(
  cloudId="_YOUR_SITE_.atlassian.net",
  pageId="<pageId>",
  contentFormat="markdown"
)
```

Also fetch **`contentFormat="html"`** for pages with diagrams (to extract `data-id`,
filename, and attachment metadata).

Write or overwrite `docs/spec/import/{pageId}-{slug}.md` with:

1. Required HTML comment header (see [import/README.md](../spec/import/README.md)).
2. Title line and provenance linking to `SNAPSHOT.md`.
3. Page body from the markdown response.

**Import-only:** do not hand-edit spec prose. Note manual macro/diagram fixups in
`source.md`.

Optional helper (batch JSON → import files):

```bash
python3 tools/import_confluence_pages.py tools/.confluence_batch/pages.json
```

### Step 3 — Import diagrams

1. Build or update [`docs/spec/import/images/manifest.json`](../spec/import/images/manifest.json)
   with `pageId`, `importFile`, `fileId`, `downloadPath`, `localPath`, `alt`, etc.
2. Run:

```bash
make import-spec-images
```

This downloads files under `docs/spec/import/images/{pageId}/` and rewrites `blob:` links
in import markdown.

### Step 4 — Update provenance and indexes

| Artifact | Action |
|----------|--------|
| [`SNAPSHOT.md`](../spec/import/SNAPSHOT.md) | Add batch section: snapshot ID, UTC time, page table with versions |
| [`source.md`](../spec/rationale/source.md) | Set status `planned` → `imported (vN)` |
| Section indexes | `overview.md`, `architecture/`, `behavior/`, `interfaces/`, `registers/` — live links |
| [`GAPS.md`](../gaps/GAPS.md) | Log intentional drift or close gaps resolved by import |

Assign `REQ-…` IDs in section indexes when requirements become testable.

### Step 5 — Verify

- [ ] No remaining `blob:` image URLs in changed import files
- [ ] Every import file header has correct `confluence-version` and `import-snapshot-id`
- [ ] `SNAPSHOT.md` lists all pages for this batch
- [ ] `source.md` rows match imported files
- [ ] Section indexes link to correct `import/` paths
- [ ] Ignored / duplicate export pages were not imported
- [ ] Git diff is spec-focused unless model/test updates are in scope

Optional: architectural review per [ARCHITECTURAL_REVIEW.md](ARCHITECTURAL_REVIEW.md) after
large imports.

---

## MCP tool reference

| Tool | Use |
|------|-----|
| `getConfluencePage` | Page body (markdown + html) |
| `getConfluencePageDescendants` | HAS tree under root page ID |
| `searchConfluenceUsingCql` | Attachments: `type=attachment AND container=<pageId>` |

---

## Related

- [../spec/README.md](../spec/README.md) — two-layer spec model
- [../spec/import/README.md](../spec/import/README.md) — mirror rules and file headers
- [../spec/rationale/source.md](../spec/rationale/source.md) — page map template
- [MODEL_DEVELOPMENT_STAGES.md](MODEL_DEVELOPMENT_STAGES.md) — Stage 1 (spec baseline)
- [CHAT_INIT.md](CHAT_INIT.md) — copy-paste sync prompt
- [../../Makefile](../../Makefile) — `make import-spec-images`
