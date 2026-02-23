---
layout: default
title: Should-Have
nav_order: 5
has_children: true
permalink: /should-have/
doc_mission: "Define consistency and team-alignment artifacts."
doc_out_of_scope: "Baseline safety requirements and late-stage maturity controls."
---

# Should-Have Guidelines

These guidelines reduce variance. The LLM can produce working code without them, but the output will be less consistent, harder to review, and more likely to drift from your team's established patterns.

## Section Responsibility

- Mission: define artifacts that improve consistency, reviewability, and shared team behavior.
- In scope: should-have conventions and alignment guidance after must-haves are stable.

Add these after your must-haves are solid — typically in Stage 2 of LLM-assisted coding adoption for a project.

## The Seven Should-Haves

| # | Guideline | What it improves |
|---|---|---|
| 1 | [Spec Templates](spec-templates.md) | Consistent prompts, nothing gets forgotten |
| 2 | [Architecture Decision Records](adrs.md) | Model understands why things are the way they are |
| 3 | [Review Guidelines](review-guidelines.md) | Faster reviews, clear expectations |
| 4 | [Error Handling](error-handling.md) | Uniform error taxonomy and propagation |
| 5 | [Performance Expectations](performance-expectations.md) | Model considers scale, avoids naive implementations |
| 6 | [Test Data Conventions](test-data-conventions.md) | Reproducible, isolated tests |
| 7 | [Documentation Structure](documentation-structure.md) | Docs go in the right place, stay findable |

## Prioritizing

Pick based on where you see the most friction:

- **LLM output varies wildly per request** → Spec Templates
- **Model keeps suggesting patterns you rejected** → ADRs
- **Reviews take too long** → Review Guidelines
- **Error handling is inconsistent** → Error Handling
- **Tests are flaky or interdependent** → Test Data Conventions

## References

- [External References](../references.md)
