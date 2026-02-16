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
- Keep guidelines current: review monthly, prune stale rules, and keep instructions aligned with current architecture.
- Do not duplicate tooling: if automation enforces a rule, reference the check instead of restating it.

## Rollout Guidance

- Start with 3 must-have guidelines.
- Expand incrementally as repeat failure patterns appear.
- Add should-have and nice-to-have guidance when the pain justifies the extra context cost.
