# Product specification (scaffold)

> TEMPLATE NOTE: After **"Use this template"**, replace this file with your IP/block
> specification conventions. Do not add product-specific requirements to upstream
> `systemc-devenv`.

## Purpose

Product repositories keep engineering intent under `docs/spec/`. The behavioral SystemC
model and verification tests implement and check that intent.

## Recommended layout

| Path | Role |
|------|------|
| `docs/spec/README.md` | This file — source-of-truth policy, REQ-ID convention, navigation |
| `docs/spec/overview.md` | Scope / introduction index |
| `docs/spec/architecture/` | Hierarchy → SystemC module map |
| `docs/spec/behavior/` | Sequences, reset, power |
| `docs/spec/interfaces/` | Ports / protocols |
| `docs/spec/registers/` | Register / address map |
| `docs/spec/rationale/` | Provenance (`source.md`), PPA, design rationale |

### Optional: Confluence import mirror

When the authoritative HAS lives in Confluence, use a two-layer layout:

| Path | Role |
|------|------|
| [`import/`](import/) | Exact Confluence snapshots — `{pageId}-{slug}.md`; **import-only** |
| Section indexes (above) | Links into `import/`, `REQ-…` IDs, model/test pointers — **no duplicated prose** |

Runbook: [../agents/CONFLUENCE_SYNC.md](../agents/CONFLUENCE_SYNC.md). Page map:
[rationale/source.md](rationale/source.md).

## Requirement IDs

Pick a product-specific prefix and keep it consistent across specs, tests, and
[../gaps/GAPS.md](../gaps/GAPS.md). Example: `REQ-<BLOCK>-NNN`.

Reference IDs in:

- Section indexes or requirement lists under `docs/spec/`
- GTest names or test file headers (e.g. `FooReset_REQ_FOO_001`)
- Gap entries when behavior is deferred or divergent

## Rules of thumb

1. Document where the **authoritative** specification lives (this repo, Confluence, etc.).
2. Keep model hierarchy aligned with the architectural decomposition, not RTL micro-structure.
3. When spec, model, or tests disagree, record the divergence in [../gaps/GAPS.md](../gaps/GAPS.md).

## Related

- [../PRIME_DIRECTIVE.md](../PRIME_DIRECTIVE.md) — mission and agent rules
- [../gaps/GAPS.md](../gaps/GAPS.md) — divergence tracker
- [../upstream/README.md](../upstream/README.md) — feeding template improvements upstream
- [../agents/CONFLUENCE_SYNC.md](../agents/CONFLUENCE_SYNC.md) — optional Confluence import runbook
- [../agents/MODEL_DEVELOPMENT_STAGES.md](../agents/MODEL_DEVELOPMENT_STAGES.md) — Stage 1 spec baseline
