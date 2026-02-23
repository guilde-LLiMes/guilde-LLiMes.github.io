---
layout: default
title: Framework Checklist
nav_order: 4
parent: Introduction
---

# Framework Checklist

## Problem

Teams agree that "context engineering matters" but stall at adoption. Most people will not read long documentation before acting.

## Value

This checklist turns guide-LLiMes into a short execution path:

- what to define first
- what to enforce automatically
- what "done" looks like

## When to use

Use this page when you need to align a team quickly, onboard a project, or audit whether your framework setup is actionable.

## Document Responsibility

- Mission: provide a simple whole-project checklist for required guidance artifacts.
- In scope: checklist coverage, completion criteria, and audit correlation points.

## Whole-Project Checklist

This checklist is generated from checklist frontmatter metadata in source docs.

{% include components/framework-checklist-generated.html %}

## Source Of Truth

- Checklist metadata lives in frontmatter of contributing docs (`checklist_*` fields).
- Generated data file: `_data/framework-checklist.generated.yml`.
- Rebuild command: `scripts/build-framework-checklist.rb`.
- Parity validation command: `scripts/validate-framework-checklist-parity.rb`.

## Traceability Pattern (Use This Table)

| Failure Pattern | Rule Added | Enforcement |
|---|---|---|
| LLM changed protected files | LLM Guardrails | Pre-tool hook or CI policy check |
| Wrong stack/library suggestions | Tech Stack | Review gate + type/lint failures |
| Inconsistent file placement | Directory Structure | Path lint/check script |

## Correlation With `llm-doc-audit`

Use `llm-doc-audit` as the verification pass for this checklist:

- Run default mode for top 3-5 critical gaps.
- Run `--all` when you need full coverage and complete gap list.
- Treat each `High` gap as a checklist blocker.
- Update this checklist status only after the gap has file-based evidence of closure.

The checklist areas above intentionally mirror `skills/llm-doc-audit/references/checklist.md` so manual review and skill-based audit produce the same result.

## References

- [Three-Tier Model](../01-fundamentals/three-tier-model.md)
- [Incremental Adoption](../01-fundamentals/incremental-adoption.md)
- [AGENTS.md](../05-tool-guides/agents-md.md)
- [Hooks](../05-tool-guides/hooks.md)
- [Skills](../05-tool-guides/skills.md)
