---
layout: default
title: Review Guidelines
nav_order: 3
parent: Should-Have
---

# Review Guidelines

## Why This Matters

LLM-generated code needs review just like human-written code. But without review guidelines, reviewers don't know what to focus on. Is the architecture right? Are the tests sufficient? Did the model accidentally introduce a security issue? Review guidelines set expectations for both the author (or the LLM) and the reviewer.

When the LLM knows what reviewers check, it generates code that's more likely to pass review the first time.

## What to Include

- **What reviewers check** — a prioritized checklist
- **PR description format** — what information a PR must include
- **LLM-generated code conventions** — whether to annotate, how to explain complex changes
- **Approval criteria** — what must pass before merge

## How to Write It

1. **List your top 5 review priorities.** What do reviewers actually reject PRs for? Those are your criteria.
2. **Define the PR template.** What, why, how to test, what to watch for.
3. **Set clear merge criteria.** All tests pass, no linter warnings, at least one approval.

## Example

```markdown
## Review Checklist

Reviewers check in this order:
1. Does the change match the requirement? (no gold-plating, no missing pieces)
2. Are architecture boundaries respected? (no cross-layer imports)
3. Are there tests? (unit for logic, integration for endpoints)
4. Security: no secrets, no PII in logs, auth checks present
5. Performance: no N+1 queries, no unbounded loops, pagination for lists

PR description must include:
- What changed and why
- How to test it locally
- Any migrations or config changes required

Merge requires:
- All CI checks pass (typecheck, lint, tests)
- At least 1 approval from a team member
- No unresolved comments
```

## Common Mistakes

**No prioritization.** A flat checklist of 20 items means reviewers check whatever they feel like. Prioritize what matters most.

**Not including LLM-specific concerns.** LLM-generated code has specific failure modes: over-engineering, wrong library usage, ignored conventions. Call these out for reviewers.

**Review criteria that don't match CI.** If your guidelines say "all tests must pass" but CI only runs linting, there's a gap. Align review criteria with automated checks.

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md so the model generates code that anticipates review criteria. Claude Code can also be used to generate PR descriptions.
- **Cursor**: Less relevant as a rule file. More useful as team process documentation.
- **All tools**: This guideline primarily helps the team, but including it in the model's context means generated code better matches expectations.
