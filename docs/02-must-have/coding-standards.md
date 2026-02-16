---
layout: default
title: Coding Standards
nav_order: 3
parent: Must-Have
---

# Coding Standards

## Why This Matters

Without style guidance, every LLM generation introduces small inconsistencies. One function uses camelCase, the next uses snake_case. One file has semicolons, the next doesn't. Error handling follows three different patterns across three files. Each inconsistency is minor. Together, they erode readability and make diffs noisy.

The model can write code in any style. It just needs to know which style is yours.

## What to Include

- **Formatting rules** — or a pointer to the formatter config (Prettier, Black, Ruff, gofmt)
- **Naming conventions** — variables, functions, classes, constants, files, database columns
- **Error handling pattern** — how errors are created, propagated, caught, and logged
- **Logging approach** — structured vs unstructured, log levels, what to include in log context
- **Import ordering** — if your linter enforces this, just point to the config
- **Side effects and I/O** — where side effects are allowed and where they're not

## How to Write It

1. **Point to your formatter first.** If you use Prettier, Black, or gofmt, say so. Don't rewrite formatting rules — the model knows what these tools enforce.
2. **Document what formatters don't cover.** Naming conventions, file naming, error handling patterns, domain-specific rules — these need explicit guidelines.
3. **Show patterns, not descriptions.** "Use typed errors" is vague. A 3-line code block showing your error class is unambiguous.
4. **Keep it to one page.** If your coding standards take more than 30-40 lines, you're either duplicating linter rules or over-specifying.

## Example

```markdown
## Coding Standards

Formatting: Prettier (config in .prettierrc). Don't duplicate rules here.

Naming:
- Variables/functions: camelCase
- Classes/types: PascalCase
- Constants: UPPER_SNAKE_CASE
- Files: kebab-case.ts
- DB columns: snake_case

Errors:
- Use AppError class from src/errors/app-error.ts
- Always include: code (string), message (string), httpStatus (number)
- Throw in services, catch in route handlers
- Never throw raw strings or generic Error()

Logging:
- Use logger from src/utils/logger.ts (structured JSON)
- Include requestId in all log entries
- Levels: error (failures), warn (degraded), info (business events), debug (dev only)
- Never log: tokens, passwords, PII, full request bodies

Imports:
- External packages first, then internal, then relative
- Enforced by ESLint import/order — don't override
```

## Common Mistakes

**Restating linter rules.** If ESLint or Prettier enforces it, point to the config. Don't waste tokens re-documenting rules that tooling already handles.

**Being too abstract.** "Write clean code" is not a standard. "Functions under 30 lines, single return, no side effects in domain layer" is a standard.

**Covering every edge case.** Focus on the patterns the model encounters most: naming, errors, logging, imports. You don't need rules for rarely-encountered situations.

**Inconsistency with actual code.** If your guidelines say "camelCase for everything" but existing code uses snake_case in half the files, the model will be confused. Align guidelines with the actual codebase, or align the codebase first.

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md. Point to formatter configs rather than restating rules.
- **Cursor**: Good candidate for `alwaysApply: true` rule. Can also create language-specific rules with glob patterns (e.g., `*.py` vs `*.ts`).
- **Copilot**: Include in instructions. Copilot is particularly sensitive to naming conventions.
- **AGENTS.md**: Root-level file. Short and dense — the model references this frequently.

## References

- [External References](../references.md)
