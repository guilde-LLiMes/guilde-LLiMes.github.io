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

Mark each item as done only when the evidence is in-repo and discoverable.

### A) Core Context Coverage

- [ ] Project intent is explicit (what the system does and does not do).
- [ ] Tech stack is explicit (languages, frameworks, data stores, major constraints).
- [ ] Directory/module structure is explicit (where code belongs, dependency direction).
- [ ] Coding/testing/security rules are explicit and imperative.
- [ ] High-risk boundaries are explicit (protected files, ask-first changes, unsafe operations).

### B) Safety and Reliability Coverage

- [ ] API/interface compatibility expectations are documented (if applicable).
- [ ] Security-sensitive handling is documented (secrets, auth/authz, sensitive data).
- [ ] Testing scope is documented at project level (what test levels apply).
- [ ] Test commands are documented (full suite + targeted package/module runs).
- [ ] Critical workflows are constrained (migrations, release, infra, or explicit N/A).

### C) Testing and Verification Coverage

- [ ] Test location and naming conventions are documented.
- [ ] Test prerequisites are documented (env, fixtures, seed data, services) or explicit N/A.
- [ ] Pre-PR/pre-merge local validation is documented.
- [ ] CI expectations and local expectations are aligned.
- [ ] Each critical rule maps to deterministic verification (hook, script, CI check, or command).

### D) Instruction Topology and Loading Fit

- [ ] Canonical entrypoint is explicit (`AGENTS.md`, `CLAUDE.md`, or both).
- [ ] Scope/precedence of multi-file instructions is explicit.
- [ ] Scoped instruction files are reachable from canonical entrypoints.
- [ ] No mandatory constraints are isolated in orphan docs.
- [ ] Tool-specific docs exist only where tool-specific behavior is needed.

### E) Operational Validation Coverage

- [ ] Validation protocol/guidance exists for debugging and verification operations.
- [ ] `DEBUG.md` workflow is explicit (how it is generated, refreshed, and linked from entrypoints).
- [ ] If skills are used, routing is documented once in a canonical location (no duplicated routing tables).
- [ ] Tooling references point to artifact outcomes first (what must exist), then optional skill/workflow.

### F) Maintenance and Drift Control

- [ ] Stage/trigger-based review criteria exist for LLM-facing docs.
- [ ] Recurring failures are captured and converted into doc updates.
- [ ] Duplication conflicts are controlled (single source of truth per rule set).
- [ ] Stale guidance has owner + planned update or removal.
- [ ] Changes in architecture/tooling trigger checklist review.

### G) Adoption and Rollout

- [ ] Team can point to 3 must-have rules already active.
- [ ] Team has at least one enforced quality gate (hook/wrapper/CI).
- [ ] Team has at least one operational skill in routine workflow use.
- [ ] Owner and review date are assigned.
- [ ] "Done for now" scope is explicit (what is intentionally deferred).

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
