# Developer getting started

## Prerequisites

- Linux (DevContainer recommended) or WSL2
- `git`, `make`, `cmake` (3.24+), `g++`, `python3`, `wget`
- Network access for first-time dependency download

## DevContainer (recommended)

1. Open the repo in VS Code / Cursor with Dev Containers
2. Image: `mcr.microsoft.com/devcontainers/cpp:3-ubuntu26.04`
3. `postCreateCommand` runs `make prepare-tools` automatically

## Local setup

From the repository root:

```bash
make prepare-tools
cmake -B build
cmake --build build
ctest --test-dir build
```

### Dependencies

| Component | Version | Location |
|-----------|---------|----------|
| SystemC | 3.0.2 | `./systemc` (`make systemc`) |
| Boost | 1.86.0 | `./boost` (`make boost`) |
| GoogleTest | in-tree | `extern/googletest` |

Environment variables used by CMake (defaults point at repo-local installs):

- `SYSTEMC_HOME` — SystemC install prefix
- `BOOST_ROOT` — Boost install prefix

## Running the hello model

After building:

```bash
./build/hello_systemc
```

Expected output includes `Hello SystemC!` from the cycle-accurate hello module.

## Coverage (optional)

Configure with instrumentation enabled:

```bash
cmake -B build-coverage -DENABLE_COVERAGE=ON
cmake --build build-coverage
ctest --test-dir build-coverage
```

Generate HTML report with lcov (if installed):

```bash
lcov --capture --directory build-coverage --output-file coverage.info
lcov --remove coverage.info '/usr/*' '*/extern/*' --output-file coverage.info
genhtml coverage.info --output-directory coverage-html
```

## Project layout

- `model/views/cycle_accurate/` — primary `sc_module` hello example
- `model/views/loosely_timed/`, `approximately_timed/` — placeholders for other timing styles
- `verification/systemc/smoke/` — smoke test executed by CTest

## Clean

```bash
make clean          # removes venv/ and work/
make dev-clean      # git clean -dfx (destructive; keeps .vscode)
```

Built artifacts: remove `build/` manually or use a fresh build directory.

## Next steps

- Read [PLANNING.md](../PLANNING.md) for template scope and milestones
- Fork via GitHub "Use this template" for product-specific models
