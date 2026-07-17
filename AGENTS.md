# Agent guide

> TEMPLATE NOTE: This repository is `systemc-devenv`, the reusable SystemC template.
> While working in this upstream template, make only template infrastructure changes and
> do not add product/IP content. After creating a product repo with GitHub
> **"Use this template"**, delete this note or replace it with the concrete IP/block
> name and remove template-only wording.

**Read first:** [docs/PRIME_DIRECTIVE.md](docs/PRIME_DIRECTIVE.md) — repository mission,
scope, and agent rules.

## New chat

Copy a prompt from [docs/agents/CHAT_INIT.md](docs/agents/CHAT_INIT.md):

- **Implementation work** — default init prompt
- **Architectural review** — PR or periodic review prompt
- **Confluence spec sync** — optional; when HAS is mirrored from Confluence
## Read order

1. [docs/PRIME_DIRECTIVE.md](docs/PRIME_DIRECTIVE.md) — mission, scope, agent rules
2. [docs/PLANNING.md](docs/PLANNING.md) — technical decisions and milestones
3. [docs/agents/GETTING_STARTED.md](docs/agents/GETTING_STARTED.md) — build flow and layout
4. [docs/agents/MODEL_DEVELOPMENT_STAGES.md](docs/agents/MODEL_DEVELOPMENT_STAGES.md) —
   modeling progression (product repos)

**Architectural review:** also read [docs/agents/ARCHITECTURAL_REVIEW.md](docs/agents/ARCHITECTURAL_REVIEW.md).

## Before starting any task

Classify the work and state the classification before making changes:

- **Template infrastructure:** build flow, dependency setup, generic examples, CMake
  patterns, smoke tests, reusable documentation, and agent/developer guidance.
- **Product/IP work:** product specs, real block behavior, `REQ-` IDs, product test
  plans, architectural TODOs, protocol-specific features, and product traceability rules.
- **Upstream feedback:** reusable learnings discovered in a product repo — log in
  [docs/upstream/LEARNINGS.md](docs/upstream/LEARNINGS.md), then promote to the template.
- **Architectural review:** consistency checks and drift detection — findings → PR comments
  and/or [docs/gaps/GAPS.md](docs/gaps/GAPS.md).

In upstream `systemc-devenv`, only template infrastructure belongs here. In a product
repo created from this template, product/IP work is expected and should keep engineering
executable collateral synchronized.

## Product repo prime directive

Maintain **engineering executable collateral** for one concrete IP/block
([Specification-First Engineering](docs/PRIME_DIRECTIVE.md)):

- the written specification defines engineering intent
- the SystemC model is the executable realization of that intent
- verification and other collateral validate and communicate that intent
- unresolved divergence is tracked in [docs/gaps/GAPS.md](docs/gaps/GAPS.md)

## Locked choices (do not change without updating PLANNING.md)

| Item | Value |
|------|-------|
| SystemC | 3.0.2 via `make systemc` → `./systemc` |
| Boost | 1.86.0 via `make boost` → `./boost` |
| C++ | C++17 |
| CMake minimum | 3.24 |
| DevContainer | `mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04` |
| Tests | GoogleTest in `extern/googletest` |

## Where code / collateral lives

- **Models:** `model/views/<timing_view>/` — use `sc_module` + signals in `cycle_accurate/`
- **Tests:** `verification/systemc/` — GTest, discovered via CMake `project_add_test`
- **Build:** root `CMakeLists.txt`, deps via root `Makefile`
- **Specs (product repos):** `docs/spec/` — see [docs/spec/README.md](docs/spec/README.md)
- **Gaps (product repos):** `docs/gaps/GAPS.md`
- **Template learnings (product repos):** `docs/upstream/LEARNINGS.md`

## Verify changes

```bash
make build-prep   # or: make prepare-tools
make test         # default goal: configure, build, ctest
make style-check-clang   # requires venv from build-prep
```

Any C/C++ files you add or edit must pass `make style-check-clang` before submission.
Run `make style-format-clang` to apply `.clang-format` automatically.

## Scope boundaries

- In upstream `systemc-devenv`: template infrastructure only
- In a product repo: delete or replace the template note, define the concrete IP scope,
  and add product specs, requirement IDs, tests, and architectural TODOs as needed
- CI (`.github/`) changes are deferred unless trivial
- Ask before large structural changes not listed in PLANNING.md
