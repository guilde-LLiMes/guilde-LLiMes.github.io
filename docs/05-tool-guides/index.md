---
layout: default
title: Tool Guides
nav_order: 7
has_children: true
permalink: /tool-guides/
---

# Tool Guides

The principles in this framework are tool-agnostic. The same guidelines — project scope, tech stack, coding standards — work regardless of whether you use Claude Code, Cursor, Copilot, or something else.

What differs is the container: file names, locations, syntax, and loading behavior. These guides show how to translate your guidelines into each tool's format.

## Cross-Tool Mental Model

All LLM coding tools share the same pattern:

```
You write guidelines → Tool loads them → Model reads them → Model follows them
```

The differences:

| Aspect | Claude Code | Cursor | Copilot | AGENTS.md |
|---|---|---|---|---|
| File | CLAUDE.md | .cursor/rules/*.mdc | .github/copilot-instructions.md | AGENTS.md |
| Format | Markdown | Markdown + YAML frontmatter | Markdown | Markdown |
| Scoping | Subdirectory files | Glob patterns in frontmatter | Path-specific instruction files | Subdirectory files |
| Loading | Always (root), auto (subdirs) | Always, auto (glob), or manual | Always | Closest file wins |
| Multi-file | Yes (hierarchy) | Yes (rule per file) | Yes (instructions directory) | Yes (hierarchy) |

For executable quality gates across tools, see [Hooks](hooks.md).

## Which Guide Do You Need?

Available guides:

{% include components/child-pages-list.html parent=page.title path_prefix="docs/05-tool-guides/" current_url=page.url %}

For most teams:

- Start with [AGENTS.md](agents-md.md) for portable baseline guidance.
- Add your primary tool guide next (Claude Code, Cursor, or Copilot).
- Add [Hooks](hooks.md), [Skills](skills.md), [Sub-Agents](sub-agents.md), and [Agent Teams](agent-teams.md) only when those workflows become necessary.

## Multi-Tool Strategy

If your team uses more than one tool:

1. **Write your guidelines as plain markdown** (the content from this framework)
2. **Pick a primary format** for the tool most of your team uses
3. **Add secondary formats** only if a tool's unique features add value (e.g., Cursor's glob scoping)
4. **Keep content in sync** — update the source, then update the format-specific files

The overhead of maintaining 2-3 format variants is small. The content — which is 90% of the work — is shared.

## References

- [External References](../references.md)
