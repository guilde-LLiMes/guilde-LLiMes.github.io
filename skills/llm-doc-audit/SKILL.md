---
name: llm-doc-audit
description: Audit a project's LLM-facing documentation for coverage, clarity, and drift. Use when asked to assess AGENTS.md, CLAUDE.md, Cursor rules, Copilot instructions, or equivalent instruction docs, including whether testing guidance is clear at package/module level in monorepos, and produce evidence-based gap findings with minimal improvement actions.
---

# LLM Documentation Audit Skill

Use this skill to audit whether a project clearly documents its own structure, rules, and boundaries for LLMs.
Do not enforce a single architecture pattern. Validate clarity, completeness, and maintainability of what the project actually documents.

## Inputs

- Repository root
- LLM-facing docs (for example: `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/*.mdc`, `copilot-instructions.md`)
- Test file inventory from repository scan (for example: `test/`, `tests/`, `__tests__/`, `e2e/`, `integration/`)
- `references/SKILL-VALIDATION-CHECKLIST.md`

## Audit Rules

- Classify each issue as `missing`, `unclear`, or `outdated`.
- Use evidence from repository files for every finding.
- Mark non-relevant checklist items as `N/A` with a short reason.
- Prefer smallest useful documentation fix over broad rewrites.
- Prioritize high-risk gaps first (safety, API contracts, testing, boundaries).
- For testing guidance, require explicit scope and commands; do not infer intent from folder names alone.

## Workflow

1. Discover LLM-facing documentation files and test files in the repository.
2. Map available files to checklist sections in `references/SKILL-VALIDATION-CHECKLIST.md`.
3. Evaluate each checklist item:
   - `Pass`: clear and sufficient
   - `Gap`: missing/unclear/outdated
   - `N/A`: not relevant for this project
4. Run a package/module testing documentation pass:
   - Build a package/module matrix from discovered test files.
   - For each package/module, check whether docs define test scope (`unit`, `integration`, `e2e`, or explicit `N/A`), framework/tool per test type, test locations, run commands, and minimum validation.
   - Treat root-only testing docs as sufficient only when they explicitly apply to all packages/modules.
5. Assign severity:
   - `High`: breakage or safety risk
   - `Medium`: consistency/review risk
   - `Low`: maturity/usability improvement
6. Propose a minimal improvement action for each gap.
7. Define a validation method for each proposed action.

## Output Format

Return findings in this order:

1. Summary counts: `High`, `Medium`, `Low`, `N/A`.
2. Findings list (ordered by severity), each including:
   - checklist area
   - gap type (`missing`, `unclear`, `outdated`)
   - evidence (file path + short reason)
   - minimal improvement action
   - validation method
3. Package/module testing matrix (if applicable), with:
   - package or module
   - observed test file evidence
   - framework/tool mapping per test type (or missing)
   - testing documentation source (or missing)
   - instruction entrypoint linkage status (`AGENTS.md`, `CLAUDE.md`, equivalent)
4. Quick wins: top 3 smallest high-value improvements.

## Guardrails

- Do not claim a problem without file-based evidence.
- Do not prescribe tool adoption that the team does not use.
- Do not suggest implementation-heavy changes when a doc clarification solves the gap.
- Do not require all test levels (`unit`/`integration`/`e2e`) when the project intentionally uses a subset; require explicit documentation of that choice.
- Do not require one framework across packages; require explicit framework choices and boundaries for each package/module and test type.
