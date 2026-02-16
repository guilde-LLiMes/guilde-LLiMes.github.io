---
layout: default
title: Architecture Decision Records
nav_order: 2
parent: Should-Have
---

# Architecture Decision Records

## Why This Matters

LLMs don't have institutional memory. They don't know that your team evaluated GraphQL and chose REST, or that you tried event sourcing and reverted to simple CRUD. Without this context, the model will periodically suggest the very approaches you've already rejected — wasting review cycles and sometimes introducing patterns that conflict with your existing architecture.

ADRs give the model the "why" behind your architecture. When the model knows that you chose PostgreSQL over MongoDB for its relational integrity, it won't suggest denormalized document-style schemas.

## What to Include

- **What was decided** — the choice that was made
- **Why** — the key reasons, trade-offs considered
- **What was rejected** — alternatives that were evaluated and dropped
- **Status** — accepted, superseded, or deprecated

## How to Write It

1. **Start with decisions that the LLM keeps getting wrong.** If the model keeps suggesting MongoDB, write an ADR for your database choice.
2. **Keep each record short.** 5-10 lines per decision. An ADR is not a design document — it's a decision log.
3. **Use a consistent format.** Title, status, context, decision, consequences. This lets the model scan quickly.
4. **Include only architecture-level decisions.** "We use tabs vs spaces" is not an ADR. "We chose a monolith over microservices" is.

## Example

```markdown
## Architecture Decisions

### ADR-001: REST over GraphQL
Status: Accepted
Context: Evaluated GraphQL for the public API. Team has no GraphQL experience,
  client needs are simple (CRUD + filtering), and REST tooling (OpenAPI) is mature.
Decision: Use REST with OpenAPI specs. No GraphQL.
Consequence: Clients that need complex nested queries will make multiple requests.

### ADR-002: Monolith first
Status: Accepted
Context: Team of 3, single product, shared database. Microservices overhead
  not justified at current scale.
Decision: Single deployable monolith with clear module boundaries.
Consequence: Modules communicate via function calls, not HTTP/events.
  Must enforce module boundaries via directory structure and imports.

### ADR-003: No ORM for reporting queries
Status: Accepted
Context: ORM-generated queries for reports are slow and hard to optimize.
Decision: Use raw SQL (via query builder) for read-heavy reporting endpoints.
  ORM for all write operations and simple reads.
Consequence: Two data access patterns coexist. Document which to use where.
```

## Common Mistakes

**Only recording the decision, not the alternatives.** The model needs to know what was rejected. Otherwise it may re-propose the rejected option as an "improvement."

**ADRs that are too long.** A full-page design document defeats the purpose. The model needs to scan dozens of decisions quickly. Keep each to 5-10 lines.

**Not updating when decisions change.** If ADR-002 is superseded because you moved to microservices, mark it as superseded and add the new ADR.

**Storing ADRs outside the model's context.** ADRs in a Confluence wiki don't help the LLM. They need to be in the guidelines file or in a docs directory that the model can reference.

## Tool-Specific Notes

- **Claude Code**: Can be in CLAUDE.md (if short) or in a referenced file. Claude Code can read files, so `docs/decisions/` works.
- **Cursor**: Lightweight ADR summaries in a dedicated rule file. Full ADRs can be in `docs/` for reference.
- **Copilot**: Summarize key decisions in `copilot-instructions.md`. Copilot can't browse files, so the context must be in the instructions.
- **AGENTS.md**: Include decision summaries in the root file. Agents benefit from understanding architectural constraints.

## References

- [External References](../references.md)
