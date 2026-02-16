---
layout: default
title: Hooks
nav_order: 2
parent: Tool Guides
---

# Hooks — Enforce Quality at Runtime

## Why This Matters

Guidelines describe what good output looks like. Hooks enforce it automatically while the model is working. This closes the gap between "the model was told" and "the model actually did it."

Hooks are especially useful for:

- **Post-edit validation** — run lint, type checks, tests, policy checks
- **Safety boundaries** — block risky commands or protected-path edits
- **Workflow consistency** — apply formatting and project checks every time

## What to Automate First

Start with low-friction checks that are fast and deterministic:

1. **Formatting and linting** after file edits
2. **Type checks** before completion
3. **Targeted tests** for modified modules
4. **Policy checks** for protected files (migrations, CI, infra)

If a check is slow or flaky, keep it in CI first and move it into hooks only when stable.

## Hook Design Pattern

Treat hooks as a staged quality gate:

1. **Before action**: validate intent and boundaries
2. **After action**: run local quality checks
3. **On completion**: summarize failures and required fixes

Keep hook scripts idempotent and explicit about exit codes:

- `0` = pass
- non-zero = fail and stop or request intervention

## Tool Notes

- **Claude Code**: Has first-class lifecycle hooks. Use hooks for deterministic checks around edits and commands.
- **Cursor / Copilot**: No universal built-in lifecycle hooks. Use wrapper scripts, pre-commit hooks, and CI gates to emulate hook behavior.
- **AGENTS.md**: Defines policy and boundaries, but does not execute checks by itself. Pair it with executable hooks or CI.

## Common Mistakes

**Hook overload.** Too many heavy checks on every action hurts iteration speed and gets bypassed.

**Non-deterministic checks.** Flaky scripts erode trust; keep hooks deterministic and fast.

**No fallback path.** If a hook fails, developers need clear remediation steps, not just "failed."

**Policy drift.** Hook behavior and written guardrails must match; update both together.

## References

- [External References](../references.md)
