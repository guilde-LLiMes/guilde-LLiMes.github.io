---
layout: default
title: Spec Templates
nav_order: 1
parent: Should-Have
---

# Spec Templates

## Why This Matters

When every prompt to the LLM has a different structure, results are unpredictable. One request includes acceptance criteria, the next doesn't. One describes edge cases, another ignores them. The LLM's output quality directly reflects the input's quality.

A spec template standardizes what you tell the model. It ensures every request includes the context the model needs, reducing rework and surprise.

## What to Include

- **Standard sections** — context, requirements, edge cases, acceptance criteria
- **When to use the template** — new features, bug fixes, refactors, or all of the above
- **How detailed each section should be** — a sentence vs a paragraph vs a checklist
- **Where templates live** — in the guidelines file, in a separate docs folder, or as prompt snippets

## How to Write It

1. **Look at your last 5 successful LLM interactions.** What information did you provide? Extract the common structure.
2. **Look at your last 5 failed interactions.** What was missing? Add those sections.
3. **Keep it short.** A template with 20 required sections will be ignored. 4-6 sections is the sweet spot.
4. **Make sections optional where appropriate.** Not every request has edge cases or performance concerns.

## Example

```markdown
## Spec Template

When requesting new features or significant changes, structure the request as:

### Context
What exists today, what's the problem or gap.

### Requirements
What the change should do. Bullet list, imperative voice.

### Edge Cases
What could go wrong. Empty inputs, concurrent access, missing permissions.

### Acceptance Criteria
How to verify it works. Specific, testable conditions.

### Out of Scope
What this change intentionally does NOT include.
```

## Common Mistakes

**Making the template too rigid.** If every small fix needs a full spec, people will stop using the template. Scale the template to the task size.

**Not including "Out of Scope."** This is what prevents the model from gold-plating. Without it, the model will add features you didn't ask for.

**Templates that duplicate project guidelines.** The template should reference the tech stack and standards, not restate them.

## Tool-Specific Notes

- **Claude Code**: Can be stored as a Claude Code skill or referenced in CLAUDE.md. Useful as a prompt pattern the model recognizes.
- **Cursor**: Can be a `.mdc` rule that's manually referenced (not `alwaysApply`), loaded when writing specs.
- **All tools**: This guideline is more about human workflow than tool configuration. It standardizes the inputs you give to the model.
