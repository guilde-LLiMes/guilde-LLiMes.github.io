---
layout: default
title: GitHub Copilot
nav_order: 3
parent: Tool Guides
---

# GitHub Copilot — copilot-instructions.md

## Format Overview

GitHub Copilot reads project guidelines from a markdown file in the `.github/` directory. It's the simplest format — natural language in a single file, no special syntax.

- **Location**: `.github/copilot-instructions.md` (repo-wide)
- **Additional**: `.github/instructions/*.instructions.md` (path-specific)
- **Format**: Plain markdown, natural language
- **Loading**: Automatic when the file exists
- **Limit**: Content is included in the prompt; shorter is more reliable

## Effective Structure

Copilot instructions work best as short, declarative statements. The model processes them as soft guidance, not hard commands.

```markdown
# Copilot Instructions

## Project
Invoice processing API for freelancers. REST only.
Core: Invoice, LineItem, Vendor, ExportJob.
Not in scope: payments, tax calculation, multi-currency.

## Stack
Python 3.12, FastAPI, SQLAlchemy 2.0, PostgreSQL, Redis, Celery.
Use pytest for tests, Ruff for linting, mypy for types.

## Conventions
- snake_case for all Python identifiers
- Pydantic models for all request/response schemas
- AppError for all error handling (code, message, status)
- structlog for logging (JSON format, never log PII)

## Testing
- Unit tests mock external dependencies
- Integration tests use testcontainers for PostgreSQL
- Factory functions in tests/factories/ for test data
- All new public functions need tests

## Don't
- Don't suggest Django, Flask, or Tortoise ORM
- Don't add new dependencies
- Don't generate database migration files
- Don't hardcode credentials or API keys
```

## Path-Specific Instructions

Copilot supports additional instruction files scoped to specific paths:

```
.github/
├── copilot-instructions.md              # Repo-wide
└── instructions/
    ├── api-routes.instructions.md       # For API route files
    └── testing.instructions.md          # For test files
```

Path-specific files include a frontmatter-like header:

```markdown
---
applyTo: src/routes/**/*.py
---

# API Route Instructions

- Keep route handlers thin
- Use Depends() for authentication
- All endpoints return typed Pydantic responses
```

## Copilot-Specific Considerations

**Copilot suggests, it doesn't execute.** Unlike Claude Code or Cursor's agent mode, Copilot provides inline completions and chat suggestions. It doesn't create files, run commands, or make multi-file changes autonomously. This means:

- Guardrails about "don't modify file X" are less critical — the developer controls what's accepted
- File placement rules matter less — the developer creates the file
- Verification steps are the developer's responsibility

**Focus on code-level guidance.** Copilot's strength is line-by-line and function-by-function suggestions. Guidelines about naming, patterns, error handling, and library usage have the most impact.

**Keep instructions short.** Copilot's instruction budget is smaller than tools with dedicated agent modes. Every sentence should carry instruction weight. Trim explanations and rationale — just state the rules.

## Translating Guidelines

| Guideline | Relevance for Copilot |
|---|---|
| Project Scope | High — prevents scope creep in suggestions |
| Tech Stack | High — prevents wrong library suggestions |
| Coding Standards | Highest — directly shapes every completion |
| Testing Strategy | High — shapes test suggestions |
| Directory Structure | Medium — developer controls file creation |
| API Contracts | Medium — shapes API code suggestions |
| Security Basics | High — prevents insecure patterns in completions |
| LLM Guardrails | Low — developer controls what's accepted |

## Common Issues

**Instructions too long.** Copilot works best with concise instructions. A 200-line file will have diminishing returns.

**Instructions too explanatory.** "Because we value code quality, we prefer..." — skip the motivation. Just state the rule.

**Not testing the effect.** After adding instructions, try generating code and check if Copilot follows them. Adjust if not.
