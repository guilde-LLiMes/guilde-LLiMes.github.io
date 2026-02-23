---
name: llm-doc-audit
description: Audit a project's LLM-facing documentation for coverage, clarity, drift, and instruction reachability. Use when asked to assess AGENTS.md, CLAUDE.md, Cursor rules, Copilot instructions, or equivalent instruction docs, including whether scoped docs are reachable from canonical entrypoints and whether testing guidance is clear at package/module level in monorepos. Default output is top 3-5 critical changes; pass --all for full findings.
---

# LLM Documentation Audit Skill

Use this skill to audit whether a project clearly documents its own structure, rules, and boundaries for LLMs.
Do not enforce a single architecture pattern. Validate clarity, completeness, and maintainability of what the project actually documents.

## Inputs

- Repository root
- LLM-facing docs (for example: `AGENTS.md`, `CLAUDE.md`, `.cursor/rules/*.mdc`, `copilot-instructions.md`)
- Test file inventory from repository scan (for example: `test/`, `tests/`, `__tests__/`, `e2e/`, `integration/`)
- Documentation checklist artifact when present (for example: `docs/00-introduction/framework-checklist.md`)
- Generated checklist data when present (`_data/framework-checklist.generated.yml`)
- Required audit-area map when present (`_data/framework-checklist.required-audit-areas.yml`)
- Checklist generation/parity scripts when present (`scripts/build-framework-checklist.rb`, `scripts/validate-framework-checklist-parity.rb`)
- Skill catalog docs when present (for example: `docs/05-tool-guides/skills.md`, `skills/README.md`)
- Validation protocol skill when present (`skills/validation-protocol/SKILL.md`)
- Optional incident reports describing prior instruction failures (for example: `dev/incidents/*.md`)
- Optional mode flag: `--all` (return full findings list instead of top 3-5)
- `references/checklist.md`

## Audit Rules

- Classify each issue as `missing`, `unclear`, or `outdated`.
- Use evidence from repository files for every finding.
- Mark non-relevant checklist items as `N/A` with a short reason.
- Prefer smallest useful documentation fix over broad rewrites.
- Prioritize high-risk gaps first (safety, API contracts, testing, boundaries).
- Default to concise recommendations: return only the top 3-5 highest-value changes.
- If `--all` is provided, return all findings in severity order with per-item actions and validation.
- For testing guidance, require explicit scope and commands; do not infer intent from folder names alone.
- Treat unreachable instructions as a first-class gap: rules that exist but are not discoverable from active instruction entrypoints are effectively missing.
- Require explicit scope and precedence when multiple instruction files exist.
- Check whether a project-level documentation checklist artifact exists and is discoverable from onboarding paths.
- If generated checklist data exists, treat it as canonical checklist source and verify it matches frontmatter metadata from contributing docs.
- If parity validation script exists, run it (or emulate its checks) and include result in findings.
- When `skills/validation-protocol/SKILL.md` exists, require documentation that explains when to use it and where `DEBUG.md` should live.
- If a project uses skill routing, require one canonical routing location and links instead of duplicated routing tables.
- Require section/document responsibility boundaries (mission, in-scope, out-of-scope) where the docs define framework structure.

## Workflow

1. Discover LLM-facing documentation files and test files in the repository.
2. Build an instruction topology map:
   - Canonical entrypoints (for example, root `AGENTS.md`, `CLAUDE.md`, tool-specific top-level rule files).
   - Scoped instruction files (nested `AGENTS.md`, package-level docs, workflow-specific rule files).
   - Explicit cross-links from entrypoints to scoped files.
   - Scope and precedence statements for multi-file setups.
   - Responsibility ownership statements for section/docs pages (mission/in-scope/out-of-scope when present).
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
10. Run an operational workflow coverage pass:
   - Verify documentation checklist artifact coverage and discoverability.
   - Verify Validation Protocol integration path (`validation-protocol` -> `DEBUG.md` + entrypoint link expectations).
   - Verify skill routing ownership and non-duplication (when routing is used).
11. Run checklist parity pass when framework checklist exists:
   - Compare `_data/framework-checklist.generated.yml` coverage and sections against `references/checklist.md` coverage areas.
   - Compare `_data/framework-checklist.generated.yml` against frontmatter metadata in contributing docs.
   - Run `scripts/validate-framework-checklist-parity.rb` when available and capture pass/fail evidence.
   - Flag mismatches where generated checklist coverage omits a high-risk audit area.
12. Run responsibility-overlap pass:
   - Detect duplicate full-guidance blocks across section branches.
   - Prefer one canonical owner page plus links from non-owner pages.

## Output Format

Return findings in this order:

1. Summary counts: `High`, `Medium`, `Low`, `N/A`.
2. Instruction topology summary:
   - canonical entrypoint(s)
   - scoped instruction files discovered
   - linked vs unlinked scoped files
   - precedence clarity status
3. Findings section:
   - default: critical changes only (top 3-5, ordered by value/risk)
   - `--all`: full findings list (ordered by severity)
   - each finding includes:
   - checklist area
   - gap type (`missing`, `unclear`, `outdated`)
   - evidence (file path + short reason)
   - minimal improvement action
   - validation method
4. Remaining gaps overview (default mode only, no deep list):
   - count of remaining gaps by severity
   - 1-2 line pattern summary (for example: "mostly low-severity clarity gaps in test naming")
5. Package/module testing matrix (if applicable):
   - default: include only rows tied to top 3-5 critical changes
   - `--all`: include full matrix
6. Operational workflow coverage summary:
   - checklist artifact status (present/reachable or gap)
   - validation protocol integration status
   - skill routing canonical-location status (or `N/A`)
7. Framework checklist parity summary (when applicable):
   - parity status (`aligned` or `drifted`)
   - drift evidence and minimal fix
   - parity script result (`pass` or `fail`) when script exists
8. Responsibility overlap summary:
   - overlap status (`clear ownership` or `overlap detected`)
   - duplicate areas and canonical-owner recommendation
9. Expansion prompt (default mode only):
   - ask whether to rerun with `--all` for complete findings.

## Guardrails

- Do not claim a problem without file-based evidence.
- Do not prescribe tool adoption that the team does not use.
- Do not suggest implementation-heavy changes when a doc clarification solves the gap.
- Do not require all test levels (`unit`/`integration`/`e2e`) when the project intentionally uses a subset; require explicit documentation of that choice.
- Do not require one framework across packages; require explicit framework choices and boundaries for each package/module and test type.
- Do not assume toolchains recursively load nested instruction files; require explicit linkage evidence.
- Do not require a specific number of skills; require only clear ownership and non-duplicated routing documentation when routing is used.
