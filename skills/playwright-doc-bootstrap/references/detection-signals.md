# Detection Signals

Use these signals to classify Playwright documentation maturity.

## High-Risk Gaps

- `missing`: no Playwright config, no E2E directory convention, and no instruction-file references.
- `unclear`: Playwright exists but test location conventions are not documented.
- `outdated`: docs reference old paths or commands that no longer exist.

## Medium-Risk Gaps

- Test directory structure exists but frontend ownership is unclear.
- Docs mention "E2E" without naming Playwright commands.
- AGENTS/CLAUDE docs mention tests but not canonical doc location.

## Low-Risk Gaps

- Canonical doc exists but lacks examples for naming or fixtures.
- Commands are present but do not include smoke/full test split.
- CI command differs slightly from local docs and needs alignment note.

## Evidence Pattern

For each finding, include:

- `type`: missing, unclear, or outdated
- `severity`: High, Medium, or Low
- `evidence`: path and short reason
- `fix`: smallest doc update that closes the gap
