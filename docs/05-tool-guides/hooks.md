---
layout: default
title: Hooks
nav_order: 2
parent: Tool Guides
---

# Hooks — Enforce Quality at Runtime

## Why This Matters

Guidelines say what should happen. Hooks make it happen automatically while the model is editing code and running tools.

Use hooks for:
- **Post-edit quality checks** (format, lint, typecheck, tests)
- **Safety boundaries** (protected paths, risky commands, secrets checks)
- **Consistent workflows** (same checks every run, not reviewer-dependent)

## Helpfulness Map (Problem -> Hook Value)

| Team pain | Hook intervention | User-visible benefit |
|---|---|---|
| "The agent forgot lint/typecheck again" | `PostToolUse` checks after edits | Fewer review-round failures |
| "Risky files changed without discussion" | `PreToolUse` policy guard | Earlier, clearer stop signals |
| "Quality depends on who prompted better" | Standard hook scripts | More consistent output quality |
| "Session quality drifts over time" | `Stop` / `SubagentStop` summaries | Better closure and handoff quality |

## Claude Code Hook Model (Vendor Reference)

Claude Code has first-class lifecycle hooks. In practice, this is the most complete built-in hook system across current coding-agent tools.

### Supported lifecycle events

- `PreToolUse` — before tool execution
- `PostToolUse` — after tool execution
- `Notification` — when Claude emits notifications
- `UserPromptSubmit` — when the user submits a prompt
- `Stop` — when Claude finishes responding
- `SubagentStop` — when a subagent finishes
- `PreCompact` — before context compaction

### Hook handler types

Claude supports multiple hook handler types:

- **Command hooks** — run shell commands/scripts
- **Prompt hooks** — inject natural-language guidance at hook time
- **Agent hooks** — invoke a subagent to evaluate or gate behavior

This makes hooks useful for both deterministic checks (scripts) and policy judgment flows (prompt/agent).

### Configuration locations

Claude supports hooks in multiple settings scopes:

- `~/.claude/settings.json` (user scope)
- `.claude/settings.json` (project scope)
- local/project variants as documented by Anthropic

### Matcher behavior

For tool events, each hook can target a matcher:

- exact tool name, for example `Bash`
- pattern matcher, for example `Edit|Write`
- wildcard matcher, `*`

If multiple hooks match, Claude executes all matching hooks.

### Exit codes and control flow

Hook return codes have explicit behavior:

- `0` = success
- `2` = blocking error (show stderr to model)
- other non-zero = non-blocking error

Hooks can also emit structured JSON to control behavior and messaging to the model/user.

### Minimal hook shape (illustrative)

```json
{
  "hooks": {
    "PreToolUse": [
      { "matcher": "Edit|Write", "hooks": [{ "type": "command", "command": "./scripts/check-policy.sh" }] }
    ],
    "PostToolUse": [
      { "matcher": "Edit|Write", "hooks": [{ "type": "command", "command": "./scripts/check-changed.sh" }] }
    ]
  }
}
```

The key idea is simple: guard before risky actions, validate after edits.

## Cross-Tool Strategy

Not every tool has Claude-style lifecycle hooks. Use a layered approach:

1. **Native hooks when available** (Claude Code)
2. **Wrapper scripts + pre-commit** for local deterministic checks
3. **CI gates as final enforcement** for all tools

Practical mapping:

- **Claude Code**: native lifecycle hooks
- **Cursor / Copilot / Codex-style workflows**: emulate hooks with command wrappers, task runners, pre-commit, and CI
- **AGENTS.md**: policy only, no executable enforcement by itself

## What to Automate First

1. Run formatter and linter after file edits
2. Run type checks before task completion
3. Run targeted tests for changed modules
4. Add policy checks for protected files (migrations, CI, infra)

Keep local hook checks fast and deterministic. Push heavy integration checks to CI.

## Common Mistakes

**Hook overload.** Running slow full-suite checks on every action kills iteration speed.

**Flaky checks.** Teams stop trusting the hook output if failures are non-deterministic.

**Unclear remediation.** A failure must say exactly what to do next.

**Policy drift.** Keep written guardrails and executable checks synchronized.

## References

- [Claude Code: Automate workflows with hooks (official)](https://code.claude.com/docs/en/hooks-guide)
- [Claude Code: Hooks reference (official)](https://code.claude.com/docs/en/hooks)
- [External References](../references.md)
