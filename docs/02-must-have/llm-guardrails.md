---
layout: default
title: LLM Guardrails
nav_order: 8
parent: Must-Have
---

# LLM Guardrails

## Why This Matters

This is the meta-guideline — rules about how the LLM itself should operate in your project. Without it, the model is an unrestricted agent: it can modify any file, add any dependency, restructure any directory, and skip any verification step.

Most LLM-generated mistakes aren't logic errors. They're scope errors — the model changes things it shouldn't touch, skips checks that would catch problems, or makes decisions that should involve a human. Guardrails constrain the model's freedom to match your comfort level.

## What to Include

- **Protected files and directories** — what the model must never modify
- **Verification steps** — what to run after generating code (tests, linters, type checkers)
- **Decision boundaries** — what requires human approval before proceeding
- **Dependency rules** — when the model can and can't add packages
- **Generation scope** — how much the model should do per request (single function vs entire module)

## How to Write It

1. **List protected paths.** Think about files where an incorrect change has outsized impact: migrations, CI/CD configs, infrastructure code, environment files.
2. **Define the verification loop.** After generating code, what commands should the model run (or prompt the developer to run) to verify correctness?
3. **Set decision thresholds.** Some changes are routine (add a utility function). Others need review (add a database table, install a dependency). Draw the line.
4. **Scope generation requests.** If you prefer incremental changes, say so. Some teams want the model to do one function at a time. Others want entire features.

## Example

```markdown
## LLM Guardrails

Never modify without explicit human approval:
- Database migrations (src/migrations/)
- CI/CD configs (.github/workflows/)
- Infrastructure code (terraform/, docker-compose.yml)
- Environment configs (.env*, deploy/)
- Package lock files (package-lock.json, yarn.lock)

After generating code, always run:
1. npm run typecheck
2. npm run lint
3. npm test

If any check fails, fix the issue before considering the task done.

Dependency rules:
- Don't add new npm packages without asking
- Don't upgrade major versions of existing packages
- Don't add packages that duplicate existing functionality

When in doubt, ask:
- Schema changes (new tables, column modifications)
- Changes to authentication or authorization logic
- Modifications to public API contracts
- Anything that affects data persistence or deletion

Scope:
- Prefer small, focused changes over large rewrites
- One logical change per request
- If a task requires changes to more than 5 files, outline the plan first
```

## Common Mistakes

**No protected files list.** This is the most impactful part. A model that casually edits your GitHub Actions workflow or database migration can cause production incidents.

**Verification steps that don't match the project.** If your project uses `pytest` but your guardrails say `npm test`, the model will either run the wrong command or skip verification entirely. Match the actual tooling.

**Being too restrictive.** If the model can't add a file, can't add an import, and can't modify any existing function without approval, the guardrails defeat the purpose of using an LLM. Find the balance between safety and productivity.

**Being too permissive.** "Just be careful" is not a guardrail. Specific, enumerated boundaries are.

**Forgetting the "ask first" category.** Not everything is binary (always OK / never OK). Some changes are fine in principle but should be confirmed with a human. Create an explicit "ask first" category.

## Tool-Specific Notes

- **Claude Code**: Essential for CLAUDE.md. Claude Code has file system access and can run commands — guardrails are the primary safety mechanism. Claude Code also supports hooks that can enforce guardrails programmatically.
- **Cursor**: Protected file rules can be set as `alwaysApply: true`. Verification steps can reference Cursor's built-in terminal.
- **Copilot**: Less critical since Copilot doesn't execute code or create files autonomously. Still useful for scoping suggestions.
- **AGENTS.md**: Critical for any autonomous agent. AGENTS.md was designed specifically for this use case — constraining agent behavior in a shared, standardized format.
