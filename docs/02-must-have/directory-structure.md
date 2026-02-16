---
layout: default
title: Directory Structure
nav_order: 5
parent: Must-Have
---

# Directory Structure

## Why This Matters

When an LLM creates a new file, it needs to decide where to put it. Without structure rules, the model defaults to whatever looks common in its training data — which may not match your project at all. A new utility function might land in `src/utils/`, `lib/helpers/`, `common/`, or `shared/` depending on the model's mood.

Wrong file placement breaks imports, violates module boundaries, and creates an inconsistent codebase. A clear directory structure guideline eliminates this entirely.

## What to Include

- **Top-level layout** — what each root directory contains
- **Module boundaries** — what can import from what
- **Where new files go** — rules for adding routes, services, models, tests, configs
- **Naming conventions for files and directories** — kebab-case, PascalCase, etc.
- **What doesn't belong in the repo** — generated files, build output, environment files

## How to Write It

1. **Map your current structure.** Run `tree -L 2` or equivalent and document what you see.
2. **Annotate each directory.** A one-line description of what goes there.
3. **State the import rules.** Which layers can depend on which? This prevents the model from creating circular dependencies or violating your architecture.
4. **Give placement rules for common file types.** "New API routes go in `src/routes/[resource].ts`." "New services go in `src/services/[name].service.ts`."

## Example

```markdown
## Directory Structure

src/
  routes/       → Express route handlers (thin: validate input, call service, return response)
  services/     → Business logic (may call repos, never call routes)
  repos/        → Database queries (SQLAlchemy, no business logic)
  models/       → ORM model definitions
  schemas/      → Request/response validation schemas
  middleware/   → Express middleware (auth, error handler, request logger)
  utils/        → Pure utility functions (no side effects, no I/O)
  config/       → App configuration (loaded from env vars)

tests/
  unit/         → Mirrors src/ structure, mocked dependencies
  integration/  → API-level tests with real DB
  e2e/          → Playwright browser tests

Import rules:
- routes → services → repos → models (one direction only)
- utils can be imported by anything
- Nothing imports from routes except the app entry point
- middleware is registered in app.ts, not imported by routes directly

Adding new modules:
- New resource? Create route + service + repo + model + schema
- New utility? Add to src/utils/ if pure, src/services/ if it has side effects
- New middleware? Add to src/middleware/, register in app.ts
```

## Common Mistakes

**Just showing the tree without import rules.** The directory tree tells the model *where* files go. Import rules tell it *how they connect*. Both matter.

**Being too granular.** You don't need to document every subdirectory. Focus on the top 2 levels and the rules for creating new entries.

**Not updating when structure changes.** If you refactored from `controllers/` to `routes/`, update the guideline. The model will follow whatever you wrote, even if the filesystem says otherwise.

**Forgetting generated and ignored files.** If `dist/`, `node_modules/`, or `generated/` shouldn't be touched, say so. The model might try to edit generated code.

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md. Claude Code navigates your file system, so accurate structure is critical. Subdirectory CLAUDE.md files can add module-specific rules.
- **Cursor**: Can scope rules to directories with glob patterns. A rule scoped to `src/routes/**` can have route-specific guidelines without cluttering the global rules.
- **Copilot**: Include in instructions. Copilot generates code inline so file placement is mostly handled by the user, but import rules still help.
- **AGENTS.md**: Subdirectory AGENTS.md files can provide directory-specific context (closest file wins).

## References

- [External References](../references.md)
