---
layout: default
title: Domain Glossary
nav_order: 3
parent: Nice-to-Have
---

# Domain Glossary

## Why This Matters

Without a shared vocabulary, the LLM invents its own. One generation calls it a "customer," the next calls it a "user," the third calls it a "client." The model doesn't know these mean different things in your domain — or that they mean the same thing.

A domain glossary establishes the ubiquitous language for your project. Every entity, concept, and action has one name.

## What to Include

- **Core entities and their definitions** — the nouns of your domain
- **Relationships** — how entities relate to each other
- **Terms to avoid** — synonyms that should not be used
- **Business invariants** — rules that must always hold true

## Example

```markdown
## Domain Glossary

Workspace — the top-level organizational unit. One workspace has many projects.
  NOT: "organization", "team", "account"

Project — a collection of tasks with a lifecycle (active, archived).
  NOT: "board", "sprint", "group"

Member — a user associated with a workspace. Has a role (owner, editor, viewer).
  NOT: "participant", "collaborator", "teammate"

Task — a unit of work within a project. Has status (todo, in_progress, done).
  NOT: "ticket", "issue", "item", "card"

Invariants:
- A workspace must always have at least one owner
- A task always belongs to exactly one project
- Archived projects cannot have active tasks
```

## Common Mistakes

**Only defining terms, not banning synonyms.** The model's biggest naming mistake is using a plausible synonym. Explicitly listing what NOT to call things is essential.

**Too long.** A glossary with 50 entries consumes too many tokens. Focus on the 10-15 terms that the model confuses most often.

**Not including invariants.** Domain rules like "a workspace must have an owner" prevent the model from generating code that violates business logic.

## Tool-Specific Notes

- **Claude Code**: Include key glossary terms in CLAUDE.md. Full glossary can be in a separate file the model reads on demand.
- **Cursor**: Good candidate for an `alwaysApply: true` rule if domain consistency is a frequent problem.
- **All tools**: Most impactful for domain-rich applications (healthcare, finance, e-commerce) where terminology is precise and consequential.
