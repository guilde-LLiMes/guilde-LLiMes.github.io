# Documentation Release Process

This repo is documentation-only. Track versions at repo level and document level without adding per-page version frontmatter.

## 1) On each document change

1. Edit the doc.
2. Register the document version:

```bash
scripts/register-doc-change.sh <doc-path> <doc-version> "<short summary>" [release] [date]
```

Example:

```bash
scripts/register-doc-change.sh docs/02-must-have/api-contracts.md 0.2.0 "Clarify backward compatibility rules"
```

3. Commit with concise commit message (`docs: ...`, `chore: ...`, `feat: ...`).

## 2) Weekly notes draft

Generate concise release notes for recent changes:

```bash
scripts/release-notes.sh
```

Or for a specific range:

```bash
scripts/release-notes.sh <from-ref> <to-ref>
```

## 3) Monthly docs release

1. Generate notes and paste into `CHANGELOG.md`.
2. Bump docs version in `_config.yml`:

```bash
scripts/bump-docs-version.sh [major|minor|patch]
```

3. Tag release:

```bash
git tag docs-vX.Y.Z
git push origin docs-vX.Y.Z
```

4. Move `## [Unreleased]` bullets into `## [X.Y.Z] - YYYY-MM-DD` in `CHANGELOG.md`, then continue adding new changes under `## [Unreleased]`.
