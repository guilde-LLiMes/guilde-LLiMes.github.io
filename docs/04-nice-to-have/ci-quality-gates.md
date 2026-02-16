---
layout: default
title: CI Quality Gates
nav_order: 1
parent: Nice-to-Have
---

# CI Quality Gates

## Why This Matters

Guidelines tell the LLM what to do. Quality gates verify that it actually did it. When LLM-generated code goes through CI, automated checks catch violations that the model missed or the reviewer overlooked.

Without defined gates, CI is either too strict (blocking everything) or too loose (catching nothing). Defining which checks are blocking and which are advisory prevents both extremes.

## What to Include

- **Blocking checks** — must pass before merge (types, lint, tests, security scans)
- **Advisory checks** — reported but don't block (coverage trends, complexity metrics)
- **Flaky test handling** — how to deal with intermittent failures
- **LLM-specific checks** — any automated validation of generated code quality

## Example

```markdown
## CI Quality Gates

Blocking (merge requires all green):
- TypeScript: tsc --noEmit (zero errors)
- Lint: eslint (zero errors, warnings OK)
- Tests: jest --ci (all passing)
- Security: npm audit --audit-level=high (no high/critical)

Advisory (reported, don't block):
- Coverage: must not decrease (tracked, not enforced)
- Bundle size: warning if > 5% increase
- Complexity: flag functions with cyclomatic complexity > 15

Flaky tests:
- Quarantine flaky tests in tests/quarantine/
- Quarantined tests run but don't block CI
- Fix or delete quarantined tests within 2 weeks
```

## Common Mistakes

**Everything is blocking.** If coverage warnings block merges, developers spend time gaming coverage instead of writing meaningful tests.

**No plan for flaky tests.** Flaky tests undermine trust in CI. Without a quarantine strategy, teams start ignoring all test failures.

**Not running checks the LLM should know about.** If CI checks for import ordering but your guidelines don't mention it, the model creates code that passes locally but fails CI.

## Tool-Specific Notes

- **Claude Code**: List CI commands in CLAUDE.md so the model can run them locally before committing. `npm run typecheck && npm run lint && npm test` as a verification step.
- **All tools**: CI gates work alongside [LLM Guardrails](../02-must-have/llm-guardrails.md) — guardrails prevent mistakes proactively, CI catches what slips through.
