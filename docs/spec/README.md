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
| `docs/spec/…` | Architecture, behavior, interfaces, registers, rationale (as needed) |

Optional patterns used by some product repos:

- **Import mirror** — versioned snapshots of an external HAS (e.g. Confluence) under
  `docs/spec/import/`, with section indexes that link into the mirror rather than
  duplicating prose.
- **Section indexes** — stable navigation and `REQ-…` assignment without copying the
  authoritative specification text.

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
