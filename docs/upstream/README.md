# Upstream template relationship

> TEMPLATE NOTE: In upstream `systemc-devenv`, this document describes the feedback pattern
> for **product repos** created from the template. After **"Use this template"**, add a git
> remote named `upstream` pointing at this template and use [LEARNINGS.md](LEARNINGS.md) to
> propose reusable improvements.

Product repos inherit build infrastructure and conventions from **systemc-devenv**.

## Remotes (product repo)

```bash
git remote -v
# origin    …/<your-product-repo>.git          (this product repo)
# upstream  …/<template-org-or-user>/systemc-devenv.git  (this template, or your fork)
```

Fetch upstream changes when the template improves:

```bash
git fetch upstream
git log HEAD..upstream/main --oneline   # see what landed upstream
```

Merge or cherry-pick template updates deliberately — resolve conflicts in favor of
product content where the paths diverge (spec, model, tests).

## What belongs where

| Artifact | Product repo (`origin`) | Template (`upstream`) |
|----------|-------------------------|------------------------|
| Product specification | `docs/spec/` | — (scaffold only) |
| Product SystemC model | `model/views/` | hello-world / generic examples |
| Product verification tests | `verification/systemc/` | smoke / generic examples |
| Spec/model/test gaps | `docs/gaps/GAPS.md` | — (scaffold only) |
| Modeling learnings for the template | `docs/upstream/LEARNINGS.md` → PR upstream | merged into template |
| Makefile, DevContainer, generic CMake | inherited; patch here only when needed | canonical home |

## Feedback workflow

1. **Discover** — While modeling or verifying, notice friction (build, layout, docs, CMake,
   agent prompts, missing patterns).
2. **Log** — Add an entry to [LEARNINGS.md](LEARNINGS.md) with context and a proposed
   upstream change.
3. **Validate** — Confirm the learning is generic (applies beyond this product), not
   product-specific.
4. **Promote** — Open a PR against `upstream` (systemc-devenv) or implement on a branch
   based on `upstream/main`.
5. **Close the loop** — Update the LEARNINGS entry status; after merge, fetch/merge
   upstream into the product repo and remove temporary local workarounds.

## Promoting a learning upstream

Before opening an upstream PR, check:

- [ ] The change is reusable template infrastructure, not product/IP behavior.
- [ ] The LEARNINGS entry describes the problem, proposed fix, and evidence.
- [ ] Any product-repo-only workaround is documented until upstream absorbs the fix.

Upstream PRs should reference the LEARNINGS entry (by ID) when possible.
