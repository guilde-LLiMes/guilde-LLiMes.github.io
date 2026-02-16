---
layout: default
title: Test Data Conventions
nav_order: 6
parent: Should-Have
---

# Test Data Conventions

## Why This Matters

LLMs create test data inline by default. Every test gets its own hardcoded user, its own fake email, its own mock object. Across a test suite, you end up with dozens of slightly different test users, inconsistent fixture shapes, and tests that break when the data model changes because the data is scattered everywhere.

Test data conventions centralize how test data is created and managed, making tests more maintainable and the model's output more consistent.

## What to Include

- **Fixtures vs factories** — which approach you use, where they live
- **Isolation rules** — how tests avoid stepping on each other's data
- **External system handling** — mocks, fakes, sandboxes, testcontainers
- **Naming and location** — where test data files and helpers live

## How to Write It

1. **Pick your pattern.** Factories (programmatic, flexible), fixtures (static, predictable), or seed data (pre-loaded). Most projects use one primary approach.
2. **Show where test helpers live.** `tests/factories/`, `tests/fixtures/`, `tests/helpers/` — one location.
3. **State isolation rules.** Transaction rollback between tests? Truncate tables? Unique prefixes?

## Example

```markdown
## Test Data

Approach: Factory functions in tests/factories/
- createUser(), createProject(), createTask() — each returns a full entity
- Accept overrides: createUser({ role: 'admin' })
- Auto-generate unique values (email, IDs) to avoid collisions

Isolation:
- Each integration test runs in a DB transaction that rolls back
- Unit tests use factory functions with no DB — plain objects
- No shared state between test files

External systems:
- HTTP APIs: use msw (Mock Service Worker) to intercept
- File storage: use in-memory fake from tests/fakes/storage.ts
- Email: use tests/fakes/mailer.ts (collects sent emails for assertion)

Rules:
- Never hardcode test data inline — use factories
- Never share mutable state between tests
- Never rely on execution order
```

## Common Mistakes

**No factory pattern.** Without factories, the model creates inline objects. These get stale when schemas change.

**Shared test state.** If test A creates a user that test B reads, you get ordering dependencies. State isolation rules prevent this.

**Not documenting external fakes.** If you have a fake mailer or storage adapter for tests, the model needs to know — otherwise it'll create its own mock.

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md so generated tests use your factory pattern. Point to the factory directory.
- **Cursor**: Scope to test directories with glob patterns.
- **All tools**: This guideline pays off most when the model writes many tests — it prevents test data sprawl.
