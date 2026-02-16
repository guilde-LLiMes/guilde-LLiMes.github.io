---
layout: default
title: Testing Strategy
nav_order: 4
parent: Must-Have
---

# Testing Strategy

## Why This Matters

LLMs have an unpredictable relationship with tests. Sometimes they write comprehensive test suites. Sometimes they skip tests entirely. Sometimes they write the wrong kind — integration tests where you wanted unit tests, or tests that hit real databases when you expect mocks.

Without a testing guideline, you can't predict what you'll get. With one, the model knows exactly what kind of test to write, where to put it, and what it's allowed to touch.

## What to Include

- **Test framework** — which runner, assertion library, mocking library
- **Test types and their boundaries** — what each level (unit, integration, E2E) is allowed to do
- **Where tests live** — file naming and directory conventions
- **Coverage expectations** — thresholds, critical paths, what must always be tested
- **What tests must NOT do** — hit production APIs, modify shared state, depend on order

## How to Write It

1. **Name your test framework.** This sounds obvious but the model needs to know whether to import `jest`, `pytest`, `vitest`, or `go test`.
2. **Define test boundaries.** The most common LLM mistake is writing integration tests when you wanted unit tests (or vice versa). State explicitly what each level can and cannot touch.
3. **Show the file convention.** `foo.test.ts` next to `foo.ts`? Or `tests/unit/test_foo.py`? The model needs to know.
4. **State coverage rules simply.** Don't over-specify. "All public functions have tests" or "80% line coverage" is enough.

## Example

```markdown
## Testing

Framework: Vitest + Testing Library (React components)

Unit tests:
- Test pure functions and service methods in isolation
- Mock all external dependencies (DB, APIs, file system)
- File: [name].test.ts adjacent to source
- Fast — no I/O, no network, no database

Integration tests:
- Test API routes end-to-end with real DB
- Use testcontainers for PostgreSQL
- File: tests/integration/[route-name].test.ts
- Reset DB between tests with transaction rollback

E2E tests:
- Critical user paths only (login, create project, invite member)
- Playwright against staging
- File: tests/e2e/[flow-name].spec.ts

Rules:
- Every new public function gets a unit test
- Every new API endpoint gets an integration test
- Never mock what you own — mock only external boundaries
- No test should depend on another test's state
```

## Common Mistakes

**Saying "write tests" without specifying which kind.** The model needs to know the test type for the context. A service function gets a unit test. An endpoint gets an integration test. Be explicit.

**Not defining mock boundaries.** "Use mocks" is ambiguous. Mock the database adapter? The entire service? Define what gets mocked at each test level.

**Over-specifying coverage numbers.** "100% coverage on all files" leads the model to write trivial tests for getters and constructors. Focus coverage requirements on business logic and critical paths.

**Forgetting to mention test data.** If you use fixtures, factories, or seed data, the model needs to know. Otherwise it'll create inline test data that duplicates and drifts. See [Test Data Conventions](../03-should-have/test-data-conventions.md).

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md. Claude Code can run tests, so include the test command (`npm test`, `pytest`) for verification loops.
- **Cursor**: Can scope testing rules to test directories with glob patterns. Consider separate rules for unit vs integration contexts.
- **Copilot**: Include test patterns in instructions. Copilot generates tests inline, so clear file conventions prevent misplacement.
- **AGENTS.md**: Include test commands and conventions. Agents that can execute tests benefit most from this guideline.
