# systemc-devenv — Template decisions

Locked technical choices and layout for this reusable SystemC development template.
For **why this repo exists** and agent scope rules, read [PRIME_DIRECTIVE.md](PRIME_DIRECTIVE.md)
first. This file records **how** the template is built, not the full mission statement.

## Purpose

**systemc-devenv** is a generic GitHub template for SystemC model development.
Use GitHub **"Use this template"** to create a new repo for your IP (SPI controller,
UART, custom block, etc.) and add domain content there.

See [PRIME_DIRECTIVE.md](PRIME_DIRECTIVE.md) and [TEMPLATE_VS_PRODUCT.md](TEMPLATE_VS_PRODUCT.md)
for what belongs in this repo vs a product repository.

This template provides:

- Build infrastructure (CMake, Makefile-managed deps)
- DevContainer
- Directory layout for models and verification
- Hello-world SystemC model + GTest smoke test
- Generic agent/developer documentation

## Locked technical decisions

| Item | Choice |
|------|--------|
| SystemC | **3.0.2** — Makefile fetch/build, install prefix `$(REPO_ROOT)/systemc` |
| Boost | **1.86.0** — same Makefile pattern as cpp-devenv, prefix `$(REPO_ROOT)/boost` |
| C++ standard | **C++17** |
| CMake (tool) | Use CMake from devcontainer image (Ubuntu 24.04 → **3.28**) |
| `cmake_minimum_required` | **3.24** (do not require 4.x in project CMakeLists) |
| DevContainer base | `mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04` |
| Tests | GoogleTest (in-tree `extern/googletest`) |
| Coverage | Optional `ENABLE_COVERAGE` (gcov/lcov), documented |
| Primary model style | `sc_module` + signals (cycle-accurate view) |
| Other timing views | `loosely_timed/`, `approximately_timed/` — placeholders only in v1 |
| CI/CD | **Deferred** for v1 |
| License | MIT |

## Dependency strategy

**Makefile-managed, version-pinned** (cpp-devenv pattern):

- `make boost` — download, build, install to `boost/`
- `make systemc` — download Accellera 3.0.2, CMake build, install to `systemc/`
- `make prepare-tools` — `venv` + `boost` + `systemc` (on demand; not run at container create)

Gitignore: `boost/`, `systemc/`, `work/`, `venv/`, build dirs.

Environment for CMake:

- `SYSTEMC_HOME=$(REPO_ROOT)/systemc`
- `BOOST_ROOT` / `BOOST_ROOTDIR` per Makefile

## Directory layout

```
systemc-devenv/
├── AGENTS.md
├── README.md
├── Makefile
├── CMakeLists.txt
├── docs/
│   ├── PRIME_DIRECTIVE.md            # mission, scope, agent rules (read first)
│   ├── TEMPLATE_VS_PRODUCT.md        # template vs product scope
│   ├── PLANNING.md                   # this file
│   ├── developer/getting-started.md
│   └── agents/
│       ├── GETTING_STARTED.md
│       └── CHAT_INIT.md
├── model/
│   └── views/
│       ├── cycle_accurate/           # hello sc_module
│       ├── loosely_timed/            # README stub
│       └── approximately_timed/      # README stub
├── verification/
│   └── systemc/smoke/                # GTest smoke test
├── extern/                           # googletest, cmake_helpers
└── .devcontainer/
```

## Milestone 1 (template complete)

- [x] README renamed for systemc-devenv
- [x] Makefile: `systemc` target + `prepare-tools` includes systemc
- [x] `.gitignore`: systemc/, boost/, work/, venv/
- [x] Devcontainer: `ubuntu-24.04`, deps built on demand
- [x] CMake: find SystemC, build model lib/exe, GTest smoke test, `ENABLE_COVERAGE`
- [x] `CMAKE_EXPORT_COMPILE_COMMANDS ON`
- [x] Hello `sc_module` in `model/views/cycle_accurate/`
- [x] Smoke test passes: `make prepare-tools && cmake -B build && cmake --build build && ctest --test-dir build`
- [x] Generic `AGENTS.md` + `docs/agents/GETTING_STARTED.md`
- [x] `docs/PRIME_DIRECTIVE.md` + `docs/TEMPLATE_VS_PRODUCT.md`
- [x] Product-repo scaffold notes in `AGENTS.md` and `docs/PRIME_DIRECTIVE.md`
- [ ] Tag e.g. `v0.1.0`
- [ ] Enable "Template repository" on GitHub

## Using this template

1. Enable **"Template repository"** on GitHub (if maintaining the template itself)
2. Create your product repo via **"Use this template"**
3. Add IP-specific docs, specs, models, and tests in the new repo

## Provenance

Derived from [cpp-devenv](https://github.com/Kbrunham/cpp-devenv) via GitHub "Use this template".
