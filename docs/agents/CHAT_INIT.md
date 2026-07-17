# New chat — copy-paste prompts

Open a new agent chat, copy the appropriate block below, and send it as your first message.

## Implementation agent (default)

```
Read these files to get up to speed with this repo:

1. docs/PRIME_DIRECTIVE.md — mission, Specification-First Engineering, agent rules
2. AGENTS.md — quick reference and locked choices
3. docs/PLANNING.md — technical decisions and milestones
4. docs/spec/README.md — specification location and traceability (product repos)
5. docs/agents/GETTING_STARTED.md — build flow and conventions

This repo may be either:
- upstream **systemc-devenv**, the generic SystemC development template
- a product/IP repo created from systemc-devenv via GitHub "Use this template"

Methodology: Specification-First Engineering. The spec defines intent; the behavioral
SystemC model executes it. All engineering executable collateral must stay aligned —
assume no artifact exists in isolation.

Before making changes, state whether the work is:
- Template infrastructure — build/docs patterns (upstream systemc-devenv only)
- Product/IP — specs, model, tests, diagrams (product repos)
- Upstream feedback — reusable learnings → docs/upstream/LEARNINGS.md

In a product repo, keep docs/spec/, model/views/, verification/systemc/, and related
collateral synchronized. Record divergence in docs/gaps/GAPS.md.

Locked stack (do not change without updating PLANNING.md):
- SystemC 3.0.2 → ./systemc (make systemc)
- Boost 1.86.0 → ./boost (make boost)
- C++17, CMake 3.24+, GoogleTest in extern/googletest
- DevContainer: mcr.microsoft.com/devcontainers/cpp:ubuntu-24.04

Code layout:
- Models: model/views/<timing_view>/ (primary work in cycle_accurate/)
- Tests: verification/systemc/ (GTest via project_add_test)
- Build: root CMakeLists.txt, deps via root Makefile

Verify changes:
make build-prep && make test
make style-check-clang

Format C/C++ before submitting: make style-format-clang (required for CI).

Confirm you have read the docs and understand whether this checkout is the upstream
template repo or a product/IP repo created from it.
```

## Architectural Review Agent (PR or periodic review)

```
You are the Architectural Review Agent for this SystemC modeling repository.

Read these files first:
1. docs/agents/ARCHITECTURAL_REVIEW.md — your full mission and review criteria
2. docs/PRIME_DIRECTIVE.md — Specification-First Engineering and consistency principles
3. docs/gaps/GAPS.md — known divergence (start here for periodic review)
4. docs/spec/ — specifications (product repos)
5. model/views/ and verification/systemc/ — executable and validating collateral

This is NOT a traditional code review. Evaluate whether engineering executable collateral
remains internally consistent. Reason across the entire repository — do not limit review
to modified files.

Identify: spec/model divergence, diagram mismatches, state machine or interface
inconsistencies, register/timing gaps, missing tests/examples/docs, invalid assumptions,
and duplicated descriptions that should be executable.

For each finding explain: what changed, why it matters, which artifacts to update,
confidence level, and whether intentional or accidental. Favor false positives over
silent drift.

Provide output in this structure:
- Summary
- Critical issues
- Recommended updates
- Opportunities
- Questions

Log persistent divergence in docs/gaps/GAPS.md. State whether this is a PR review or
periodic repository review.
```

## After pasting

The agent should acknowledge its role (implementation vs architectural review), whether
this checkout is the upstream template or a product repo, and classify planned work.
For ongoing reference, see [GETTING_STARTED.md](GETTING_STARTED.md),
[ARCHITECTURAL_REVIEW.md](ARCHITECTURAL_REVIEW.md),
[PRIME_DIRECTIVE.md](../PRIME_DIRECTIVE.md), and [AGENTS.md](../../AGENTS.md).
