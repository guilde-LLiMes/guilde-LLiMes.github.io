---
name: llimes-knowledge
description: Build or explain project documentation strategy for LLM usage using stage-based artifacts. Use when users ask what to document, how to organize responsibilities across docs, or which artifacts to add next for their project.
---

# LLiME Knowledge Skill

Use this skill when the task is advisory or planning-oriented, not a strict evidence audit.

## Purpose

- Explain what documentation artifacts matter for LLM-assisted engineering.
- Recommend a staged rollout (must-have, should-have, nice-to-have) based on user context.
- Clarify document ownership and avoid mixed responsibilities across pages.

## Inputs

- Repository docs tree (for example `docs/**`, `README.md`, `AGENTS.md`, tool-guide pages)
- User context (team size, stack, risk level, current pain points)
- Optional current checklist page when present

## Workflow

1. Identify current project stage and primary failure patterns.
2. Read only the docs needed to answer the user’s question (do not bulk-load everything).
3. Map recommendations to concrete artifacts (for example scope, testing strategy, guardrails).
4. Propose minimal next steps with clear ownership per document.
5. If an evidence-based gap scan is needed, hand off to `llimes-audit`.

## Output Format

Return:

1. Stage assessment (current and next stage).
2. Recommended artifacts (top 3-5) with short rationale.
3. Document ownership map (which page should own which topic).
4. Suggested implementation order (smallest useful sequence).

## Guardrails

- Do not claim repository facts without reading files.
- Do not enforce one architecture pattern.
- Do not duplicate full guidance across multiple pages; recommend a canonical owner page plus links.
- Do not replace audit output; use `llimes-audit` for evidence-based findings.
