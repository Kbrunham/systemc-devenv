# Prime directive

> TEMPLATE NOTE: This repository is `systemc-devenv`, the reusable SystemC template.
> While working in this upstream template, make only template infrastructure changes and
> do not add product/IP content. After creating a product repo with GitHub
> **"Use this template"**, delete this note or replace it with the concrete IP/block
> name and remove template-only wording.

This document is the canonical statement of why this repository exists and how agents
and developers should use it. Read this before making changes.

## Mission

This repository maintains **engineering executable collateral** for one concrete IP/block
using **Specification-First Engineering**:

- The written specification defines the engineering intent.
- The behavioral SystemC model is the executable realization of that intent.
- Verification tests, examples, and other collateral validate and communicate that intent.

Neither the specification nor the model is independently authoritative. Engineering intent
is represented collectively by all collateral in this repository. Success means every
artifact describes the same architecture and behavior. When they do not, record the
divergence in [gaps/GAPS.md](gaps/GAPS.md) until all affected artifacts agree.

For upstream `systemc-devenv`, this file is a product-repo scaffold. The upstream
template mission is to provide the pinned dependencies, build/test flow, directory
layout, and agent conventions that product repos inherit.

## Engineering executable collateral

Treat all engineering artifacts as a single system. Collateral includes specifications,
behavioral models, module hierarchy, state machines, diagrams, register and memory-map
definitions, interfaces, generated outputs, tests, examples, documentation, and design
rationale.

**Assume no artifact exists in isolation.** A change to one may require updates elsewhere.

## Architectural consistency principles

| Principle | Requirement |
|-----------|-------------|
| **Single engineering intent** | Every decision is represented consistently across applicable collateral |
| **Executable specification** | Model implements spec; spec describes all observable model behavior |
| **Structural alignment** | SystemC hierarchy follows architectural decomposition; model mirrors architecture (not RTL), transaction-level with preserved boundaries |
| **No silent divergence** | Behavior must not exist in only one artifact; update all affected collateral when intent changes |

Full review criteria and agent instructions:
[agents/ARCHITECTURAL_REVIEW.md](agents/ARCHITECTURAL_REVIEW.md).

## What success looks like

- `make build-prep && make test` passes (alias: `make prepare-tools` then cmake/ctest)
- Product specifications live under [spec/](spec/) (see [spec/README.md](spec/README.md))
- Models live under `model/views/<timing_view>/`
- Tests live under `verification/systemc/`
- Requirement IDs and gaps stay consistent with [spec/README.md](spec/README.md) and
  [gaps/GAPS.md](gaps/GAPS.md)
- No silent divergence across engineering collateral
- Changes keep specification, implementation, tests, and documentation aligned
- Reusable template improvements discovered in product repos are logged in
  [upstream/LEARNINGS.md](upstream/LEARNINGS.md) and promoted upstream when ready
- Pull requests and periodic reviews follow [agents/ARCHITECTURAL_REVIEW.md](agents/ARCHITECTURAL_REVIEW.md)

## Product repository setup

After creating a product repo from this template:

1. Delete or replace the template note at the top of this file and
   [../AGENTS.md](../AGENTS.md) with the concrete IP/block name.
2. Define product scope in this file and [PLANNING.md](PLANNING.md).
3. Customize [spec/README.md](spec/README.md) — specification location, source of truth,
   and `REQ-` ID convention.
4. Use [gaps/GAPS.md](gaps/GAPS.md) for architectural / collateral divergence.
5. Add a git remote named `upstream` pointing at this template; use
   [upstream/README.md](upstream/README.md) and [upstream/LEARNINGS.md](upstream/LEARNINGS.md)
   to feed reusable improvements back.
6. Replace the hello-world model and smoke test with product behavior and tests.
7. Use [agents/ARCHITECTURAL_REVIEW.md](agents/ARCHITECTURAL_REVIEW.md) for PR and
   periodic consistency review (see also the review prompt in
   [agents/CHAT_INIT.md](agents/CHAT_INIT.md)).

## Upstream template boundary

In upstream `systemc-devenv`, do not add product-specific content. Keep changes limited
to reusable template infrastructure and patterns:

- Makefile dependency flow
- DevContainer and CMake patterns
- generic example models and smoke tests
- reusable agent and developer documentation

Product-specific specs, `REQ-` IDs, protocol behavior, product test plans, and
architectural TODOs belong in a repo created from this template.

## Agent roles

| Role | When | Primary doc |
|------|------|-------------|
| **Implementation agent** | Building or changing specs, model, tests, docs | This file, [../AGENTS.md](../AGENTS.md) |
| **Architectural Review Agent** | PR review, periodic repo review, drift detection | [agents/ARCHITECTURAL_REVIEW.md](agents/ARCHITECTURAL_REVIEW.md) |

Implementation agents should reason across collateral before submitting changes. Architectural
Review Agents reason across the full repository, not only modified files.

## Agent rules

1. Before starting, state whether the work is template infrastructure, product/IP work, or
   upstream feedback (see [upstream/README.md](upstream/README.md)).
2. In upstream `systemc-devenv`, extend infrastructure and patterns only.
3. In a product repo, keep all affected engineering collateral aligned.
4. Record unresolved divergence in [gaps/GAPS.md](gaps/GAPS.md).
5. When a change would improve the generic template for all product repos, log it in
   [upstream/LEARNINGS.md](upstream/LEARNINGS.md).
6. A single change may touch docs, model, tests, and build files when needed to keep
   the repository consistent.
7. Locked toolchain versions change only by updating [PLANNING.md](PLANNING.md) with justification.
8. Verify with the standard build sequence and `make style-check-clang` before considering work complete.
9. Run `make style-format-clang` on any C/C++ files you add or edit.
10. For pull requests in product repos, apply architectural consistency review per
    [agents/ARCHITECTURAL_REVIEW.md](agents/ARCHITECTURAL_REVIEW.md).

## Related documentation

| Document | Purpose |
|----------|---------|
| [AGENTS.md](../AGENTS.md) | Short agent entry point |
| [PLANNING.md](PLANNING.md) | Locked technical decisions and milestones |
| [spec/README.md](spec/README.md) | Product specification scaffold |
| [gaps/GAPS.md](gaps/GAPS.md) | Divergence tracker scaffold |
| [upstream/README.md](upstream/README.md) | Template feedback workflow |
| [upstream/LEARNINGS.md](upstream/LEARNINGS.md) | Learnings log for upstream PRs |
| [agents/GETTING_STARTED.md](agents/GETTING_STARTED.md) | Build flow and layout |
| [agents/CHAT_INIT.md](agents/CHAT_INIT.md) | Copy-paste prompts for new agent sessions |
| [agents/ARCHITECTURAL_REVIEW.md](agents/ARCHITECTURAL_REVIEW.md) | Architectural Review Agent |
| [agents/MODEL_DEVELOPMENT_STAGES.md](agents/MODEL_DEVELOPMENT_STAGES.md) | Layer A–D modeling progression |
