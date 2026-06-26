# New chat — copy-paste prompt

Open a new agent chat, copy the block below, and send it as your first message.

```
Read these files to get up to speed with this repo:

1. docs/PRIME_DIRECTIVE.md — mission, scope, executable-spec rules, agent rules
2. AGENTS.md — quick reference and locked choices
3. docs/PLANNING.md — technical decisions and milestones
4. docs/agents/GETTING_STARTED.md — build flow and conventions

This repo may be either:
- upstream **systemc-devenv**, the generic SystemC development template
- a product/IP repo created from systemc-devenv via GitHub "Use this template"

Before making changes, state whether the work is template infrastructure or product/IP work.
If this is upstream systemc-devenv, do not add product/IP content. If this is a product
repo, keep the Markdown specification, SystemC model, and verification tests synchronized.

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
make style-check-clang

Format C/C++ before submitting: make style-format-clang (required for CI).

Confirm you have read the docs and understand whether this checkout is the upstream
template repo or a product/IP repo created from it.
```

## After pasting

The agent should acknowledge the repo context and classify the planned work as template
infrastructure or product/IP work. For ongoing reference, see
[GETTING_STARTED.md](GETTING_STARTED.md), [PRIME_DIRECTIVE.md](../PRIME_DIRECTIVE.md), and
[AGENTS.md](../../AGENTS.md).
