# Prime directive — systemc-devenv

This document is the canonical statement of **why this repository exists** and **how
agents and developers should use it**. Read this before making changes.

## Mission

This repository provides a **reproducible foundation** for SystemC model development:
pinned dependencies, directory layout, build and test flow, and agent conventions.

It is the **starting point** for product repositories (for example, `spi-systemc-model`),
not the product itself.

Success here means: anyone can clone the repo, run the standard build sequence, and have
a working SystemC modeling workspace with clear patterns to extend.

## What success looks like in this repo

- `make prepare-tools && cmake -B build && cmake --build build && ctest --test-dir build` passes
- New models live under `model/views/<timing_view>/`
- New tests live under `verification/systemc/`
- The repository stays **IP-agnostic** — no product specifications, no `REQ-` requirement
  IDs, no product-specific `todo/` content
- Changes keep the template self-consistent (build, smoke test, and docs agree)

## Template vs product repository

| In this repo (template) | In a product repo (created via "Use this template") |
|-------------------------|-----------------------------------------------------|
| Makefile deps, devcontainer, CMake patterns | IP specification (`docs/spec/`) |
| Generic agent and developer documentation | Product `docs/PRIME_DIRECTIVE.md` (executable spec rules) |
| Hello-world model and smoke test | Real model and requirement tests |
| `docs/PLANNING.md` (template technical decisions) | `todo/ARCHITECTURAL.md`, `REQ-` traceability, test plan |

See [TEMPLATE_VS_PRODUCT.md](TEMPLATE_VS_PRODUCT.md) for a fuller comparison.

A product repository maintains **two synchronized views of the same IP**: a human-readable
Markdown specification and an executable SystemC model, with tests as the bridge. That
workflow is defined in the **product repo's** prime directive, not here.

## Agent rules when working in this repo

1. **Extend infrastructure and patterns**, not domain IP behavior.
2. Model changes here are **examples and patterns** (e.g. hello-world), not product logic.
3. A single change may touch CMake, model, and tests when keeping the template consistent.
4. Do not add product specs, requirement IDs, or architectural TODOs for a specific IP.
5. Locked toolchain versions change only by updating [PLANNING.md](PLANNING.md) with justification.
6. Verify with the standard build sequence before considering work complete.
7. Before starting, decide: is this **template infrastructure** (allowed here) or **product IP**
   (belongs in a derived repository)?

## Agent rules when working in a product repository

1. Read **that repository's** `docs/PRIME_DIRECTIVE.md` first — not this file alone.
2. Keep specification, model, and tests aligned; record gaps in that repo's `todo/ARCHITECTURAL.md`.
3. Do not copy product-specific spec or model content back into systemc-devenv.

## Downstream workflow

```
systemc-devenv (template)
    → GitHub "Use this template"
    → product repo (e.g. spi-systemc-model)
    → add product PRIME_DIRECTIVE, spec skeleton, model, tests
```

When the template reaches a milestone, tag a release and enable **Template repository**
on GitHub so product repos can be created from a known-good baseline.

## Related documentation

| Document | Purpose |
|----------|---------|
| [AGENTS.md](../AGENTS.md) | Short agent entry point |
| [PLANNING.md](PLANNING.md) | Locked technical decisions and milestones |
| [agents/GETTING_STARTED.md](agents/GETTING_STARTED.md) | Build flow and layout |
| [agents/CHAT_INIT.md](agents/CHAT_INIT.md) | Copy-paste prompt for new agent sessions |
| [TEMPLATE_VS_PRODUCT.md](TEMPLATE_VS_PRODUCT.md) | Template vs product scope |
