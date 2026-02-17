---
layout: default
title: Keep Knip Green During Active Refactor
nav_order: 1
parent: Applied Practice Patterns
grand_parent: Nice-to-Have
---

# Keep Knip Green During Active Refactor

## Problem

Knip findings can be valid and still block progress in the middle of multi-PR work. Typical cases:

- a file intentionally removed in one PR but still referenced in another open branch
- dependencies temporarily present during migration
- exported types kept as public API even when not used internally

## Value

- CI stays green for the team.
- Temporary debt is explicit instead of hidden.
- Cleanup work is tracked and reversible.

## When to use

Use this pattern only when all conditions are true:

1. The work is intentionally split across multiple PRs.
2. Every suppression has an owner and linked ticket.
3. Every suppression has a removal trigger (date or merge milestone).

## Flow (Human + LLM)

1. Run Knip and classify findings into:
   - real dead code (remove now)
   - intentional API surface (document and allowlist)
   - temporary in-progress state (short-term suppression)
2. Apply real fixes first (delete files, remove unused exports/dependencies).
3. Add minimal temporary suppressions in Knip config with reason + ticket + expiry.
4. Re-run Knip and confirm clean output before merge.
5. Create follow-up cleanup task and fail that task if suppressions remain past expiry.

## Example Config Pattern

Use a config file where suppressions can be commented and reviewed:

```ts
// knip.config.ts
export default {
  // Temporary: FE-142, remove after refactor phase 2 (2026-03-15)
  ignoreDependencies: ['autoprefixer'],

  // Temporary: FE-142, file removed after router split lands
  ignore: ['src/lib/index.ts'],
};
```

## Example Triage Outcome

Given a report like:

- `src/lib/index.ts` deleted
- `autoprefixer` removed
- `handleGetBase`, `handleListNamespaces`, `handleGetVariant` exports removed
- `ListNamespacesInput`, `ListResumesInput`, `NamespaceRoutes`, `VariantInfo` intentionally kept as public API

A clean policy is:

1. Keep completed removals as-is.
2. Keep intentional API exports documented in API-contract docs.
3. Only suppress what is still transient, and time-box it.

## References

- [Applied Practice Patterns](applied-practice-patterns.md)
- [CI Quality Gates](ci-quality-gates.md)
- [Documentation Structure](../03-should-have/documentation-structure.md)
