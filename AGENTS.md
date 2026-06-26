# Agent guide — systemc-devenv

**Read first:** [docs/PRIME_DIRECTIVE.md](docs/PRIME_DIRECTIVE.md) — why this repo exists,
what belongs here vs in a product repo, and how agents should work.

## New chat

Copy the prompt from [docs/agents/CHAT_INIT.md](docs/agents/CHAT_INIT.md) into a
fresh agent chat to initialize the session.

## Read order

1. [docs/PRIME_DIRECTIVE.md](docs/PRIME_DIRECTIVE.md) — mission, scope, agent rules
2. [docs/PLANNING.md](docs/PLANNING.md) — locked technical decisions and milestones
3. [docs/agents/GETTING_STARTED.md](docs/agents/GETTING_STARTED.md) — build flow and layout
4. [docs/TEMPLATE_VS_PRODUCT.md](docs/TEMPLATE_VS_PRODUCT.md) — when work belongs here vs downstream

## Locked choices (do not change without updating PLANNING.md)

| Item | Value |
|------|-------|
| SystemC | 3.0.2 via `make systemc` → `./systemc` |
| Boost | 1.86.0 via `make boost` → `./boost` |
| C++ | C++17 |
| CMake minimum | 3.24 |
| DevContainer | `mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04` |
| Tests | GoogleTest in `extern/googletest` |

## Where code lives

- **Models:** `model/views/<timing_view>/` — use `sc_module` + signals in `cycle_accurate/`
- **Tests:** `verification/systemc/` — GTest, discovered via CMake `project_add_test`
- **Build:** root `CMakeLists.txt`, deps via root `Makefile`

## Verify changes

```bash
make prepare-tools
cmake -B build
cmake --build build
ctest --test-dir build
```

## Scope boundaries

- **Template infrastructure only** — see [docs/PRIME_DIRECTIVE.md](docs/PRIME_DIRECTIVE.md)
- No product specs, `REQ-` IDs, or product `todo/` content
- CI (`.github/`) changes are deferred unless trivial
- Ask before large structural changes not listed in PLANNING.md
