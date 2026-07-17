# Model development stages

> TEMPLATE NOTE: This guide is reusable across product repos created from this template.
> After **"Use this template"**, keep it and replace example placeholders with your IP/block
> names. Do not add product-specific stage status tables to upstream `systemc-devenv`.

A reusable progression for building a **Specification-First** cycle-accurate SystemC model
of a hardware subsystem. Stages are ordered; each stage should leave the repo **building,
testable, and traceable** before deepening behavior.

This guide is subsystem-agnostic. Use the example column as a pattern, not as required
content for every product.

---

## Stage 0 — Repository and spec foundation

**Goal:** Executable collateral infrastructure exists; authoritative spec is reachable in git.

| Deliverable | Example |
|-------------|---------|
| Product repo from SystemC template | GitHub **"Use this template"** → product repo |
| Spec location + REQ-ID convention | [../spec/README.md](../spec/README.md) |
| Optional two-layer layout (`import/` + section indexes) | `docs/spec/import/`, `docs/spec/architecture/` |
| Gap / divergence tracker | [../gaps/GAPS.md](../gaps/GAPS.md) |
| Build + test harness | `make build-prep`, `make test` |

**Exit criteria:** CMake builds; at least one smoke or placeholder test passes; how to obtain
or update the authoritative spec is documented.

---

## Stage 1 — Spec baseline (import or author)

**Goal:** Versioned, reviewable specification content in git (authored here or mirrored from
an external HAS such as Confluence).

| Activity | Notes |
|----------|-------|
| Establish source of truth | This repo, Confluence, or another system — document in `docs/spec/README.md` |
| If mirroring externally | Stable file key (e.g. `{pageId}-{slug}.md`); snapshot ID + provenance headers |
| Section indexes | Link to authoritative text; assign `REQ-…` IDs; avoid duplicating prose |
| Diagrams / attachments | Store under a predictable path; keep a manifest if needed |

**Exit criteria:** P0/P1 requirements are reachable offline; indexes point at live content;
provenance (version / snapshot) is recorded when content is imported.

**Anti-patterns:** Hand-editing import mirrors; copying large spec prose into indexes.

---

## Stage 2 — Layer A: structural skeleton

**Goal:** Model hierarchy and top-level ports match the architecture **without** implementing
block behavior yet.

| Activity | Notes |
|----------|-------|
| Define width/type constants from interfaces | Shared header(s) under the model tree |
| Create port bundles as `SC_MODULE` wrappers | Group related signals/protocols |
| Instantiate subsystems under a top module | Mirror architectural decomposition |
| Add empty major-block shells | Named modules with little or no behavior |
| Wire reset / clock and tie off unused inputs | Inert defaults so elaboration succeeds |
| Elaboration test | Top module constructs and `sc_start(SC_ZERO_TIME)` |

**Exit criteria:** Top module elaborates; architecture index maps blocks → SystemC modules;
no silent missing hierarchy vs the overview architecture.

**Do not skip Layer A** — a wrong hierarchy is expensive to fix later.

---

## Stage 3 — Layer B: cross-cutting baseline behavior

**Goal:** First **REQ-** IDs backed by spec, model, and tests.

| Activity | Notes |
|----------|-------|
| Pick a narrow, testable requirement | Reset/power-on defaults are often a good first slice |
| Implement minimal behavior in the owning block | Prefer one block over scattering logic |
| Add GTest with spec citation | Test name or header cites `REQ-…` + spec path/section |
| Log intentional deferrals in GAPS | Timing detail, FSMs, secondary paths, etc. |

**Exit criteria:** At least one requirement is green end-to-end; gaps document what remains.

---

## Stage 4 — Layer C: subsystem behavior

**Goal:** FSMs, datapaths, and register effects inside each subsystem.

| Activity | Notes |
|----------|-------|
| Prioritize by critical path | Boot / config / safety paths first |
| Model register map slices | Tie to the product memory map |
| Connect subsystems through interconnect shells | Flesh out protocols when detail lands |
| Expand tests per subsystem | One test file cluster per SS or REQ group |

**Exit criteria:** Priority scenarios from the behavior spec have corresponding tests (pass or
explicit `GAPS` deferral).

---

## Stage 5 — Layer D: interfaces and integration

**Goal:** Cycle-accurate boundary behavior and chip-level (or SoC) integration.

| Activity | Notes |
|----------|-------|
| Bus / streaming BFMs | Replace tie-offs with protocol-accurate drivers |
| Export ports for external testbench | Prefer top-level ports over internal probes |
| Co-simulation hooks if required | Adjacent IP, debug, analog handshakes |
| Coverage of interface timing | REQ IDs from interfaces + programming-flow specs |

**Exit criteria:** Top-level ports exercised by tests or a reference testbench; tie-offs
removed for modeled interfaces.

---

## Stage 6 — Maturity and maintenance

**Goal:** Collateral stays synchronized as the authoritative spec evolves.

| Activity | Notes |
|----------|-------|
| Re-import or revise on spec change | New snapshot / version; update indexes and tests |
| Architectural review | [ARCHITECTURAL_REVIEW.md](ARCHITECTURAL_REVIEW.md) |
| Close or defer gaps | [../gaps/GAPS.md](../gaps/GAPS.md) |
| Promote template improvements upstream | [../upstream/LEARNINGS.md](../upstream/LEARNINGS.md) |

---

## Traceability pattern (all stages)

```
Authoritative specification (Confluence, git, …)
    ↓ (optional import mirror)
docs/spec/import/…  or  docs/spec/…
    ↓ index + REQ-…-NNN
docs/spec/{section}/README.md
    ↓ implements
model/views/cycle_accurate/...
    ↓ verifies
verification/systemc/...
    ↓ divergence
docs/gaps/GAPS.md
```

Every behavioral test should cite **REQ ID + spec path + section** in a comment header.

---

## Sizing guidance

| Stage | Typical effort signal |
|-------|----------------------|
| 0–1 | Days |
| 2 | Days to ~2 weeks (hierarchy size) |
| 3 | Days per REQ |
| 4–5 | Weeks–months |
| 6 | Ongoing |

Stages can overlap slightly (e.g. one subsystem at Layer C while others remain Layer A), but
keep Layer A correct before deep behavior work.

---

## Related

- [GETTING_STARTED.md](GETTING_STARTED.md) — build and layout
- [ARCHITECTURAL_REVIEW.md](ARCHITECTURAL_REVIEW.md) — consistency review
- [../PLANNING.md](../PLANNING.md) — product milestones (customize after Use this template)
- [../spec/README.md](../spec/README.md) — specification conventions
- [../gaps/GAPS.md](../gaps/GAPS.md) — divergence tracker
- [../upstream/README.md](../upstream/README.md) — feeding improvements back to this template
