---
layout: default
title: Performance Expectations
nav_order: 5
parent: Should-Have
---

# Performance Expectations

## Why This Matters

LLMs write code that works. They don't automatically write code that works *fast*. Without performance context, the model will query the database in a loop, load entire collections into memory, or use synchronous calls where async is needed — because functionally correct is the default goal.

Performance guidelines tell the model when to care about efficiency and what the boundaries are.

## What to Include

- **Response time targets** — rough SLAs for key operations
- **Known bottlenecks** — areas where performance is sensitive
- **Patterns to use** — pagination, batching, caching, async processing
- **Patterns to avoid** — N+1 queries, unbounded fetches, sync-blocking

## How to Write It

1. **State your targets simply.** "API responses under 200ms for reads, under 500ms for writes." Exact numbers aren't required — order of magnitude is enough.
2. **Call out known hot paths.** If your search endpoint serves 10K requests/minute, the model should know.
3. **List anti-patterns for your stack.** Each framework has specific performance traps. Name them.

## Example

```markdown
## Performance

Targets:
- API reads: < 200ms p95
- API writes: < 500ms p95
- Background jobs: < 30s per item

Rules:
- All list endpoints MUST paginate (default 20, max 100)
- No ORM queries inside loops — use batch/bulk operations
- Cache frequently-read, rarely-changed data in Redis (TTL: 5 min)
- Heavy processing (PDF generation, image resize) → queue as background job
- Use DB indexes for any column used in WHERE or ORDER BY

Anti-patterns:
- Loading all records to filter in code (filter in query)
- Synchronous external API calls in request path (use queue or async)
- SELECT * when only 2 fields are needed
```

## Common Mistakes

**No concrete targets.** "Should be fast" is meaningless. "Under 200ms" gives the model a bar to design against.

**Over-optimizing the guidelines.** This is a should-have, not a micro-optimization manual. Focus on the top 5 performance rules, not every possible optimization.

**Not linking to architecture.** Performance patterns often depend on your stack. "Use Redis" only makes sense if the model knows Redis is in your stack (see [Tech Stack](../02-must-have/tech-stack.md)).

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md when performance is a concern. Claude Code can run benchmarks and profilers if told how.
- **Cursor**: Scope to data access and API layers where performance matters most.
- **All tools**: Performance guidelines are most valuable for backend and data-heavy projects. Frontend and CLI tools may not need this.

## References

- [External References](../references.md)
