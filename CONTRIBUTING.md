---
layout: default
title: Contributing
nav_order: 8
permalink: /contributing/
---

# Contributing to guide-LLiMes

This project improves only when contributors challenge, refine, and expand the guidance with real-world evidence.

If you want to help, focus on one goal: make the framework clearer, safer, and more actionable for teams using LLM coding tools.

## Knowledge Investment (Required)

Before proposing major documentation changes, read:

- [Why Guidelines Matter](docs/00-introduction/why-guidelines-matter.md)
- [What Makes a Good Guideline](docs/00-introduction/what-makes-a-good-guideline.md)
- [Three-Tier Model](docs/01-fundamentals/three-tier-model.md)
- [Must-Have Overview](docs/02-must-have/index.md)

This creates shared context and keeps contributions aligned with the framework's quality bar.

## What to Contribute

High-impact contributions:

- Clarify confusing sections with simpler wording and stronger examples
- Add guidance based on repeat LLM failure patterns observed in real projects
- Improve issue-prone areas: safety, API compatibility, migrations, and testing
- Tighten structure and cross-links so people can find the right guidance quickly
- Add references to automation or checks instead of duplicating enforceable rules

Low-impact contributions (usually rejected):

- Generic advice without project context
- Large rewrites without concrete problem statements
- New sections not tied to observed failure patterns

## Process: Issues First, Then PRs

1. Open or find an issue first.
2. Describe the problem before proposing a solution.
3. Link real examples, failures, or team pain where possible.
4. Keep issue scope specific enough to review in one PR.

Recommended issue structure:

- Current state: what is unclear, missing, or causing bad LLM output
- Desired state: what outcome readers should get instead
- Evidence: examples, failed outputs, review friction, or repeated questions
- Proposed direction: concise change plan

## PR Workflow

1. Link the issue in your PR description.
2. Keep the change set focused on one problem.
3. Explain why each change helps LLM execution quality or reader clarity.
4. Update nearby links and navigation when adding new docs.
5. Add before/after snippets when wording changes are substantial.

PR checklist:

- Scope is clear and tied to an issue
- Language is imperative, dense, and unambiguous
- Must/Should/Nice positioning is justified
- No duplicated rules when automation/checks already enforce behavior
- References and internal links are valid

## Review Criteria

Reviewers prioritize:

- Accuracy and internal consistency
- Actionability for both humans and LLMs
- Signal density (high value per line)
- Safety and compatibility implications
- Maintainability as the framework evolves

Changes that increase word count without increasing clarity or execution value are likely to be requested for revision.

## Local Preview

To preview docs locally:

```bash
bundle install
bundle exec jekyll serve
```

Open the local URL shown by Jekyll and verify navigation, links, and page readability on desktop and mobile widths.

## Community Expectations

- Be specific and evidence-driven
- Assume good intent and review the idea, not the person
- Prefer incremental improvements over broad speculative rewrites
- Keep discussion anchored to improving output quality in real projects

