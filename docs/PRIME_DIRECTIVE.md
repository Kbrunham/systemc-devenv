# Prime directive

> TEMPLATE NOTE: This repository is `systemc-devenv`, the reusable SystemC template.
> While working in this upstream template, make only template infrastructure changes and
> do not add product/IP content. After creating a product repo with GitHub
> **"Use this template"**, delete this note or replace it with the concrete IP/block
> name and remove template-only wording.

This document is the canonical statement of why this repository exists and how agents
and developers should use it. Read this before making changes.

## Mission

This repository maintains a synchronized executable specification for one concrete
IP/block:

- the Markdown specification states the intended behavior
- the SystemC model implements that behavior
- the verification tests check that behavior

Success means spec, model, and tests describe the same behavior. When they do not,
record the gap explicitly until all three agree.

For upstream `systemc-devenv`, this file is a product-repo scaffold. The upstream
template mission is to provide the pinned dependencies, build/test flow, directory
layout, and agent conventions that product repos inherit.

## What success looks like

- `make prepare-tools && cmake -B build && cmake --build build && ctest --test-dir build` passes
- Product specifications live under the repo's documented spec location
- Models live under `model/views/<timing_view>/`
- Tests live under `verification/systemc/`
- Requirement IDs, test plans, and gap tracking are kept consistent with the product
  repo's conventions
- Changes keep specification, implementation, tests, and documentation aligned

## Product repository setup

After creating a product repo from this template:

1. Delete or replace the template note at the top of this file and
   [../AGENTS.md](../AGENTS.md) with the concrete IP/block name.
2. Define the product scope and specification location.
3. Define requirement ID and traceability conventions, if used.
4. Define where architectural gaps and deferred work are tracked.
5. Replace the hello-world model and smoke test with product behavior and tests.

## Upstream template boundary

In upstream `systemc-devenv`, do not add product-specific content. Keep changes limited
to reusable template infrastructure and patterns:

- Makefile dependency flow
- DevContainer and CMake patterns
- generic example models and smoke tests
- reusable agent and developer documentation

Product-specific specs, `REQ-` IDs, protocol behavior, product test plans, and
architectural TODOs belong in a repo created from this template.

## Agent rules

1. Before starting, state whether the work is template infrastructure or product/IP work.
2. In upstream `systemc-devenv`, extend infrastructure and patterns only.
3. In a product repo, keep specification, model, and tests aligned.
4. Record unresolved spec/model/test gaps in the product repo's documented gap tracker.
5. A single change may touch docs, model, tests, and build files when needed to keep
   the repository consistent.
6. Locked toolchain versions change only by updating [PLANNING.md](PLANNING.md) with justification.
7. Verify with the standard build sequence and `make style-check-clang` before considering work complete.
8. Run `make style-format-clang` on any C/C++ files you add or edit.

## Related documentation

| Document | Purpose |
|----------|---------|
| [AGENTS.md](../AGENTS.md) | Short agent entry point |
| [PLANNING.md](PLANNING.md) | Locked technical decisions and milestones |
| [agents/GETTING_STARTED.md](agents/GETTING_STARTED.md) | Build flow and layout |
| [agents/CHAT_INIT.md](agents/CHAT_INIT.md) | Copy-paste prompt for new agent sessions |
