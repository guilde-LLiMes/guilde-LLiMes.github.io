---
layout: default
title: GitHub Copilot
nav_order: 7
parent: Tool Guides
---

# GitHub Copilot — copilot-instructions.md

## Format Overview

GitHub Copilot reads project guidelines from a markdown file in the `.github/` directory. It's the simplest format — natural language in a single file, no special syntax.

- **Location**: `.github/copilot-instructions.md` (repo-wide)
- **Additional**: `.github/instructions/*.instructions.md` (path-specific)
- **Format**: Plain markdown, natural language
- **Loading**: Automatic when the file exists
- **Limit**: Content is included in the prompt; shorter is more reliable

## Effective Structure

Copilot instructions work best as short, declarative statements. The model processes them as soft guidance, not hard commands.

```markdown
# Copilot Instructions

## Project
[System scope, explicit out-of-scope boundaries]

## Stack
[Languages, frameworks, major dependencies, disallowed alternatives]

## Conventions
- [Naming and formatting rules]
- [Error handling and logging patterns]
- [Dependency and module boundaries]

## Testing
- [Test levels and boundaries]
- [Where tests live]
- [Required checks before completion]

## Don't
- [Protected files the model should not change]
- [Changes that require explicit approval]
```

Use this as a section scaffold. Keep content project-specific and prefer short rules over domain-heavy examples.

## Path-Specific Instructions

Copilot supports additional instruction files scoped to specific paths:

```
.github/
├── copilot-instructions.md              # Repo-wide
└── instructions/
    ├── api-routes.instructions.md       # For API route files
    └── testing.instructions.md          # For test files
```

Path-specific files include a frontmatter-like header:

```markdown
---
applyTo: src/**/*
---

# Path-Specific Instructions

- [Rules that apply only to this path pattern]
- [Local constraints and conventions]
- [Extra checks required for this area]
```

## Copilot-Specific Considerations

**Copilot suggests, it doesn't execute.** Unlike Claude Code or Cursor's agent mode, Copilot provides inline completions and chat suggestions. It doesn't create files, run commands, or make multi-file changes autonomously. This means:

- Guardrails about "don't modify file X" are less critical — the developer controls what's accepted
- File placement rules matter less — the developer creates the file
- Verification steps are the developer's responsibility

**Focus on code-level guidance.** Copilot's strength is line-by-line and function-by-function suggestions. Guidelines about naming, patterns, error handling, and library usage have the most impact.

**Keep instructions short.** Copilot's instruction budget is smaller than tools with dedicated agent modes. Every sentence should carry instruction weight. Trim explanations and rationale — just state the rules.

## Translating Guidelines

| Guideline | Relevance for Copilot |
|---|---|
| Project Scope | High — prevents scope creep in suggestions |
| Tech Stack | High — prevents wrong library suggestions |
| Coding Standards | Highest — directly shapes every completion |
| Testing Strategy | High — shapes test suggestions |
| Directory Structure | Medium — developer controls file creation |
| API Contracts | Medium — shapes API code suggestions |
| Security Basics | High — prevents insecure patterns in completions |
| LLM Guardrails | Low — developer controls what's accepted |

## Common Issues

**Instructions too long.** Copilot works best with concise instructions. A 200-line file will have diminishing returns.

**Instructions too explanatory.** "Because we value code quality, we prefer..." — skip the motivation. Just state the rule.

**Not testing the effect.** After adding instructions, try generating code and check if Copilot follows them. Adjust if not.

## References

- [External References](../references.md)
