---
layout: default
title: Incremental Adoption
nav_order: 3
parent: Fundamentals
---

# Incremental Adoption

The worst way to write guidelines is to sit down and try to document everything at once. You'll spend hours producing a comprehensive file that's too long for the model to follow, too generic to be useful, and stale within a month.

The better approach: start small, observe, and grow.

## The Pattern

```
Write 3 rules → Use them → See what the LLM gets wrong → Write rules for that → Repeat
```

Your guidelines should be driven by actual LLM failures, not theoretical completeness.

## Week 1: The Minimum Viable Guidelines

Pick the 3 must-haves that address your project's most obvious context gaps.

For most projects, this is:

1. **Project scope** — what the system does, so the model doesn't invent features
2. **Tech stack** — languages and frameworks, so the model doesn't guess wrong
3. **Directory structure** — where files go, so the model doesn't create random paths

That might look like this (total: ~15 lines):

```markdown
# Project Guidelines

## Scope
Task management API for small teams. REST API only — no frontend, no mobile,
no real-time features. Core entities: User, Team, Task, Comment.

## Stack
TypeScript 5.4, Node 20, Express, PostgreSQL 16 with Prisma ORM.
Tests: Jest + Supertest. No other frameworks.

## Structure
src/routes/     → Express route handlers
src/services/   → Business logic
src/models/     → Prisma schema + generated types
src/middleware/  → Auth, validation, error handling
__tests__/      → Mirrors src/ structure
```

This takes 15 minutes to write and immediately prevents the most common LLM mistakes.

## Month 1: Responding to Friction

After a week of using your initial guidelines, you'll notice patterns:

- "The model keeps writing tests with raw SQL instead of using our fixtures" → Add [test data conventions](../03-should-have/test-data-conventions.md)
- "It created a PUT endpoint that breaks our versioning" → Add [API contracts](../02-must-have/api-contracts.md)
- "It logged a user token in a debug statement" → Add [security basics](../02-must-have/security-basics.md)

Each fix is one guideline addition, driven by a real problem. By the end of the month, you might have 6-8 must-haves and 2-3 should-haves.

## Quarter 1: Maturity

By now your guidelines are battle-tested. You've added rules that address real failure modes and removed ones that didn't help.

This is when should-haves and nice-to-haves earn their place:

- You add [ADRs](../03-should-have/adrs.md) because the model keeps suggesting patterns you deliberately rejected
- You add [error handling standards](../03-should-have/error-handling.md) because reviews keep catching inconsistent error shapes
- You add [architecture tests](../04-nice-to-have/architecture-tests.md) because the model has started sneaking infrastructure imports into the domain layer

## Maintenance

Guidelines rot the same way documentation rots: through neglect.

**Review triggers:**
- Tech stack changes (new framework, dropped dependency)
- Architectural shifts (monolith to services, REST to GraphQL)
- Repeated LLM mistakes on a topic that has a guideline (the rule isn't clear enough)
- Team member notices the model ignoring a rule (the rule may be buried too deep)

**Review process:**
1. Read through all guidelines (takes 5 minutes if they're properly dense)
2. Remove anything that's stale or contradicted by current practice
3. Tighten anything the model has been getting wrong
4. Check total instruction count — trim if over budget

A monthly review of 10-15 minutes keeps guidelines sharp.

## Anti-Patterns

**Writing guidelines for hypothetical problems.** If the LLM hasn't made a mistake in an area, you probably don't need a guideline for it yet.

**Copying someone else's template wholesale.** Your project isn't their project. A React SPA and a Go microservice need fundamentally different guidelines.

**Never removing guidelines.** If a rule hasn't been relevant in 3 months, it's taking up token budget for nothing.

**Writing guidelines instead of using tooling.** If a linter, formatter, or type checker can enforce a rule, let it. Don't waste guideline space on things that tools handle better.

---

You now have the conceptual foundation. Next: [Must-Have Guidelines](../02-must-have/index.md) — the non-negotiables, explained one by one.

## References

- [External References](../references.md)
