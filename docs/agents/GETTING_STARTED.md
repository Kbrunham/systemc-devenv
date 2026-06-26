# Getting started (agents)

## Purpose

**systemc-devenv** is a reusable template for SystemC model work. Product repos
(e.g. spi-systemc-model) are created via GitHub "Use this template".

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
model/views/cycle_accurate/   # hello sc_module (Milestone 1)
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
- **Do not** add SPI/IP-specific specs or requirements here

## Style

```bash
make style-check-clang   # requires venv from prepare-tools
make style-format-clang
```

## Reference

Full decisions and milestones: [../PLANNING.md](../PLANNING.md)
