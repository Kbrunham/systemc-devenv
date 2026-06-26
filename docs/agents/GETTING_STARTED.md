# Getting started (agents)

## Purpose

Full mission, scope, and agent rules: **[../PRIME_DIRECTIVE.md](../PRIME_DIRECTIVE.md)**.

**systemc-devenv** is a reusable template for SystemC model work. Create a product
repository for your IP via GitHub **"Use this template"**. After instantiating a product
repo, delete or replace the template notes in `AGENTS.md` and
`docs/PRIME_DIRECTIVE.md` with the concrete IP/block scope.

Unsure where work belongs? See [../TEMPLATE_VS_PRODUCT.md](../TEMPLATE_VS_PRODUCT.md).

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
model/views/cycle_accurate/   # hello sc_module
model/views/loosely_timed/    # stub
model/views/approximately_timed/ # stub
verification/systemc/smoke/   # GTest smoke test
extern/googletest/            # in-tree GTest
extern/cmake_helpers/         # project_add_test macro
```

## Conventions

- **C++17**, `sc_module` + signals for cycle-accurate models
- **CMake:** `cmake_minimum_required(VERSION 3.24)`, `CMAKE_EXPORT_COMPILE_COMMANDS ON`
- **Coverage:** `-DENABLE_COVERAGE=ON` for gcov/lcov (optional)
- In upstream `systemc-devenv`, do not add domain-specific specs, `REQ-` IDs, or product TODOs
- In a product repo, add those artifacts according to that repo's prime directive

## Style

```bash
make style-check-clang   # requires venv from prepare-tools
make style-format-clang
```

## Reference

| Document | Purpose |
|----------|---------|
| [PRIME_DIRECTIVE.md](../PRIME_DIRECTIVE.md) | Why this repo exists; agent rules |
| [PLANNING.md](../PLANNING.md) | Locked technical decisions |
| [TEMPLATE_VS_PRODUCT.md](../TEMPLATE_VS_PRODUCT.md) | Template vs product scope |
