# Getting started (agents)

## Purpose

Full mission, scope, and agent rules: **[../PRIME_DIRECTIVE.md](../PRIME_DIRECTIVE.md)**.

**systemc-devenv** is a reusable template for SystemC model work. Create a product
repository for your IP via GitHub **"Use this template"**. After instantiating a product
repo, delete or replace the template notes in `AGENTS.md` and
`docs/PRIME_DIRECTIVE.md` with the concrete IP/block scope.

## Build sequence

```bash
make prepare-tools   # venv + boost + systemc (first time; network required)
cmake -B build
cmake --build build
ctest --test-dir build
```

`prepare-tools` installs pinned dependencies into the repo root:

| Target | Output |
|--------|--------|
| `venv/` | Python venv (clang-format, etc.) |
| `boost/` | Boost 1.86.0 headers/libs |
| `systemc/` | SystemC 3.0.2 headers/lib |

Set `SYSTEMC_HOME` and `BOOST_ROOT` to these paths when configuring CMake outside
the Makefile defaults (CMakeLists sets sensible defaults relative to the repo root).

## Layout

```
docs/spec/README.md           # product spec scaffold (customize after Use this template)
docs/gaps/GAPS.md             # divergence tracker scaffold
docs/upstream/                # template feedback workflow + LEARNINGS log
model/views/cycle_accurate/   # hello sc_module
model/views/loosely_timed/    # stub
model/views/approximately_timed/ # stub
verification/systemc/smoke/   # GTest smoke test
extern/googletest/            # in-tree GTest
extern/cmake_helpers/         # project_add_test macro
```

## Work classification

| Class | Examples |
|-------|----------|
| **Template infrastructure** | Makefile, DevContainer, generic CMake, hello-world, agent docs |
| **Product/IP** | Specs under `docs/spec/`, model behavior, `REQ-` tests, gaps |
| **Upstream feedback** | Reusable friction → `docs/upstream/LEARNINGS.md`, then PR the template |

## Conventions

- **C++17**, `sc_module` + signals for cycle-accurate models
- **CMake:** `cmake_minimum_required(VERSION 3.24)`, `CMAKE_EXPORT_COMPILE_COMMANDS ON`
- **Coverage:** `-DENABLE_COVERAGE=ON` for gcov/lcov (optional)
- In upstream `systemc-devenv`, do not add domain-specific specs, `REQ-` IDs, or product TODOs
- In a product repo, customize [../spec/README.md](../spec/README.md) and track divergence in
  [../gaps/GAPS.md](../gaps/GAPS.md)

## Style

All C/C++ files tracked by git must pass clang-format before submission (CI runs
`make style-check-clang`). Agents must format any C/C++ they create or edit:

```bash
make style-format-clang   # apply .clang-format
make style-check-clang    # verify (requires venv from prepare-tools)
```

## Reference

| Document | Purpose |
|----------|---------|
| [PRIME_DIRECTIVE.md](../PRIME_DIRECTIVE.md) | Why this repo exists; agent rules |
| [PLANNING.md](../PLANNING.md) | Locked technical decisions |
| [spec/README.md](../spec/README.md) | Product specification scaffold |
| [gaps/GAPS.md](../gaps/GAPS.md) | Divergence tracker scaffold |
| [upstream/README.md](../upstream/README.md) | Template feedback workflow |
