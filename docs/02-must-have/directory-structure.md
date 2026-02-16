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
- **Where new files go** — rules for adding features, modules, tests, configs, scripts
- **Naming conventions for files and directories** — kebab-case, PascalCase, etc.
- **What doesn't belong in the repo** — generated files, build output, environment files

## How to Write It

1. **Map your current structure.** Run `tree -L 2` or equivalent and document what you see.
2. **Annotate each directory.** A one-line description of what goes there.
3. **State the import rules.** Which layers can depend on which? This prevents the model from creating circular dependencies or violating your architecture.
4. **Give placement rules for common file types.** "New feature modules go in `src/features/[name]/`." "New shared helpers go in `src/shared/`."

## Example

```markdown
## Directory Structure

src/
  features/     → Capability modules (each owns its local logic and boundaries)
  core/         → Domain rules and shared business types
  adapters/     → External integrations (DB, HTTP, queues, file I/O)
  shared/       → Cross-cutting helpers (pure, framework-light)
  config/       → App configuration (loaded from env vars)
tests/
  unit/         → Fast isolated tests (no network or external I/O)
  integration/  → Boundary tests (real adapters where needed)
  e2e/          → Full workflow tests
generated/      → Generated artifacts (read-only)

Dependency rules:
- features may depend on core + adapters + shared
- core must not depend on adapters or framework code
- shared must not import from features
- generated code is never edited by hand

Adding modules:
- New capability? Add `src/features/[name]/`
- New integration? Add `src/adapters/[system]/`
- New reusable helper? Add to `src/shared/` only if reused across features
```

## Common Mistakes

**Just showing the tree without import rules.** The directory tree tells the model *where* files go. Import rules tell it *how they connect*. Both matter.

**Being too granular.** You don't need to document every subdirectory. Focus on the top 2 levels and the rules for creating new entries.

**Not updating when structure changes.** If you refactored from layer-based to feature-based folders (or vice versa), update the guideline. The model will follow whatever you wrote, even if the filesystem says otherwise.

**Forgetting generated and ignored files.** If `dist/`, `node_modules/`, or `generated/` shouldn't be touched, say so. The model might try to edit generated code.

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md. Claude Code navigates your file system, so accurate structure is critical. Subdirectory CLAUDE.md files can add module-specific rules.
- **Cursor**: Can scope rules to directories with glob patterns. A rule scoped to `src/routes/**` can have route-specific guidelines without cluttering the global rules.
- **Copilot**: Include in instructions. Copilot generates code inline so file placement is mostly handled by the user, but import rules still help.
- **AGENTS.md**: Subdirectory AGENTS.md files can provide directory-specific context (closest file wins).

## References

- [External References](../references.md)
