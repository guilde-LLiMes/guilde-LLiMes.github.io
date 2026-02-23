---
layout: default
title: Skills
nav_order: 8
permalink: /skills/
---

# Skills Layout

This repository keeps reusable skills under `skills/`.

## Structure

```
skills/
  llm-doc-audit/
    SKILL.md
    references/
      checklist.md
  validation-protocol/
    SKILL.md
  playwright-doc-bootstrap/
    SKILL.md
    scripts/
      detect_playwright_context.sh
    references/
      detection-signals.md
      playwright-doc-template.md
      activation-techniques.md
```

## Conventions

- Keep each skill self-contained: `SKILL.md` plus only required `scripts/`, `references/`, or `assets/`.
- Keep one responsibility per skill. Avoid catch-all skills.
- Put trigger conditions in SKILL frontmatter `description`.
- Keep `SKILL.md` procedural and concise. Move long examples into `references/`.
- Add scripts only when deterministic behavior is required repeatedly.

## Current Intent

- `llm-doc-audit`: audit LLM-facing docs for missing, unclear, or outdated guidance.
- `validation-protocol`: generate/refresh `DEBUG.md` as an evidence-backed runtime debugging and verification contract.
- `playwright-doc-bootstrap`: detect Playwright/testing-context gaps, generate target docs, and wire those docs into LLM instruction entrypoints.
