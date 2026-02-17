---
layout: default
title: Sub-Agents
nav_order: 4
parent: Tool Guides
---

# Sub-Agents — Delegate Large Work Without Losing Main Context

## Why Sub-Agents Are Helpful

Sub-agents let you keep the main conversation focused while delegating a larger unit of work to a specialist.

This is most useful when:

- one task needs deep focus (migration, refactor, incident triage)
- you want independent reasoning threads in parallel
- you need the main chat to stay concise and decision-focused

In practice, sub-agents reduce context clutter and improve throughput on bigger tasks.

## Claude Code Sub-Agents

Claude Code supports built-in and custom sub-agents. Custom definitions can be project-scoped or personal:

- project: `.claude/agents/`
- personal: `~/.claude/agents/`

Helpful capabilities:

- route specialized tasks to purpose-built agent roles
- invoke by name for explicit delegation
- run multiple sub-agents in parallel for independent workstreams

## OpenCode Sub-Agents

OpenCode also supports custom agents, with common locations:

- project: `.opencode/agents/`
- global: `~/.config/opencode/agents/`

This gives a similar delegation model: keep the main chat as coordinator, dispatch substantial tasks to specialized agents, then merge results.

## Practical Delegation Pattern

1. Keep the main chat for goals, constraints, and final decisions
2. Delegate one clear deliverable per sub-agent
3. Require each sub-agent to return three items: what changed, what was verified, and open risks/questions
4. Merge results in main chat and decide next step

## Good First Use Cases

- "Refactor module X and keep API compatibility"
- "Add tests for changed files only"
- "Audit this diff for security regressions"
- "Draft migration plan plus rollback checks"

## Common Mistakes

**Vague delegation.** "Look at this" is too broad; assign a concrete output.

**No integration contract.** Require output shape so results are mergeable.

**Over-fragmentation.** Too many sub-agents on tiny tasks adds overhead instead of speed.

## References

- [Claude Code: Sub-agents (official)](https://code.claude.com/docs/en/sub-agents)
- [OpenCode: Agents guide (official)](https://opencode.ai/docs/agents)
- [External References](../references.md)
