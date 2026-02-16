---
layout: default
title: What Makes a Good Guideline
nav_order: 2
parent: Introduction
---

# What Makes a Good Guideline

A guideline that sits in a wiki and never enters the model's context window is decoration. A guideline that's too vague to act on is noise. Good guidelines share a set of properties that make them useful to both humans reviewing code and LLMs generating it.

## Properties of Effective Guidelines

### Dense

Every token in your guidelines competes for space in the model's context window. Filler sentences, hedging language, and verbose explanations waste that space.

Bad:
```
It would be generally preferred if developers could try to use the existing
error handling utilities that have been established in the project, rather
than creating new ones, when it's possible and makes sense to do so.
```

Good:
```
Use AppError from src/errors/. Never throw raw strings. All errors need a code, message, and HTTP status.
```

The second version is 80% shorter and 100% more actionable.

### Scannable

LLMs process text sequentially, but they attend to structure. Bullet points, short paragraphs, code blocks, and consistent formatting all improve how reliably the model follows your guidelines.

Effective patterns:
- **Bullet lists** for rules and conventions
- **Code blocks** for naming patterns, file paths, command examples
- **Bold text** for key terms the model should recognize
- **Headers** to separate concerns (don't put testing rules under architecture)

### Unambiguous

"Follow best practices" is not a guideline. "Use consistent naming" is barely one. Good guidelines leave no room for interpretation.

Bad: `Use appropriate error handling.`

Good: `Wrap all external API calls in try/catch. Log the error with context (endpoint, params, status code). Return a typed AppError, never re-throw raw exceptions.`

The model can execute the second. It can only guess at the first.

### Imperative

Write guidelines as commands, not descriptions. The model should read them as instructions.

| Description style | Imperative style |
|---|---|
| We typically use Jest for testing | Use Jest for all tests |
| The project follows clean architecture | Keep domain/ free of infrastructure imports |
| Errors are usually logged | Log all errors with structured JSON |

### Scoped

Say what's off-limits, not just what's allowed. LLMs are eager to help and will take initiative unless you constrain them.

```
DO:
- Add new endpoints in src/routes/
- Create tests in __tests__/ adjacent to source
- Use existing middleware from src/middleware/

DON'T:
- Modify database migrations
- Change CI/CD workflows
- Add new npm dependencies without asking
- Edit .env files or any config in deploy/
```

### Current

Stale guidelines are worse than no guidelines — they actively mislead the model. If your stack changed from REST to GraphQL but your guidelines still say "all endpoints use Express routes," the model will generate the wrong code confidently.

Guidelines should be reviewed:
- When the tech stack changes
- When architectural patterns shift
- When the team notices repeated LLM mistakes on the same topic

## The Format Spectrum

Guidelines exist on a spectrum from informal to structured:

| Format | Best for | Example |
|---|---|---|
| Prose paragraphs | Context and rationale | "This is a healthcare app. Patient data must never be logged." |
| Bullet lists | Rules and conventions | "- Use UUID v4 for all entity IDs" |
| Code blocks | Patterns and examples | A sample function showing the expected error handling shape |
| Structured YAML/JSON | Machine-parseable constraints | File path rules, allowed dependencies |

Most effective guideline files use a mix: prose for context, bullets for rules, code blocks for examples.

## Writing for LLMs vs Humans

LLMs don't need motivation. They don't need to be convinced that testing is important. They need to know *which* testing framework, *where* tests go, and *what* counts as sufficient coverage. Strip out the "why this matters to the team" and keep the "here's exactly what to do."

That said, guidelines should still be readable by humans — your team will review and maintain them. The sweet spot is documentation that a new team member could follow on their first day, which is also dense enough for an LLM to act on.

---

Next: [Tool Landscape](tool-landscape.md) — how different LLM coding tools consume guidelines.
