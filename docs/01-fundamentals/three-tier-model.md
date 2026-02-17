---
layout: default
title: Three-Tier Model
nav_order: 1
parent: Fundamentals
---

# Three-Tier Model

Not all guidelines carry equal weight. Some prevent real breakage. Others improve consistency. A few only matter at scale. Treating them all as equally urgent leads to either paralysis (too much to write) or a bloated guidelines file that the model can't reliably follow.

guide-LLiMes organizes guidelines into three tiers based on a single question: **"If we skip this, what breaks?"**

## The Tiers

### Must-Have — Prevent breakage

These are non-negotiable. Without them, the LLM will produce code that fundamentally doesn't fit your project.

| Guideline | What breaks without it |
|---|---|
| [Project Scope](../02-must-have/project-scope.md) | Model invents features outside your domain |
| [Tech Stack](../02-must-have/tech-stack.md) | Model suggests wrong languages, frameworks, libraries |
| [Coding Standards](../02-must-have/coding-standards.md) | Every generation looks different, diffs are noisy |
| [Testing Strategy](../02-must-have/testing-strategy.md) | Model skips tests or writes wrong types |
| [Directory Structure](../02-must-have/directory-structure.md) | Files land in wrong places, imports break |
| [API Contracts](../02-must-have/api-contracts.md) | Model breaks public interfaces, ignores versioning |
| [Security Basics](../02-must-have/security-basics.md) | Model logs secrets, bypasses auth |
| [LLM Guardrails](../02-must-have/llm-guardrails.md) | Model modifies migrations, CI configs, infra |

**When to write**: Stage 1. Pick at least 3 that matter most for your project.

### Should-Have — Reduce variance

These make LLM output more predictable and reviewable. The model can produce working code without them, but the quality and consistency will fluctuate.

| Guideline | What improves with it |
|---|---|
| [Spec Templates](../03-should-have/spec-templates.md) | Prompts become consistent, nothing gets forgotten |
| [ADRs](../03-should-have/adrs.md) | Model understands *why* things are the way they are |
| [Review Guidelines](../03-should-have/review-guidelines.md) | Reviews are faster, expectations are clear |
| [Error Handling](../03-should-have/error-handling.md) | Errors are typed, logged, and handled uniformly |
| [Performance Expectations](../03-should-have/performance-expectations.md) | Model considers scale, doesn't write naive implementations |
| [Test Data Conventions](../03-should-have/test-data-conventions.md) | Tests are isolated, reproducible, not flaky |
| [Documentation Structure](../03-should-have/documentation-structure.md) | Docs go in the right place, stay findable |

**When to write**: Within the first month. Prioritize based on where you see the most variance in LLM output.

### Nice-to-Have — Scale and compliance

These matter when your team grows, your domain is regulated, or you want to prevent long-term architecture drift.

| Guideline | When it becomes necessary |
|---|---|
| [CI Quality Gates](../04-nice-to-have/ci-quality-gates.md) | Team > 3 people, or many LLM-generated PRs |
| [Architecture Tests](../04-nice-to-have/architecture-tests.md) | Module boundaries are being quietly violated |
| [Domain Glossary](../04-nice-to-have/domain-glossary.md) | Model invents conflicting terms for the same concept |
| [Migration Rules](../04-nice-to-have/migration-rules.md) | Schema changes are frequent and risky |
| [Security Playbook](../04-nice-to-have/security-playbook.md) | Domain handles sensitive data or is regulated |
| [LLM Evaluation Loop](../04-nice-to-have/llm-evaluation-loop.md) | You want to systematically improve guideline effectiveness |

**When to write**: First quarter onward, driven by actual pain points.

## How to Use This Model

1. **Start with must-haves.** Pick the 3 that address your biggest pain points. Write them. Use them for a week.
2. **Observe what goes wrong.** If the LLM keeps making the same type of mistake, there's a missing guideline for it.
3. **Promote as needed.** Something you thought was "nice-to-have" might turn out to be a must-have for your project. The tiers are starting points, not fixed categories.
4. **Don't write everything at once.** A guidelines file with 50 rules that you wrote in one sitting is almost certainly too broad, too shallow, or both.

## Tier Boundaries Are Project-Specific

A healthcare startup handling patient data will need [Security Basics](../02-must-have/security-basics.md) as a deep, detailed must-have from day one. A weekend side project might skip it entirely.

A team building a public API will treat [API Contracts](../02-must-have/api-contracts.md) as critical. An internal tool with no external consumers might keep it minimal.

Use the tiers as a framework for thinking about priority, not as universal truth.

---

Next: [Token Budgets](token-budgets.md) — why your guidelines can't be infinitely long.

## References

- [External References](../references.md)
