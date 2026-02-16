---
layout: default
title: Why Guidelines Matter
nav_order: 1
parent: Introduction
---

# Why Guidelines Matter

An LLM writing code for your project is like a skilled contractor who has never seen your building. They know how to wire circuits, but they don't know where your walls are, which rooms are load-bearing, or that you switched from copper to aluminum last year. Without a blueprint, they'll make reasonable guesses — and some of those guesses will be wrong in ways that are expensive to find.

Project guidelines are that blueprint.

## The Cost of No Guidelines

Without explicit project context, LLMs consistently fail in predictable ways:

**They hallucinate features.** Ask an LLM to add a "notification" endpoint and it may create an email service, a webhook system, and a database table — when all you needed was a simple in-app flag. Without knowing your project's scope, the model fills in gaps with assumptions.

**They pick the wrong tools.** An LLM will suggest MongoDB for a project that uses PostgreSQL, or axios in a project that standardizes on fetch. It doesn't know your stack unless you tell it.

**They break conventions.** One generation uses camelCase, the next uses snake_case. One puts files in `src/utils/`, the next in `lib/helpers/`. Without style guidance, every generation introduces micro-inconsistencies that compound over time.

**They ignore boundaries.** LLMs don't know that your `domain/` layer should never import from `infrastructure/`, or that your API contracts are versioned and can't have breaking changes. Architecture erodes silently.

**They touch things they shouldn't.** Database migrations, CI configs, production environment files — an LLM will modify these if it thinks it needs to, unless you explicitly say not to.

## Why Documentation Alone Isn't Enough

Most projects have documentation. READMEs, wikis, architecture diagrams, ADRs. But documentation written for humans and documentation written for LLMs serve different purposes.

Human documentation assumes context. It uses references like "the usual approach" or "follow the existing pattern." It relies on institutional knowledge. LLMs don't have institutional knowledge — they have a context window, and whatever is in that window is all they know.

Effective LLM guidelines are:
- **Explicit** — they state things a human team member would "just know"
- **Dense** — they pack maximum information into minimum tokens
- **Actionable** — they tell the model what to do, not just what exists
- **Scoped** — they say what's off-limits, not just what's on the table

## The Payoff

Teams with well-structured guidelines report a consistent pattern: the LLM's first attempt is closer to correct, reviews are faster, and fewer generated changes get rejected. The guidelines don't make the model smarter — they make it informed.

The investment is modest. A solid set of must-have guidelines takes an afternoon to write. The return is every future LLM interaction producing more predictable, more correct, more reviewable code.

---

Next: [What Makes a Good Guideline](what-makes-a-good-guideline.md) — the properties that separate useful guidelines from noise.

## References

- [External References](../references.md)
