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

## Which Guide Do You Need?

- **Using Claude Code?** → [Claude Code Guide](claude-code.md)
- **Using Cursor?** → [Cursor Guide](cursor.md)
- **Using GitHub Copilot?** → [GitHub Copilot Guide](github-copilot.md)
- **Want a tool-agnostic format?** → [AGENTS.md Guide](agents-md.md)
- **Using multiple tools?** → Start with AGENTS.md as a base, add tool-specific files for features you need

## Multi-Tool Strategy

If your team uses more than one tool:

1. **Write your guidelines as plain markdown** (the content from this framework)
2. **Pick a primary format** for the tool most of your team uses
3. **Add secondary formats** only if a tool's unique features add value (e.g., Cursor's glob scoping)
4. **Keep content in sync** — update the source, then update the format-specific files

The overhead of maintaining 2-3 format variants is small. The content — which is 90% of the work — is shared.
