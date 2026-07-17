# Engineering collateral divergence tracker

> TEMPLATE NOTE: After **"Use this template"**, use this file to track divergence for your
> IP/block. Keep entries product-specific; do not add product gaps to upstream
> `systemc-devenv`.

Track places where **engineering executable collateral** for this product **does not yet
agree**. Collateral includes specifications, behavioral models, diagrams, register
definitions, interfaces, tests, examples, generated outputs, documentation, and design
rationale.

Close gaps by updating all affected artifacts or by recording an explicit deferral with
rationale.

## Entry format

```markdown
### GAP-NNN — Short title

- **Status:** open | in-progress | closed | deferred
- **Confidence:** high | medium | low
- **Intentional:** yes | no | unknown
- **REQ IDs:** REQ-… (if applicable)
- **Spec:** path/to/spec.md#section or "missing"
- **Model:** path/to/source or "missing"
- **Test:** path/to/test or "missing"
- **Other collateral:** diagrams, registers, interfaces, generated outputs, rationale (if applicable)
- **Description:** What is wrong or missing?
- **Affected artifacts:** Which collateral should be updated?
- **Resolution:** How to close (or why deferred)
```

## Open gaps

_None yet. Add entries as divergence is discovered._

## Closed gaps

_None yet._
