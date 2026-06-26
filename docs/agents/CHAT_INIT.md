# New chat — copy-paste prompt

Open a new agent chat, copy the block below, and send it as your first message.

```
Read these files to get up to speed with this repo:

1. docs/PRIME_DIRECTIVE.md — mission, scope, template vs product, agent rules
2. AGENTS.md — quick reference and locked choices
3. docs/PLANNING.md — locked technical decisions and template milestones
4. docs/agents/GETTING_STARTED.md — build flow and conventions

This is **systemc-devenv**, a generic SystemC development template (not a product IP repo).
Before making changes, state whether the work is template infrastructure (allowed here)
or product IP (belongs in a derived repo created via "Use this template").

Locked stack (do not change without updating PLANNING.md):
- SystemC 3.0.2 → ./systemc (make systemc)
- Boost 1.86.0 → ./boost (make boost)
- C++17, CMake 3.24+, GoogleTest in extern/googletest
- DevContainer: mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04

Code layout:
- Models: model/views/<timing_view>/ (primary work in cycle_accurate/)
- Tests: verification/systemc/ (GTest via project_add_test)
- Build: root CMakeLists.txt, deps via root Makefile

Verify changes:
make prepare-tools && cmake -B build && cmake --build build && ctest --test-dir build

Confirm you have read the docs and understand this is a template repo, not a product IP repo.
```

## After pasting

The agent should acknowledge the repo context and whether planned work belongs in this
template or a downstream product repo. For ongoing reference, see
[GETTING_STARTED.md](GETTING_STARTED.md), [PRIME_DIRECTIVE.md](../PRIME_DIRECTIVE.md), and
[AGENTS.md](../../AGENTS.md).
