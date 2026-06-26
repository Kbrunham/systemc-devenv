# systemc-devenv

Reusable GitHub template for SystemC model development.

Derived from [cpp-devenv](https://github.com/Kbrunham/cpp-devenv). Provides build
infrastructure, a DevContainer, directory layout for models and verification, and a
hello-world SystemC model with a GoogleTest smoke test.

## Why this repo?

**systemc-devenv** is a **template**, not a product IP repository. It exists so you can
create product repos (for example, `spi-systemc-model`) with reproducible SystemC tooling,
a standard layout, and clear agent conventions.

Read **[docs/PRIME_DIRECTIVE.md](docs/PRIME_DIRECTIVE.md)** for the full mission, what
belongs here vs in a product repo, and how agents should work. See also
[docs/TEMPLATE_VS_PRODUCT.md](docs/TEMPLATE_VS_PRODUCT.md).

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
setup details. For agents: read [docs/PRIME_DIRECTIVE.md](docs/PRIME_DIRECTIVE.md) first,
or copy the prompt from [docs/agents/CHAT_INIT.md](docs/agents/CHAT_INIT.md) into a new chat.

## Directory layout

```
model/views/
  cycle_accurate/     # primary sc_module style (hello-world in v1)
  loosely_timed/      # placeholder
  approximately_timed/ # placeholder
verification/systemc/smoke/   # GTest smoke test
```

Locked technical decisions: [docs/PLANNING.md](docs/PLANNING.md).

## License

MIT — see [LICENSE](LICENSE).
