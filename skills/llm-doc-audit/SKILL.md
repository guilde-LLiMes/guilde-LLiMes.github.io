---
name: llm-doc-audit
description: Audit a project's LLM-facing documentation for coverage, clarity, drift, and instruction reachability. Use when asked to assess AGENTS.md, CLAUDE.md, Cursor rules, Copilot instructions, or equivalent instruction docs, including whether scoped docs are reachable from canonical entrypoints and whether testing guidance is clear at package/module level in monorepos.
---

# LLM Documentation Audit Skill

Use this skill to audit whether a project clearly documents its own structure, rules, and boundaries for LLMs.
Do not enforce a single architecture pattern. Validate clarity, completeness, and maintainability of what the project actually documents.

## Inputs

- Repository root
- LLM-facing docs (for example: `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/*.mdc`, `copilot-instructions.md`)
- Test file inventory from repository scan (for example: `test/`, `tests/`, `__tests__/`, `e2e/`, `integration/`)
- Optional incident reports describing prior instruction failures (for example: `dev/incidents/*.md`)
- `references/checklist.md`

## Audit Rules

- Classify each issue as `missing`, `unclear`, or `outdated`.
- Use evidence from repository files for every finding.
- Mark non-relevant checklist items as `N/A` with a short reason.
- Prefer smallest useful documentation fix over broad rewrites.
- Prioritize high-risk gaps first (safety, API contracts, testing, boundaries).
- Default to concise recommendations: return only the top 3-5 highest-value changes unless the user explicitly asks for full detail.
- For testing guidance, require explicit scope and commands; do not infer intent from folder names alone.
- Treat unreachable instructions as a first-class gap: rules that exist but are not discoverable from active instruction entrypoints are effectively missing.
- Require explicit scope and precedence when multiple instruction files exist.

## Workflow

1. Discover LLM-facing documentation files and test files in the repository.
2. Build an instruction topology map:
   - Canonical entrypoints (for example, root `AGENTS.md`, `CLAUDE.md`, tool-specific top-level rule files).
   - Scoped instruction files (nested `AGENTS.md`, package-level docs, workflow-specific rule files).
   - Explicit cross-links from entrypoints to scoped files.
   - Scope and precedence statements for multi-file setups.
3. Map available files to checklist sections in `references/checklist.md`.
4. Evaluate each checklist item:
   - `Pass`: clear and sufficient
   - `Gap`: missing/unclear/outdated
   - `N/A`: not relevant for this project
5. Run a package/module testing documentation pass:
   - Build a package/module matrix from discovered test files.
   - For each package/module, check whether docs define test scope (`unit`, `integration`, `e2e`, or explicit `N/A`), framework/tool per test type, test locations, run commands, and minimum validation.
   - Treat root-only testing docs as sufficient only when they explicitly apply to all packages/modules.
6. Run an instruction reachability pass:
   - For each high-risk scoped instruction (especially testing and safety), verify it is reachable from at least one canonical entrypoint.
   - Mark unlinked scoped docs as `High` when they contain mandatory constraints that can be missed.
7. Assign severity:
   - `High`: breakage or safety risk
   - `Medium`: consistency/review risk
   - `Low`: maturity/usability improvement
8. Propose a minimal improvement action for each gap.
9. Define a validation method for each proposed action.

## Output Format

Return findings in this order:

1. Summary counts: `High`, `Medium`, `Low`, `N/A`.
2. Instruction topology summary:
   - canonical entrypoint(s)
   - scoped instruction files discovered
   - linked vs unlinked scoped files
   - precedence clarity status
3. Critical changes only (top 3-5, ordered by value/risk), each including:
   - checklist area
   - gap type (`missing`, `unclear`, `outdated`)
   - evidence (file path + short reason)
   - minimal improvement action
   - validation method
4. Remaining gaps overview (no deep list):
   - count of remaining gaps by severity
   - 1-2 line pattern summary (for example: "mostly low-severity clarity gaps in test naming")
5. Package/module testing matrix (if applicable), but concise:
   - include only rows tied to top 3-5 critical changes
6. Expansion prompt:
   - ask whether to provide full findings list with all gaps and per-item actions.

## Guardrails

- Do not claim a problem without file-based evidence.
- Do not prescribe tool adoption that the team does not use.
- Do not suggest implementation-heavy changes when a doc clarification solves the gap.
- Do not require all test levels (`unit`/`integration`/`e2e`) when the project intentionally uses a subset; require explicit documentation of that choice.
- Do not require one framework across packages; require explicit framework choices and boundaries for each package/module and test type.
- Do not assume toolchains recursively load nested instruction files; require explicit linkage evidence.
