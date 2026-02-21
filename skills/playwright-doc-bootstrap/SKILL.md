---
name: playwright-doc-bootstrap
description: Detect Playwright and E2E documentation gaps, generate project-specific Playwright guidance, and wire that guidance into LLM instruction entrypoints. Use when projects lack clear rules for where Playwright tests live, how they are written, or how AGENTS.md/CLAUDE.md should point to canonical testing docs.
---

# Playwright Documentation Bootstrap Skill

Use this skill when a repository does not clearly document Playwright testing conventions for LLM agents.

## Inputs

- Repository root
- Existing instruction files (for example: `AGENTS.md`, `CLAUDE.md`, tool-specific rule files)
- Existing test docs under `docs/` (if any)
- `scripts/detect_playwright_context.sh`
- `references/detection-signals.md`
- `references/playwright-doc-template.md`
- `references/activation-techniques.md`

## Workflow

1. Detect project context by running `scripts/detect_playwright_context.sh` from repository root.
2. Classify gaps as `missing`, `unclear`, or `outdated` using `references/detection-signals.md`.
3. Generate or update a canonical Playwright guideline document using `references/playwright-doc-template.md`.
4. Activate LLM awareness by updating instruction entrypoints using `references/activation-techniques.md`.
5. Validate by checking that:
   - a canonical Playwright doc exists,
   - instruction files point to it,
   - commands and paths in docs match current repo state.

## Output Requirements

Return:

1. Detection summary:
   - frontend roots
   - Playwright config locations
   - candidate E2E directories
   - instruction files mentioning Playwright
2. Gap findings with severity (`High`, `Medium`, `Low`) and evidence paths.
3. Minimal patch plan:
   - target file(s) for canonical Playwright docs
   - exact instruction files to update for awareness
   - validation commands to run

## Guardrails

- Do not invent frontend or test paths without filesystem evidence.
- Do not force Playwright adoption if the project has a different approved E2E tool.
- Keep documentation updates minimal and project-specific.
- Prefer linking to one canonical test doc over duplicating rules across many files.
