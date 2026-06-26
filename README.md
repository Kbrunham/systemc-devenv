# systemc-devenv

Reusable GitHub template for SystemC model development.

Derived from [cpp-devenv](https://github.com/Kbrunham/cpp-devenv). Provides build
infrastructure, a DevContainer, directory layout for models and verification, and a
hello-world SystemC model with a GoogleTest smoke test.

## What's included

- **SystemC 3.0.2** — Makefile fetch/build, install prefix `./systemc`
- **Boost 1.86.0** — Makefile fetch/build, install prefix `./boost`
- **GoogleTest** — in-tree under `extern/googletest`
- **CMake 3.24+** — model library, executable, smoke test, optional coverage
- **DevContainer** — `mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04`

## Quick start

```bash
make prepare-tools
cmake -B build
cmake --build build
ctest --test-dir build
```

See [docs/developer/getting-started.md](docs/developer/getting-started.md) for local
setup details. For Cursor agents: copy the prompt from
[docs/agents/CHAT_INIT.md](docs/agents/CHAT_INIT.md) into a new chat, or read
[docs/agents/GETTING_STARTED.md](docs/agents/GETTING_STARTED.md) for reference.

## Directory layout

```
model/views/
  cycle_accurate/     # primary sc_module style (hello-world in v1)
  loosely_timed/      # placeholder
  approximately_timed/ # placeholder
verification/systemc/smoke/   # GTest smoke test
```

Locked decisions and milestones: [docs/PLANNING.md](docs/PLANNING.md).

## License

MIT — see [LICENSE](LICENSE).
