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

{% include components/framework-checklist-generated.html %}

## Checklist Execution Flow

Use skills to turn checklist items into concrete action:

1. `llimes-audit`: verify coverage and highlight missing or weak artifacts that block reliable LLM output.
2. `llimes-knowledge`: expand audit findings into concrete artifact planning and document responsibility boundaries.
3. `validation-protocol`: add reproducible runtime verification guidance in `DEBUG.md` when checklist items depend on runtime behavior.
4. `playwright-doc-bootstrap`: add Playwright testing documentation when E2E guidance is missing.

## Traceability Pattern (Use This Table)

| Failure Pattern | Rule Added | Enforcement |
|---|---|---|
| LLM changed protected files | LLM Guardrails | Pre-tool hook or CI policy check |
| Wrong stack/library suggestions | Tech Stack | Review gate + type/lint failures |
| Inconsistent file placement | Directory Structure | Path lint/check script |

## Related Skills

- `llimes-audit`: audits documentation coverage and highlights the highest-risk gaps.
- `llimes-knowledge`: helps plan artifact rollout and document responsibility boundaries.
- `validation-protocol`: builds/refreshes runtime validation guidance in `DEBUG.md`.
- `playwright-doc-bootstrap`: adds Playwright-specific testing documentation when E2E coverage is missing.

Full skill catalog and installation steps: [Skills](../06-skills/index.md).

## References

- [Three-Tier Model](../01-fundamentals/three-tier-model.md)
- [Incremental Adoption](../01-fundamentals/incremental-adoption.md)
- [AGENTS.md](../05-tool-guides/agents-md.md)
- [Hooks](../05-tool-guides/hooks.md)
- [Skills](../06-skills/index.md)
