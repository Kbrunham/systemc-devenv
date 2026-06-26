# New chat — copy-paste prompt

Open a new Cursor chat, copy the block below, and send it as your first message.

```
Read these files to get up to speed with this repo:

1. AGENTS.md — scope, locked choices, where code lives
2. docs/PLANNING.md — milestones and structural decisions
3. docs/agents/GETTING_STARTED.md — build flow and conventions

This is **systemc-devenv**, a generic SystemC development template (not a product IP repo).
Do not add SPI specs, REQ- IDs, or other domain-specific content here.

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

Confirm you have read the docs and are ready to work in this repo.
```

## After pasting

The agent should acknowledge the repo context before you assign work. For ongoing
reference, see [GETTING_STARTED.md](GETTING_STARTED.md) and [AGENTS.md](../../AGENTS.md).
