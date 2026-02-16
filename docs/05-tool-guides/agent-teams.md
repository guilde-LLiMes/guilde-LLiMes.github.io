---
layout: default
title: Agent Teams
nav_order: 5
parent: Tool Guides
---

# Agent Teams — Let Specialists Collaborate as a System

## Why Teams Are Helpful

A single agent can execute many tasks, but complex work often benefits from multiple specialists coordinating: architecture, implementation, QA, and documentation.

Agent teams help when:

- the task spans multiple disciplines
- you need parallel work with role-specific quality bars
- one coordinator should keep global constraints while specialists execute

This makes "agents talking to each other" explicit and structured instead of ad hoc.

## Claude Code Agent Teams

Claude Code supports team definitions in:

- `.claude/agents/team/**/*.md`

The tooling includes:

- `/agents` to manage agents
- `/agents-team` to create and manage agent teams

Team packs can define:

- a main architecture/orchestrator agent
- specialist teammate agents
- collaboration patterns between teammates

## Team Design Pattern

Start with three roles:

1. **Coordinator** — owns goals, constraints, and final synthesis
2. **Builder** — implements changes and reports verification
3. **Reviewer** — validates risks, regressions, and policy alignment

Add more roles only when repeated bottlenecks appear.

## When to Use Teams vs Sub-Agents

Use **sub-agents** when one primary agent can still coordinate effectively and you only need targeted delegation.

Use **agent teams** when collaboration itself is the core challenge and role boundaries should be persistent.

## Common Mistakes

**Too many roles too early.** Start lean; scale roles from real pain points.

**Role overlap.** If two teammates own the same decision, accountability becomes unclear.

**No integration checkpoints.** Require merge checkpoints and explicit handoffs.

## References

- [Claude Code: Agent teams (official)](https://code.claude.com/docs/en/agent-teams)
- [External References](../references.md)
