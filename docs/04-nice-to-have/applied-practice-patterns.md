---
layout: default
title: Applied Practice Patterns
nav_order: 7
parent: Nice-to-Have
has_children: true
---

# Applied Practice Patterns

## Why This Matters

Core guidelines should stay stable and high-signal. Teams still need practical examples of how to operate during messy, in-progress work (refactors, staged migrations, temporary suppressions).

An applied-pattern branch keeps those examples available without diluting the core framework.

## What to Include

- **Separation rule** — core rules in must/should/nice docs, implementation recipes in a separate patterns branch
- **Pattern template** — Problem, Value, When to use
- **Temporary-exception policy** — owner, ticket, expiry date, and removal condition
- **Verification loop** — exact command(s) to prove the pattern keeps quality gates green

## Suggested Structure

```markdown
docs/
  patterns/
    README.md
    knip-clean-during-refactor.md
    migration-staging-with-feature-flag.md
```

## Pattern Catalog

{% include components/child-pages-list.html parent=page.title path_prefix="docs/04-nice-to-have/" current_url=page.url %}

## Common Mistakes

**Permanent suppressions.** Temporary ignores without expiry become invisible debt.

**Suppress-first behavior.** Suppressions should come after obvious removals, not before.

**No owner.** Unowned suppressions are rarely cleaned up.

## Tool-Specific Notes

- **Claude Code / Codex / Cursor / Copilot**: same pattern applies; only command wrappers differ.
- **Hooks/CI**: add a check that rejects expired suppression markers in Knip config.

## References

- [CI Quality Gates](ci-quality-gates.md)
- [Documentation Structure](../03-should-have/documentation-structure.md)
- [External References](../references.md)
