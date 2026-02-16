---
layout: default
title: Tool Landscape
nav_order: 3
parent: Introduction
---

# Tool Landscape

Every major LLM coding tool has its own way of consuming project guidelines. The formats differ, but the underlying need is the same: get project context into the model's system prompt so it generates code that fits your project.

This page gives you the lay of the land. For deep dives on each tool, see the [Tool Guides](../05-tool-guides/index.md).

## The Common Pattern

All tools follow the same basic flow:

1. You write guidelines in markdown (or close to it)
2. You place them in a specific location in your repo
3. The tool loads them into the model's context automatically
4. The model uses them when generating code

What varies is the file location, format details, and how much control you have over loading.

## Tool Overview

### Claude Code — `CLAUDE.md`

- **Location**: Repo root (project-wide) or subdirectories (scoped)
- **Format**: Plain markdown
- **Loading**: Automatically injected into every conversation
- **Key feature**: Hierarchical — subdirectory CLAUDE.md files add context for that part of the codebase
- **Limit**: ~150-200 effective instructions before reliability drops

Claude Code also has strong workflow primitives:

- **[Hooks](../05-tool-guides/hooks.md)** for runtime quality enforcement
- **[Skills](../05-tool-guides/skills.md)** for reusable task playbooks
- **[Sub-agents](../05-tool-guides/sub-agents.md)** for delegated specialist execution
- **[Agent teams](../05-tool-guides/agent-teams.md)** for teammate-style multi-agent collaboration

```
my-project/
├── CLAUDE.md              # Project-wide guidelines
├── src/
│   ├── CLAUDE.md          # src-specific additions
│   └── api/
│       └── CLAUDE.md      # API-specific additions
```

### Cursor — `.cursor/rules/*.mdc`

- **Location**: `.cursor/rules/` directory
- **Format**: Markdown with YAML frontmatter
- **Loading**: Rules can be always-on, auto-matched by file glob, or manually invoked
- **Key feature**: Modular — each rule is a separate file with its own scope

```yaml
---
description: API route conventions
globs: src/routes/**/*
alwaysApply: false
---
# API Routes
- Use Express Router
- All routes return typed responses
- Error handling via middleware, not in-route try/catch
```

### GitHub Copilot — `copilot-instructions.md`

- **Location**: `.github/copilot-instructions.md` (repo-wide) or `.github/instructions/*.instructions.md` (path-specific)
- **Format**: Natural language markdown
- **Loading**: Automatic when the file exists
- **Key feature**: Simple — one file, natural language, no special syntax

### AGENTS.md — The Emerging Standard

- **Location**: Repo root or any directory (closest file wins)
- **Format**: Standard markdown, no required structure
- **Loading**: Supported by growing list of tools (Cursor, Aider, Gemini CLI, Codex, and others)
- **Key feature**: Tool-agnostic — one file format, multiple tool support
- **Governed by**: Agentic AI Foundation under the Linux Foundation

## Cross-Tool Strategy

You don't need to choose one format. A practical approach:

1. **Write your guidelines once** as structured content (the approach this guide teaches)
2. **Adapt to your primary tool** — put the core guidelines in that tool's format
3. **Add others as needed** — if your team uses multiple tools, maintain format-specific files

The content is the same. Only the container changes.

Most guideline categories (project scope, tech stack, coding standards) translate directly across all formats. Tool-specific features like Cursor's glob patterns or Claude Code's hierarchical loading are optimizations, not requirements.

## What You Don't Need

- You don't need every tool's format from day one
- You don't need special syntax — plain markdown works everywhere
- You don't need separate content per tool — the same guidelines serve all of them

Focus on writing good guidelines first. Formatting them for specific tools is a 10-minute task once the content exists.

---

Next: [Three-Tier Model](../01-fundamentals/three-tier-model.md) — how to prioritize which guidelines to write first.

## References

- [External References](../references.md)
