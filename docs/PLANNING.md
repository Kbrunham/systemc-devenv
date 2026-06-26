# systemc-devenv — Planning (handoff from spi-systemc-model design sessions)

This document captures decisions made while planning **spi-systemc-model**.
Read this before making structural changes to this template repo.

## Purpose of this repo

**systemc-devenv** is a reusable GitHub template for SystemC model development.
When the template reaches hello-world milestone, **spi-systemc-model** will be
recreated via "Use this template" and SPI-specific content added there.

This repo is **not** the SPI IP repo. It provides:

- Build infrastructure (CMake, Makefile-managed deps)
- DevContainer
- Directory layout for models and verification
- Hello-world SystemC model + GTest smoke test
- Generic agent/developer documentation

## Downstream: spi-systemc-model prime directive

The SPI product repo will maintain:

1. Markdown specification (human-readable)
2. SystemC model (executable specification)
3. Tests that keep spec and model aligned

Gaps → `todo/ARCHITECTURAL.md` with `REQ-` requirement IDs.
That content belongs in **spi-systemc-model**, not here (except generic patterns).

## Locked technical decisions

| Item | Choice |
|------|--------|
| SystemC | **3.0.2** — Makefile fetch/build, install prefix `$(REPO_ROOT)/systemc` |
| Boost | **1.86.0** — same Makefile pattern as cpp-devenv, prefix `$(REPO_ROOT)/boost` |
| C++ standard | **C++17** |
| CMake (tool) | Use CMake from devcontainer image (Ubuntu 26.04 → **4.2.3**) |
| `cmake_minimum_required` | **3.24** (do not require 4.x in project CMakeLists) |
| DevContainer base | `mcr.microsoft.com/devcontainers/cpp:3-ubuntu26.04` |
| Tests | GoogleTest (in-tree `extern/googletest`) |
| Coverage | Optional `ENABLE_COVERAGE` (gcov/lcov), documented |
| Primary model style | `sc_module` + signals (cycle-accurate view) |
| Other timing views | `loosely_timed/`, `approximately_timed/` — placeholders only in v1 |
| CI/CD | **Deferred** until hello-world works locally |
| License | MIT |

## Dependency strategy

**Makefile-managed, version-pinned** (cpp-devenv pattern):

- `make boost` — download, build, install to `boost/`
- `make systemc` — download Accellera 3.0.2, CMake build, install to `systemc/`
- `make prepare-tools` — `venv` + `boost` + `systemc`
- `postCreateCommand` in devcontainer: `make prepare-tools`

Gitignore: `boost/`, `systemc/`, `work/`, `venv/`, build dirs.

Environment for CMake:

- `SYSTEMC_HOME=$(REPO_ROOT)/systemc`
- `BOOST_ROOT` / `BOOST_ROOTDIR` per Makefile

## Target directory layout

```
systemc-devenv/
├── AGENTS.md
├── README.md
├── Makefile                          # extend cpp-devenv (+ systemc target)
├── CMakeLists.txt                    # SystemC + GTest + coverage option
├── docs/
│   ├── PLANNING.md                   # this file
│   ├── developer/getting-started.md
│   └── agents/GETTING_STARTED.md
├── model/
│   └── views/
│       ├── cycle_accurate/           # hello sc_module (Milestone 1)
│       ├── loosely_timed/            # README stub
│       └── approximately_timed/      # README stub
├── verification/
│   └── systemc/smoke/                # GTest smoke test
├── extern/                           # googletest, cmake_helpers (from cpp-devenv)
└── .devcontainer/                    # ubuntu26.04, postCreateCommand
```

Remove or relocate cpp-devenv sample `main.cpp` / `test_main.cpp` at repo root.

## Milestone 1 (template complete)

- [ ] README renamed for systemc-devenv
- [ ] Makefile: `systemc` target + `prepare-tools` includes systemc
- [ ] `.gitignore`: systemc/, boost/, work/, venv/
- [ ] Devcontainer: `3-ubuntu26.04`, `postCreateCommand: make prepare-tools`
- [ ] CMake: find SystemC, build model lib/exe, GTest smoke test, `ENABLE_COVERAGE`
- [ ] `CMAKE_EXPORT_COMPILE_COMMANDS ON`
- [ ] Hello `sc_module` in `model/views/cycle_accurate/`
- [ ] Smoke test passes: `make prepare-tools && cmake -B build && cmake --build build && ctest --test-dir build`
- [ ] Generic `AGENTS.md` + `docs/agents/GETTING_STARTED.md`
- [ ] Tag e.g. `v0.1.0`
- [ ] Enable "Template repository" on GitHub

## Implementation order (suggested commits)

1. **Docs + layout** — README, PLANNING.md, AGENTS.md, directory placeholders, .gitignore
2. **Makefile + devcontainer** — systemc target, ubuntu26.04 image
3. **CMake + hello model + smoke test** — remove root main.cpp pattern
4. **Verify in devcontainer** — full prepare-tools → ctest flow

## After template is ready

1. Enable GitHub "Template repository" on systemc-devenv
2. Recreate spi-systemc-model via "Use this template"
3. First commits in spi-systemc-model: `docs/PRIME_DIRECTIVE.md`, `todo/*`, spec skeleton

## Provenance

Derived from [cpp-devenv](https://github.com/Kbrunham/cpp-devenv) via GitHub "Use this template".
