---
layout: default
title: Nice-to-Have
nav_order: 6
has_children: true
permalink: /nice-to-have/
---

# Nice-to-Have Guidelines

These guidelines matter at scale: larger teams, regulated domains, mature codebases, or projects where LLM usage is heavy enough that subtle drift becomes a real problem.

Don't start here. These build on a solid foundation of [must-haves](../02-must-have/index.md) and [should-haves](../03-should-have/index.md). Add them when you feel the specific pain they address.

## The Seven Nice-to-Haves

| # | Guideline | When it becomes necessary |
|---|---|---|
| 1 | [CI Quality Gates](ci-quality-gates.md) | Many PRs, many contributors, or heavy LLM-generated code |
| 2 | [Architecture Tests](architecture-tests.md) | Module boundaries are being quietly violated |
| 3 | [Domain Glossary](domain-glossary.md) | Model uses inconsistent terms for the same concept |
| 4 | [Migration Rules](migration-rules.md) | Frequent schema changes with production data |
| 5 | [Security Playbook](security-playbook.md) | Regulated domain, sensitive data, compliance requirements |
| 6 | [LLM Evaluation Loop](llm-evaluation-loop.md) | You want to systematically improve guideline effectiveness |
| 7 | [Applied Practice Patterns](applied-practice-patterns.md) | You want practical, reusable examples kept separate from core rules |

## Trigger Signals

You need these when:

- The same type of mistake keeps recurring despite having a guideline → your guidelines need [evaluation](llm-evaluation-loop.md)
- Model-generated code passes review but slowly breaks architecture → [architecture tests](architecture-tests.md)
- New team members (or new LLM sessions) use different terms for the same thing → [domain glossary](domain-glossary.md)
- A production incident traces back to a schema migration → [migration rules](migration-rules.md)
- Teams ask for "show me a concrete workflow" without bloating core guidance → [applied practice patterns](applied-practice-patterns.md)

## References

- [External References](../references.md)
