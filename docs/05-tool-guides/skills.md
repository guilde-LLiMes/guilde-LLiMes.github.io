---
layout: default
title: Skills
nav_order: 3
parent: Tool Guides
---

# Skills — Reusable Workflows Without Prompt Repetition

## Why Skills Are Helpful

Skills turn repeated prompt patterns into reusable capability blocks. Instead of rewriting "how to do this task" every session, you define it once and reuse it.

Skills are especially helpful for:

- **Consistency** — same workflow every time (tests, migration checks, API review)
- **Speed** — less prompt writing, faster task starts
- **Onboarding** — new contributors can run team workflows immediately
- **Quality** — less variance between different users and sessions

## Basic Usage

At a high level, every skill includes:

- a clear name
- a short description of when to use it
- step-by-step instructions the agent can execute
- optional scripts/assets for repeatable execution

Selection is usually intent-driven: the agent picks a skill when the task matches the description, or you invoke it explicitly by name if your tool supports explicit mentions.

In mention-based tools, this is typically an `@skill-name` style invocation.

## Claude Code Skills

Claude Code supports project and personal skills:

- project skills: `.claude/skills/`
- personal skills: `~/.claude/skills/`

This model is useful for separating **team-standard workflows** (repo-local) from **individual productivity workflows** (personal).

Claude can auto-select skills from descriptions, and users can invoke specific skills directly when they want deterministic behavior.

## Codex Skills

Codex supports reusable skills loaded from a skills directory and invoked when task intent matches a skill.

Use Codex skills for structured workflows that should stay consistent across sessions, especially for repository-specific checks and conventions.

## Easy Start: Skill Builder Pattern

Many coding-agent setups include a `skill-builder` skill (or equivalent template workflow). Use it first to bootstrap your initial skill set.

Practical first three skills:

1. `test-changed-files`
2. `update-docs-for-feature`
3. `review-risky-diff`

These give immediate value with low setup complexity.

## Discovering Skills

- [Skills Docs](https://skillsmp.com/en/docs)
- [Skill Document (Claude)](https://code.claude.com/docs/en/skills)
- [Official Skills (Anthropic)](https://github.com/anthropics/skills)
- [Codex Skills Docs](https://github.com/openai/codex/blob/main/docs/skills.md)
- [Agent Skills Spec](https://agentskills.io/)
- [Search skills at skillsmp.com](https://skillsmp.com/)

## Common Mistakes

**Too broad.** A skill named "do-everything" is rarely reused well.

**No trigger clarity.** If the description does not state when to use the skill, selection quality drops.

**No maintenance owner.** Treat skills like code: review, version, and update them as architecture changes.

## References

- [Claude Code: Skills (official)](https://code.claude.com/docs/en/skills)
- [Anthropic official skills repository](https://github.com/anthropics/skills)
- [OpenAI Codex skills documentation](https://github.com/openai/codex/blob/main/docs/skills.md)
- [External References](../references.md)
