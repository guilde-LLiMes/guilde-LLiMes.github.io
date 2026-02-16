---
layout: default
title: Cursor
nav_order: 2
parent: Tool Guides
---

# Cursor — .cursor/rules/*.mdc

## Format Overview

Cursor uses modular rule files stored in `.cursor/rules/`. Each file is a markdown document with YAML frontmatter that controls when the rule is loaded.

- **Location**: `.cursor/rules/` directory
- **Format**: Markdown with YAML frontmatter
- **Loading**: Three modes — always on, auto-matched by glob pattern, or manually referenced
- **Previous format**: `.cursorrules` (single file, deprecated — migrate to `.cursor/rules/`)

## Rule File Structure

```yaml
---
description: Short description of what this rule covers
globs: src/routes/**/*.ts
alwaysApply: false
---

# Rule Title

Rule content in markdown...
```

**Frontmatter fields:**
- `description` — shown in rule selection UI
- `globs` — file patterns that trigger this rule (only active files)
- `alwaysApply` — if true, rule is always loaded regardless of context

## Loading Modes

| Mode | Frontmatter | When loaded |
|---|---|---|
| Always | `alwaysApply: true` | Every interaction |
| Auto | `globs: pattern` | When working with matching files |
| Manual | description only | When explicitly referenced by name |

**Use always-on for**: Project scope, tech stack, security rules, global standards.

**Use auto (glob) for**: Directory-specific rules — API conventions when editing routes, test patterns when editing tests.

**Use manual for**: Infrequent workflows — deployment checklist, migration process.

## Organizing Rules

A practical numbering scheme:

```
.cursor/rules/
├── 001-project-scope.mdc      # alwaysApply: true
├── 002-tech-stack.mdc          # alwaysApply: true
├── 003-coding-standards.mdc    # alwaysApply: true
├── 010-api-routes.mdc          # globs: src/routes/**/*
├── 011-services.mdc            # globs: src/services/**/*
├── 012-database.mdc            # globs: src/repos/**/*
├── 020-testing.mdc             # globs: tests/**/*
└── 100-migration-process.mdc   # manual (description only)
```

**Numbering convention:**
- 001-009: Core (always on)
- 010-019: Layer-specific (auto, glob-scoped)
- 020-029: Testing (auto, glob-scoped)
- 100+: Manual workflows

## Translating Guidelines to Rules

Each [must-have guideline](../02-must-have/index.md) maps to one or more rule files:

| Guideline | Rule approach |
|---|---|
| Project Scope | `alwaysApply: true` — loaded every time |
| Tech Stack | `alwaysApply: true` |
| Coding Standards | `alwaysApply: true` or split by language |
| Testing Strategy | `globs: tests/**/*` — loaded when in test files |
| Directory Structure | `alwaysApply: true` |
| API Contracts | `globs: src/routes/**/*` or `src/api/**/*` |
| Security Basics | `alwaysApply: true` |
| LLM Guardrails | `alwaysApply: true` |

## Example: Always-On Rule

```yaml
---
description: Core project context and tech stack
alwaysApply: true
---

# Project: Invoice Processor

Invoice processing API for freelancers. PDF upload → OCR → structured export.
NOT: payments, tax, multi-currency, analytics.

Stack: Python 3.12, FastAPI, SQLAlchemy 2.0 (async), PostgreSQL 16, Redis, Celery.
Tests: pytest + httpx. Lint: Ruff. Types: mypy (strict).

Architecture: api → services → repos → models (one direction only).
Never modify: alembic/versions/, .github/workflows/, docker-compose.yml.
```

## Example: Glob-Scoped Rule

```yaml
---
description: API route conventions
globs: src/routes/**/*.py
alwaysApply: false
---

# API Route Conventions

- Routers are thin: validate input, call service, return response
- No business logic in route handlers
- Use Depends() for auth, validation, and pagination
- All routes return Pydantic response models
- Error responses use standard AppError middleware
- New endpoints: add to src/routes/[resource].py, register in src/routes/__init__.py
```

## Cursor-Specific Advantages

**Granular scoping.** Unlike single-file formats, Cursor lets you load different rules for different parts of the codebase. A monorepo with Python backend and TypeScript frontend can have entirely separate rule sets.

**Manual rules as workflows.** Reference a deployment or migration rule only when performing that specific task, keeping the default context clean.

**Rule precedence.** When multiple rules match, all are loaded. If rules conflict, higher-numbered rules take precedence.

## Common Issues

**Too many always-on rules.** If everything is `alwaysApply: true`, you lose the benefit of modular loading. Be selective.

**Overlapping globs.** Two rules matching the same files can cause conflicting instructions. Keep glob patterns distinct.

**Not migrating from .cursorrules.** The old single-file format is deprecated. Split it into modular .mdc files.
