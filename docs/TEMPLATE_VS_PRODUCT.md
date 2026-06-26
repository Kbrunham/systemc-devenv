# Template vs product repository

Use this page to decide **where work belongs**.

## systemc-devenv (this repository)

**Role:** Reusable GitHub template — build infrastructure and conventions only.

**Prime directive:** Provide a reproducible SystemC modeling workspace that product repos
inherit via "Use this template."

**Typical changes:**

- Makefile and dependency pins (SystemC, Boost)
- DevContainer and CMake configuration
- Directory layout under `model/views/` and `verification/`
- Hello-world or pattern models that demonstrate the template
- Generic documentation for agents and developers

**Do not add:**

- IP specifications (`docs/spec/`)
- Requirement IDs (`REQ-…`)
- Product `todo/ARCHITECTURAL.md` or gap tracking for a specific design
- RTL, golden vectors, or test plans for a specific chip/block

## Product repository (e.g. spi-systemc-model)

**Role:** A specific IP — specification, executable model, and verification aligned.

**Prime directive:** Maintain synchronized **Markdown specification** and **SystemC model**,
with **tests** as the executable check. When spec, model, or tests disagree, record the
gap in `todo/ARCHITECTURAL.md` until all three agree.

**Typical changes:**

- Specification sections under `docs/spec/`
- Model implementation under `model/views/`
- Tests mapped to requirements (`REQ-…`) in `verification/` and `docs/test-plan/`
- Architectural and development TODOs under `todo/`
- Product-specific `docs/PRIME_DIRECTIVE.md`

**Inherits from template:**

- Makefile dependency pattern
- DevContainer approach
- `model/views/` and `verification/` layout
- CMake + GoogleTest patterns

## Quick decision guide

| Question | systemc-devenv | Product repo |
|----------|----------------|--------------|
| Does this describe **how to build** SystemC models in general? | Yes | No |
| Does this describe **what the IP does**? | No | Yes |
| Is this a **REQ-** requirement or spec section? | No | Yes |
| Is this a **hello-world / pattern** example? | Yes | Only if demonstrating product structure |
| Should this change **Boost/SystemC versions** for all template users? | Yes | Rarely (document if overriding) |

When in doubt, ask: **"Would every IP project need this?"** If no, it belongs in the product repo.
