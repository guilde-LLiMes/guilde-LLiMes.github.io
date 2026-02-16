---
layout: default
title: Architecture Tests
nav_order: 2
parent: Nice-to-Have
---

# Architecture Tests

## Why This Matters

Guidelines say "domain layer must not import from infrastructure." But guidelines can be ignored. Over time — especially with LLM-generated code that passes functional tests — architecture boundaries erode quietly. A service starts importing a repository directly. A utility function gets a database dependency. Each violation is small. Together, they collapse your architecture.

Architecture tests enforce boundaries in code, catching violations automatically.

## What to Include

- **Module dependency rules** — which modules can import from which
- **Package visibility** — what's public vs internal to a module
- **Layering enforcement** — direction of dependencies
- **Tooling** — which framework enforces these rules (ArchUnit, dependency-cruiser, eslint-plugin-boundaries)

## Example

```markdown
## Architecture Tests

Tool: dependency-cruiser (config in .dependency-cruiser.js)

Rules enforced:
- src/domain/ → no imports from src/infrastructure/ or src/routes/
- src/services/ → may import from src/domain/ and src/repos/, not src/routes/
- src/routes/ → may import from src/services/ only
- No circular dependencies between any modules
- src/utils/ → no imports from any other src/ module (must be pure)

Run: npx depcruise --validate src/
Part of CI: yes (blocking)
```

## Common Mistakes

**Rules without enforcement.** An architecture diagram that nobody checks is documentation, not a test. Use actual tooling.

**Too many rules too early.** Start with the most critical boundaries (domain independence, no circular deps). Add refinement later.

**Not including in CI.** Architecture tests only work if they run automatically. A manual check will be skipped.

## Tool-Specific Notes

- **Claude Code**: Include the validation command in CLAUDE.md guardrails — run after generating code.
- **All tools**: This guideline is more about project infrastructure than LLM configuration. The model benefits by knowing the rules exist and that violations will be caught.
