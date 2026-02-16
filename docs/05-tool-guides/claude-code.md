---
layout: default
title: Claude Code
nav_order: 1
parent: Tool Guides
---

# Claude Code — CLAUDE.md

## Format Overview

Claude Code reads project guidelines from `CLAUDE.md` files. The root-level file is loaded into every conversation automatically. Subdirectory files add context when Claude works in that part of the codebase.

- **Location**: Repo root (`CLAUDE.md`) + optional subdirectories
- **Format**: Plain markdown — no special syntax, no frontmatter
- **Loading**: Root file is always loaded. Subdirectory files are loaded when the model works with files in that directory.
- **Generation**: Run `/init` in Claude Code to generate a starter file from your project

## Effective CLAUDE.md Structure

A well-structured CLAUDE.md follows a consistent order:

```markdown
# Project Guidelines

## Scope
[What the system does, what it doesn't do]

## Stack
[Languages, frameworks, architecture, data stores]

## Structure
[Directory layout and import rules]

## Standards
[Naming, formatting, error handling, logging]

## Testing
[Framework, test types, where tests live, coverage]

## Security
[Auth model, secrets handling, logging boundaries]

## Guardrails
[Protected files, verification steps, decision boundaries]
```

This maps directly to the [must-have guidelines](../02-must-have/index.md). Each section is compressed to fit the token budget.

## Token Budget

Claude Code's system prompt uses a portion of the context window. Your CLAUDE.md competes with the conversation, code being discussed, and tool outputs.

**Practical guidelines:**
- Keep the root CLAUDE.md under 100 lines
- Each instruction should be one line or a short bullet
- Use dense formatting (see [Token Budgets](../01-fundamentals/token-budgets.md))
- Move detailed context to subdirectory files where possible

## Hierarchical Structure

Claude Code supports a hierarchy of CLAUDE.md files:

```
project/
├── CLAUDE.md                    # Always loaded: scope, stack, standards
├── src/
│   ├── CLAUDE.md                # src-wide: architecture, import rules
│   ├── routes/
│   │   └── CLAUDE.md            # Route-specific: endpoint conventions
│   └── services/
│       └── CLAUDE.md            # Service-specific: business logic rules
└── tests/
    └── CLAUDE.md                # Test-specific: frameworks, patterns
```

**Benefits:**
- Root file stays small (global rules only)
- Subdirectory files add context only when relevant
- Effectively multiplies your token budget

**Rules:**
- Each file should be self-contained — don't reference other CLAUDE.md files
- Subdirectory files add to the root, they don't override it
- Don't duplicate rules across files

## Key Features

**Skills**: Claude Code supports custom skills — reusable command patterns stored in `.claude/skills/`. Use these for repetitive workflows like "write tests for this module" or "review this PR."

**Hooks**: Shell commands that run automatically before or after tool calls. Useful for enforcing guardrails programmatically (e.g., run linter after every file edit).

**File references**: Use `@filename` in CLAUDE.md to reference other documentation files (up to 5 levels deep).

## Example: Compressed CLAUDE.md

```markdown
# Project: Invoice Processor

## Scope
Invoice processing API for freelancers. PDF upload, OCR extraction, CSV/QuickBooks export.
NOT: payments, tax calc, multi-currency, analytics.

## Stack
Python 3.12, FastAPI, SQLAlchemy 2.0 (async), PostgreSQL 16, Redis, Celery.
Tests: pytest + httpx. Lint: Ruff. Types: mypy (strict).

## Structure
src/api/ → routers (thin) | src/services/ → logic | src/repos/ → DB queries
src/models/ → ORM | src/schemas/ → Pydantic | tests/ mirrors src/

Import direction: api → services → repos → models (one way only)

## Standards
Naming: snake_case everywhere. Files: snake_case.py.
Errors: AppError(code, message, status). Throw in services, catch in middleware.
Logging: structlog, JSON. Never log tokens, PII, or passwords.

## Testing
pytest + httpx for integration. Unit: mock external deps. Integration: testcontainers.
All public functions get tests. Factories in tests/factories/.

## Security
JWT via FastAPI Depends. All routes protected except /health, /auth/login.
Secrets: env vars via src/config.py. Never hardcode. Never commit .env.

## Guardrails
NEVER modify: alembic/versions/, .github/workflows/, docker-compose.yml, .env*
After changes: pytest && mypy src/ && ruff check src/
Ask before: schema changes, new dependencies, auth changes.
```

47 lines. Covers all must-haves. Dense, scannable, actionable.

## Common Issues

**CLAUDE.md is too long.** If it's over 150 lines, split into subdirectory files or trim content.

**Instructions contradict each other.** Root says "use Prisma," subdirectory says "use raw SQL." Claude follows whichever it reads last.

**Stale after refactoring.** If you renamed directories or changed frameworks, update CLAUDE.md or the model follows outdated instructions.
