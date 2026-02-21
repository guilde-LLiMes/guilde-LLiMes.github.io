# Activation Techniques

Use these steps to make LLM agents consistently apply the new Playwright documentation.

## Canonical Source Rule

- Choose exactly one canonical Playwright guideline file.
- Link to that file from instruction entrypoints instead of duplicating details.

## Entry Point Updates

Update the instruction files used by the team:

- `AGENTS.md`: add where Playwright tests live and where the canonical guide is.
- `CLAUDE.md` or tool-specific rules: add a short pointer to the same canonical guide.
- Testing strategy docs: add a "see canonical Playwright guide" reference.

## Precedence and Scope

- Put global conventions in top-level instruction files.
- Put directory-specific test nuances in nearest scoped instruction file.
- Avoid conflicting wording across files.

## Command Alignment

- Ensure commands in instruction files match package manager and scripts in repo.
- If CI uses wrappers, include both local and CI forms.

## Validation Checklist

- Canonical guide exists at documented path.
- Every relevant instruction entrypoint references the same path.
- Mentioned commands run successfully in the repository.
