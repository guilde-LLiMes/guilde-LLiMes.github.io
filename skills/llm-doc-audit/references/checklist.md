# LLM Documentation Audit Checklist (Validation Areas)

Use this checklist to audit whether a project clearly documents its own rules for LLMs.
Goal: detect missing or unclear guidance, not force one specific project structure.

## 0. Audit Method

- [ ] Audit is evidence-based
  - Every finding references real files and current content.
- [ ] Audit distinguishes missing vs unclear vs outdated
  - Missing = no guidance, unclear = ambiguous guidance, outdated = no longer matches codebase.
- [ ] Audit avoids prescriptive architecture demands
  - Recommend clarity and coverage, not "must use this exact pattern."

## 1. Core LLM Context Coverage

- [ ] Project intent is documented for LLMs
  - Project has a clear statement of what it does and what it does not do.
- [ ] Project structure is explained
  - At least one LLM-facing doc explains major folders/modules and what belongs where.
- [ ] Tech reality is explained
  - Project documents actual stack choices and major constraints (not generic best practices).
- [ ] Working rules are explained
  - LLM-facing docs define coding/testing/security expectations relevant to this project.
- [ ] Boundaries are explained
  - Project documents what LLMs should not change (or must handle with extra caution).

## 2. High-Risk Safety and Reliability Areas

- [ ] API/interface expectations are documented (if applicable)
  - Public/internal contracts and compatibility expectations are discoverable.
- [ ] Security-sensitive rules are documented
  - Guidance exists for secrets, auth/authz, sensitive data, and unsafe operations.
- [ ] Testing expectations are documented at project level
  - LLMs can find test scope, run commands, and minimum validation expected.
- [ ] Package/module testing scope is documented (if multi-package or multi-module)
  - For each package/module with tests, docs state which test levels apply (`unit`, `integration`, `e2e`, or explicit `N/A`).
- [ ] Test framework/tool choice is documented per test type and package/module
  - Docs state which framework/tool is expected for each test type in each package/module (for example, frontend UI E2E vs backend API E2E).
- [ ] Test location and naming conventions are documented
  - LLMs can discover where tests live and expected naming/layout patterns.
- [ ] Test execution commands are documented
  - Docs include full-suite commands and targeted package/module commands.
- [ ] Test setup prerequisites are documented (if applicable)
  - Required environment, fixtures, seed data, mocks, or services are explained.
- [ ] Pre-merge or pre-PR validation is documented
  - Docs define minimum local validation required before proposing changes.
- [ ] CI/local testing expectations are aligned (if CI exists)
  - Docs match what CI actually enforces and avoid conflicting instructions.
- [ ] Critical workflows are constrained
  - Project documents rules for migrations, releases, or other risky operations when relevant.

## 3. Consistency and Team Alignment Areas

- [ ] Decision history is available (if applicable)
  - Architectural decisions or equivalent rationale are documented for LLM context.
- [ ] Error handling approach is documented (if applicable)
  - Project defines expected error patterns and behavior.
- [ ] Performance expectations are documented (if applicable)
  - Project provides practical performance constraints where they matter.
- [ ] Domain language is normalized (if applicable)
  - Terms/entities are documented to prevent naming and concept drift.
- [ ] Documentation map is understandable
  - LLM can discover where rules live and which document is authoritative.

## 4. Tool and Loading Fit

- [ ] LLM docs match tools in use
  - Guidance exists in formats used by the team (for example, AGENTS.md / CLAUDE.md / tool-specific files).
- [ ] Multi-file precedence is understandable
  - If multiple instruction files exist, inheritance/scope behavior is clear.
- [ ] Reusable workflows are documented
  - Skills/sub-agents/hooks are documented where they are part of team workflow.

## 5. Maintenance and Drift Control

- [ ] Rules are linked to verification
  - Important rules map to tests, lint, type checks, CI checks, or scripts.
- [ ] Duplication is controlled
  - Docs avoid conflicting duplicates and point to the source of truth.
- [ ] Update cadence exists
  - Project has an explicit way to keep LLM docs current with architecture/code changes.
- [ ] Failure feedback loop exists
  - Recurring LLM mistakes are captured and turned into doc improvements.

## 6. Audit Output Format

- [ ] Findings are severity-tagged
  - `High`: breakage/safety risk, `Medium`: consistency/review risk, `Low`: maturity/usability gap.
- [ ] Findings include evidence
  - Include file path and short reason.
- [ ] Findings include a minimal improvement action
  - Suggest the smallest useful doc change to close the gap.
- [ ] Findings include validation
  - Explain how to verify the improvement after update.
- [ ] Package/module audits include a testing matrix (if applicable)
  - Include package/module, observed test files, framework mapping per test type, testing doc source, and entrypoint linkage status.
