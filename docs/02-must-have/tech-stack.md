---
layout: default
title: Tech Stack
nav_order: 2
parent: Must-Have
---

# Tech Stack

## Why This Matters

LLMs know many frameworks, libraries, and patterns. That's the problem. Ask one to "add a database query" and it might use Sequelize, TypeORM, Prisma, Knex, or raw SQL — depending on which patterns dominate its training data for your context. Without knowing your stack, it guesses. Often wrong.

Worse, the model might suggest libraries you don't use, import packages you haven't installed, or write patterns from framework version 4 when you're on version 5. Stack documentation eliminates this entire class of errors.

## What to Include

- **Primary language(s) and version** — including strict mode, compiler flags
- **Frameworks** — web framework, ORM, test framework, build tool
- **Architectural style** — monolith, microservices, serverless; layered, hexagonal, vertical slice
- **Data stores** — primary DB, cache, message queue, file storage
- **Major external dependencies** — third-party APIs, SDKs, infrastructure services
- **What you don't use** — common alternatives that the model might suggest

## How to Write It

1. **Audit your dependency files.** `package.json`, `requirements.txt`, `go.mod`, `Cargo.toml` — they tell you exactly what you use.
2. **Identify the core 10.** Most projects depend on hundreds of packages, but only ~10 define the stack. List those.
3. **Note versions that matter.** If you're on React 18 (not 19), or Python 3.11 (not 3.12), say so — APIs differ between versions.
4. **State the architecture.** The model needs to know if business logic goes in `services/` (layered) or `features/` (vertical slice).
5. **List banned alternatives.** If your team chose Express over Fastify, say "No Fastify." This prevents the model from suggesting migrations.

## Example

```markdown
## Tech Stack

Language: Python 3.12 with type hints (strict mypy)
Web: FastAPI 0.109
ORM: SQLAlchemy 2.0 (async, mapped classes)
DB: PostgreSQL 16
Cache: Redis 7 (via redis-py async)
Queue: Celery with Redis broker
Tests: pytest + httpx (async test client)
Build: Poetry, Ruff for linting

Architecture: Layered
- src/api/        → FastAPI routers (thin, no business logic)
- src/services/   → Business logic (depends on repositories, not models)
- src/repos/      → Database access (SQLAlchemy queries)
- src/models/     → SQLAlchemy ORM models
- src/schemas/    → Pydantic request/response schemas

Do NOT use:
- Django, Flask (we use FastAPI)
- Tortoise ORM, Peewee (we use SQLAlchemy)
- unittest (we use pytest)
- requests (we use httpx for async)
```

## Common Mistakes

**Listing everything in package.json.** The model doesn't need to know about every transitive dependency. Focus on the libraries that determine how code is structured and written.

**Omitting versions.** "We use React" isn't enough if the model writes class components (React 16 style) when you're on React 18 with hooks. Versions shape the code the model generates.

**Forgetting the architecture style.** Listing frameworks without describing how they compose leaves the model to guess at the overall structure.

**Not listing alternatives to avoid.** The model knows many ways to do things. Without "don't use X," it might suggest X as "an improvement."

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md right after scope. The model references this constantly.
- **Cursor**: Can be `alwaysApply: true` or scoped — if you have multiple languages in a monorepo, scope stack info to the relevant directories
- **Copilot**: Include in `copilot-instructions.md`. Copilot is especially prone to suggesting popular alternatives.
- **AGENTS.md**: Core content in root file. Subdirectory files can override for sub-projects with different stacks.

## References

- [External References](../references.md)
