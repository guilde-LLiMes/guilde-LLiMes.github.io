# Playwright Guide Template

Use this template for canonical project docs, for example `docs/testing/playwright.md`.

## 1. Problem

State what is currently ambiguous for LLMs:

- where Playwright tests belong
- what frontend app(s) they target
- which commands to run

## 2. Value

Describe the improvement after adoption:

- correct file placement for new tests
- predictable naming conventions
- consistent local and CI validation

## 3. When To Use

Provide concrete decision cues:

- adding a new user flow E2E test
- updating existing browser interaction assertions
- creating fixtures/page objects for frontend integration paths

## 4. Project Conventions

Document exact conventions:

- canonical directory: `tests/e2e/` (or actual detected path)
- file naming: `*.spec.ts`
- config location: `playwright.config.ts`
- frontend targets: list app directories and base URLs

## 5. Commands

Document exact commands from the repository:

- smoke: `pnpm playwright test --grep @smoke`
- full: `pnpm playwright test`
- debug: `pnpm playwright test --ui`

Adjust for actual package manager and scripts.

## 6. Boundaries

Document non-negotiables:

- never hit production data
- no brittle selectors when role/test-id exists
- no unrelated snapshots without approval

## 7. Validation

Document what must pass before merge:

- required command(s)
- expected CI job name or workflow
