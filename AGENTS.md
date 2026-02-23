# guide-LLiMes Core Principles

guide-LLiMes is a framework for building LLM coding guidelines that improve output quality through clear project context.

## Core Principles

- Method first, constraints explicit: teach why and how, then state non-negotiable boundaries clearly.
- Context over prompting tricks: give the model stable project facts (scope, stack, structure, constraints).
- Prioritize by impact: use Must / Should / Nice tiers instead of aiming for completeness.
- Tool-agnostic core, tool-specific edges: keep principles shared and adapt only file format and loading behavior.
- Write for model execution: dense, imperative, scannable, unambiguous, and scoped with DO / DON'T guidance.
- Budget-aware guidance: maximize signal density, remove redundancy, and keep only high-value instructions.
- Safety as first-class: define rules for security, API compatibility, migrations, and protected files.
- Pair guidance with verification: map important rules to tests, lint, type checks, or CI gates.
- Iterate from real failures: add or refine guidance based on observed mistakes, not hypothetical ones.
- Keep guidelines current: review on stage transitions and major changes, prune stale rules, and keep instructions aligned with current architecture.
- Do not duplicate tooling: if automation enforces a rule, reference the check instead of restating it.

## Rollout Guidance

- Start with 3 must-have guidelines.
- Expand incrementally as repeat failure patterns appear.
- Add should-have and nice-to-have guidance when the pain justifies the extra context cost.

## Authoring Pattern (Default)

For tool or feature documentation, structure content in this order:

1. Problem: current user pain or failure pattern.
2. Value: what improves after applying the guidance.
3. When to use: concrete decision cues and scenarios.

## Documentation Responsibility Model (Must)

This repository documents required project artifacts for effective LLM-assisted engineering.
Keep responsibilities explicit and non-overlapping.

Section ownership:
- `docs/00-introduction/`: orientation and adoption flow (what exists, why it matters, how to start).
- `docs/01-fundamentals/`: core method and decision principles.
- `docs/02-must-have/`: minimum artifact requirements that prevent breakage.
- `docs/03-should-have/`: artifact requirements that improve consistency and team alignment.
- `docs/04-nice-to-have/`: maturity artifacts for scale, compliance, and long-run quality.
- `docs/05-tool-guides/`: tool-specific format/loading translation only.

Non-overlap rules:
- Keep each requirement canonical in one page. Other pages link instead of restating.
- Describe artifact outcomes first; mention skills/tools only as implementation paths.
- Avoid repeating operational matrices across multiple pages.
- If a routing list is needed, keep it in one canonical location and reference it.

Per-page responsibility contract:
- Each page should state mission, in-scope content, and out-of-scope content.
- If a page receives content outside its mission, move that content to the owning page and leave a link.

## Local Skills Purpose (Must)

Repository-owned skills live in `skills/*/SKILL.md`.
In this project, `skills/` is primarily product content being authored and maintained.

- Do not treat local skills as always-on runtime routing rules for unrelated repository work.
- Treat `skills/*/SKILL.md` as source artifacts to design, review, test, and improve.
- Run a local skill workflow only when explicitly requested, or when validating that skill's behavior.

Current local skills:
- `llm-doc-audit` (`skills/llm-doc-audit/SKILL.md`)
- `validation-protocol` (`skills/validation-protocol/SKILL.md`)
- `playwright-doc-bootstrap` (`skills/playwright-doc-bootstrap/SKILL.md`)
