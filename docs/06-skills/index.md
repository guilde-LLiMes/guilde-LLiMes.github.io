---
layout: default
title: Skills
nav_order: 8
permalink: /skills/
---

# Skills

Skills are reusable workflows that help teams apply this framework consistently.

Use this page to:
- see available skills in this project
- understand when to use each one
- install all skills or a single skill

## Core Feature: Documentation Intelligence

The main capability in this project is the `llimes-*` documentation workflow:

- `llimes-audit`: performs an evidence-based audit for missing or weak guidance.
- `llimes-knowledge`: plans documentation artifacts and keeps document responsibilities clear.

Use them as a pair:

1. Run `llimes-audit` to identify the highest-impact documentation gaps.
2. Use `llimes-knowledge` when audit findings need additional structure, ownership, or artifact planning context.
3. Apply fixes, then rerun `llimes-audit` to confirm improvement.
4. When findings involve runtime behavior, run `validation-protocol` to define reproducible verification commands in `DEBUG.md`.

## Quick Prompt Starters

- `llimes-audit`: "Audit these docs for coverage, clarity, and drift; return prioritized gaps."
- `llimes-knowledge`: "Given these audit findings, propose missing artifacts, ownership boundaries, and next docs to add."
- `validation-protocol`: "Build or refresh DEBUG.md with reproducible verification commands for this project."
- `playwright-doc-bootstrap`: "Check Playwright docs coverage and bootstrap missing testing guidance."

## Available Skills

### `llimes-audit`

- Purpose: audit LLM-facing documentation for coverage, clarity, drift, and instruction reachability.
- Use when: you want a structured docs quality pass with prioritized gaps.
- Source: `skills/llimes-audit/SKILL.md`

### `llimes-knowledge`

- Purpose: provide stage-based documentation guidance and artifact planning.
- Use when: you want to decide what to document next and how to separate document responsibilities.
- Source: `skills/llimes-knowledge/SKILL.md`

### `validation-protocol`

- Purpose: generate and maintain `DEBUG.md` as an evidence-based runtime validation contract.
- Use when: your project needs reproducible debugging and verification procedures.
- Source: `skills/validation-protocol/SKILL.md`

### `playwright-doc-bootstrap`

- Purpose: detect Playwright documentation gaps and bootstrap aligned testing guidance.
- Use when: Playwright exists (or is being adopted) and E2E/testing docs are unclear or missing.
- Source: `skills/playwright-doc-bootstrap/SKILL.md`

## Installation

Install all skills from this repository:

```bash
npx skills add https://github.com/guilde-LLiMes/guilde-LLiMes.github.io
```

Install one specific skill:

```bash
npx skills add https://github.com/guilde-LLiMes/guilde-LLiMes.github.io --skill {skill code name}
```

Examples:

```bash
npx skills add https://github.com/guilde-LLiMes/guilde-LLiMes.github.io --skill llimes-audit
npx skills add https://github.com/guilde-LLiMes/guilde-LLiMes.github.io --skill llimes-knowledge
npx skills add https://github.com/guilde-LLiMes/guilde-LLiMes.github.io --skill validation-protocol
npx skills add https://github.com/guilde-LLiMes/guilde-LLiMes.github.io --skill playwright-doc-bootstrap
```

## References

- [Tool Guides](../05-tool-guides/index.md)
- [External References](../references.md)
