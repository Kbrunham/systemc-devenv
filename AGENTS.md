# Agent guide — systemc-devenv

This repository is a **SystemC development template**, not a product IP repo.
Do not add domain-specific specs, requirements, or IP content here.

## New chat

Copy the prompt from [docs/agents/CHAT_INIT.md](docs/agents/CHAT_INIT.md) into a
fresh Cursor chat to initialize the session.

## Read first

1. [docs/PLANNING.md](docs/PLANNING.md) — locked decisions and template milestones
2. [docs/agents/GETTING_STARTED.md](docs/agents/GETTING_STARTED.md) — build flow and conventions

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

- Generic template only — no product specs, requirement IDs, or `todo/` content
- CI (`.github/`) changes are deferred unless trivial
- Ask before large structural changes not listed in PLANNING.md
