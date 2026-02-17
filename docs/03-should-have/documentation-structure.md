---
layout: default
title: Documentation Structure
nav_order: 7
parent: Should-Have
---

# Documentation Structure

## Why This Matters

When an LLM needs to create or update documentation — a README section, an API doc, a module description — it needs to know where docs live and what format they follow. Without this, documentation ends up in random locations: sometimes in the README, sometimes in a `docs/` subfolder, sometimes as a code comment, sometimes in a file that didn't exist before.

A documentation structure guideline prevents docs sprawl and keeps generated documentation findable.

## What to Include

- **Where docs live** — top-level docs folder, inline with code, or both
- **What goes where** — architecture docs vs API docs vs module docs vs changelogs
- **Format conventions** — markdown, JSDoc, docstrings, or specific tools
- **Code comments vs external docs** — when to use each

## How to Write It

1. **Map your current docs.** Where does documentation currently live? Formalize that.
2. **Define categories.** Architecture, API reference, module docs, user-facing docs, decision records.
3. **Set the rule for code comments.** Most projects over-comment or under-comment. Pick a principle.

## Example

```markdown
## Documentation

Locations:
- docs/architecture/  → System design, data flow diagrams, module boundaries
- docs/decisions/     → Architecture Decision Records (see ADR format)
- docs/api/           → API documentation (auto-generated from OpenAPI spec)
- README.md           → Project setup, development workflow, quick start

Code comments:
- Don't comment what the code does (the code should be clear)
- DO comment why — non-obvious business rules, workarounds, performance hacks
- Public API functions get JSDoc/docstrings with parameter descriptions
- No TODO comments without a linked issue

Module docs:
- Each top-level module (src/[module]/) has a README.md if it has non-obvious structure
- Keep module docs under 50 lines — link to architecture docs for depth
```

## Optional: Applied Patterns Branch

If you want practical "how we executed this" examples without mixing them into core principles, add a separate branch in your docs tree:

```markdown
docs/patterns/
  README.md                    # pattern template + contribution rule
  knip-clean-during-refactor.md
  temporary-ci-exception-policy.md
```

Rule of thumb:

- Core docs define stable policy.
- `docs/patterns/` shows implementation recipes and transitional workflows.
- Every temporary pattern must include owner, ticket, and expiry/removal condition.

## Common Mistakes

**No distinction between what goes where.** "Put docs in docs/" is too vague when you have architecture docs, API docs, and user guides.

**Over-documenting.** Requiring docstrings on every function leads to noise. Focus docs requirements on public APIs and non-obvious logic.

**Not including the rule about code comments.** LLMs love writing comments. Without guidance, you'll get `// increment counter` above `counter++`. Set explicit expectations.

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md. Claude Code frequently creates and edits files — it needs to know where docs belong.
- **Cursor**: Less critical as a rule since documentation changes are less frequent than code changes.
- **All tools**: This guideline primarily prevents the model from creating docs in unexpected locations.

## References

- [External References](../references.md)
