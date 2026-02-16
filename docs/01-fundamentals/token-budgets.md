---
layout: default
title: Token Budgets
nav_order: 2
parent: Fundamentals
---

# Token Budgets

Your guidelines compete for space in the model's context window — the total amount of text the LLM can "see" at once. That window also holds the conversation, the code being discussed, tool outputs, and the model's own system prompt. Your guidelines are one slice of a limited pie.

Writing effective guidelines means understanding this constraint and writing for maximum information density.

## The Constraint

Every LLM tool has a context limit. The exact numbers change with model versions, but the principle holds:

- The model's full context window might be 100K-200K tokens
- The tool's own system prompt uses a significant chunk
- Your conversation and code references use more
- **Your guidelines get what's left**

In practice, most tools reliably follow roughly **100-200 distinct instructions**. Past that, the model starts dropping or conflating rules. This isn't a hard cutoff — it's a zone where reliability degrades.

## What This Means for You

### Write dense, not long

Every sentence should carry information. If a line could be removed without losing guidance, remove it.

Before (63 tokens):
```
When writing tests for our application, please make sure to use the Jest
testing framework, as that is what we have standardized on for this
project. Tests should be placed in the appropriate directory.
```

After (19 tokens):
```
Use Jest. Tests go in __tests__/ adjacent to source files.
```

Same information, one-third the tokens.

### Prioritize ruthlessly

If you can only reliably convey 150 instructions, which 150 matter most? This is why the [three-tier model](three-tier-model.md) exists. Must-haves go in first. Should-haves fill remaining space. Nice-to-haves go in only if there's room.

### Use structure to your advantage

Structured text (bullets, tables, code blocks) is more token-efficient than prose and easier for models to parse.

Prose (41 tokens):
```
The project uses TypeScript with strict mode enabled. We use Express for
the web framework. The database is PostgreSQL, accessed through Prisma ORM.
For caching, we rely on Redis.
```

Structured (26 tokens):
```
Stack: TypeScript (strict), Express, PostgreSQL/Prisma, Redis cache
```

### Leverage tool features

Some tools let you scope guidelines to specific directories or file patterns. This means you can:

- Keep the root-level guidelines focused on project-wide rules
- Put domain-specific rules in subdirectory guidelines
- The model only loads what's relevant to the current context

This effectively multiplies your token budget — the model doesn't need to see API route conventions when it's editing a database migration.

## Compression Techniques

When space is tight, these patterns help:

**Abbreviate known terms.** The model knows what "TS", "REST", "JWT", "CI" mean. You don't need to spell them out.

**Use implicit structure.** `src/domain/ → pure logic, no I/O` conveys the same as a paragraph about the domain layer.

**Reference, don't repeat.** If your project has a `CONVENTIONS.md` or a linter config, point to it: `Follow .eslintrc — don't duplicate rules here.`

**Group related rules.** Instead of 5 separate bullet points about error handling, write one dense block:

```
Errors: Use AppError (code + message + HTTP status). Catch at route boundary.
Log with structuredLog(). Never throw raw strings. Never swallow silently.
```

Five rules, two lines.

## Measuring Your Budget

A rough way to gauge your guideline size:

1. Count distinct instructions (each bullet, rule, or directive)
2. If you're under 100, you have room
3. If you're at 100-150, prioritize carefully
4. If you're over 150, start cutting or scoping

This isn't an exact science. Models vary, and instruction complexity matters (a simple naming rule is cheaper to follow than a complex architectural constraint). But it gives you a ballpark.

## The Trap: Guidelines That Are Too Long

A 500-line guidelines file feels thorough. In practice:

- The model follows the first ~100 instructions reliably
- Rules near the end get ignored or partially applied
- Contradictions between early and late rules cause unpredictable behavior
- The file becomes hard for humans to maintain and review

Shorter guidelines that cover the right things beat comprehensive guidelines that cover everything.

---

Next: [Incremental Adoption](incremental-adoption.md) — how to build up guidelines over time without writing everything at once.

## References

- [External References](../references.md)
