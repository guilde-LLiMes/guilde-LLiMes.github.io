---
layout: default
title: AGENTS.md
nav_order: 4
parent: Tool Guides
---

# AGENTS.md — The Emerging Standard

## Format Overview

AGENTS.md is a tool-agnostic format for providing instructions to AI coding agents. It's governed by the Agentic AI Foundation under the Linux Foundation, and supported by a growing list of tools.

- **Location**: Repo root or any directory
- **Format**: Standard markdown — no required structure, no frontmatter
- **Loading**: Closest file wins — a subdirectory AGENTS.md overrides the root for that directory
- **Supported by**: Cursor, Aider, Gemini CLI, Codex, Jules, Zed, and others
- **Governed by**: Agentic AI Foundation (Linux Foundation)

## Why AGENTS.md Matters

It's the closest thing to a universal standard for LLM coding guidelines. Instead of maintaining separate files for each tool, you can write one AGENTS.md that works across all supporting tools.

Key design principles:
- **No required structure** — write markdown however makes sense for your project
- **Hierarchical** — subdirectory files provide scoped context
- **User prompts override** — direct instructions always take precedence over file contents
- **Composable** — each sub-project can have its own instructions

## Effective Structure

Since AGENTS.md has no required structure, use whatever organization makes your guidelines clear. A practical pattern:

```markdown
# AGENTS.md

## Project
[Scope and domain]

## Stack
[Technologies and architecture]

## Conventions
[Coding standards and patterns]

## Testing
[Test types, locations, patterns]

## Security
[Auth, secrets, data handling]

## Boundaries
[Protected files, decision thresholds, verification steps]
```

This maps to the guide-LLiMes [must-have guidelines](../02-must-have/index.md).

## Hierarchical Loading

AGENTS.md uses "closest file wins" — the most specific file is used:

```
project/
├── AGENTS.md              # Project-wide defaults
├── backend/
│   ├── AGENTS.md          # Backend-specific rules (overrides root for backend/)
│   └── src/
│       └── api/
│           └── AGENTS.md  # API-specific rules (overrides backend/ for api/)
└── frontend/
    └── AGENTS.md          # Frontend-specific rules (overrides root for frontend/)
```

**Important**: Unlike CLAUDE.md (which accumulates), AGENTS.md overrides. The most specific file replaces less specific ones — it doesn't add to them. If you need shared rules across directories, repeat them or reference a common file.

## Example

```markdown
# AGENTS.md

## Project
[System scope, key concepts, explicit out-of-scope]

## Stack
[Languages, frameworks, architecture, major dependencies]

## Structure
[Directory placement rules + dependency direction]

## Standards
[Naming, formatting, error handling, logging]

## Testing
[Test levels, boundaries, file locations, required checks]

## Security
[Auth/data handling/secrets rules]

## Boundaries
[Protected files, ask-first changes, verification commands]
```

Use this as a structure skeleton. Populate it with your own project constraints rather than copying domain-specific content.

## AGENTS.md vs Other Formats

| Feature | AGENTS.md | CLAUDE.md | .cursor/rules | copilot-instructions |
|---|---|---|---|---|
| Multi-tool | Yes (many tools) | Claude Code only | Cursor only | Copilot only |
| Scoping | Closest file wins | Accumulates | Glob patterns | Path-specific files |
| Special syntax | None | None | YAML frontmatter | Optional frontmatter |
| Governance | Linux Foundation | Anthropic | Anysphere | GitHub |

## When to Use AGENTS.md

- **Your team uses multiple LLM tools** — one file serves all supporting tools
- **You want future-proofing** — as an emerging standard, more tools will likely support it
- **You want simplicity** — no special syntax, no frontmatter, just markdown
- **Your project is open source** — contributors using any tool benefit from the same instructions

## When to Prefer Tool-Specific Files

- **You need tool-specific features** — Cursor's glob patterns, Claude Code's skills/hooks
- **Your team standardized on one tool** — no need for multi-tool compatibility
- **You need accumulation, not override** — CLAUDE.md accumulates across directories; AGENTS.md overrides

## Common Issues

**Override confusion.** Teams expect subdirectory files to add to the root. They replace it. Repeat shared rules in each file, or keep all rules at the root.

**Not testing across tools.** An AGENTS.md that works well in Cursor might be structured differently than what Claude Code prefers. Test with your primary tools.

**Too long.** The same token budget principles apply. Keep it dense and scannable.

## References

- [External References](../references.md)
