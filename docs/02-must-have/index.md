---
layout: default
title: Must-Have
nav_order: 4
has_children: true
permalink: /must-have/
---

# Must-Have Guidelines

These are the non-negotiables. Without them, LLMs will produce code that fundamentally doesn't fit your project — wrong frameworks, wrong file locations, wrong assumptions about what the system does.

You don't need all eight from day one. Pick the 3 that matter most for your project and start there. See [Incremental Adoption](../01-fundamentals/incremental-adoption.md) for the ramp-up strategy.

## The Eight Must-Haves

| # | Guideline | Prevents |
|---|---|---|
| 1 | [Project Scope](project-scope.md) | Model invents features, misunderstands the domain |
| 2 | [Tech Stack](tech-stack.md) | Model suggests wrong languages, libraries, patterns |
| 3 | [Coding Standards](coding-standards.md) | Inconsistent style across generations |
| 4 | [Testing Strategy](testing-strategy.md) | Missing tests, wrong test types, untestable code |
| 5 | [Directory Structure](directory-structure.md) | Files in wrong places, broken imports |
| 6 | [API Contracts](api-contracts.md) | Broken interfaces, ignored versioning |
| 7 | [Security Basics](security-basics.md) | Leaked secrets, bypassed auth, logged PII |
| 8 | [LLM Guardrails](llm-guardrails.md) | Model modifies protected files, skips verification |

## How to Read These Pages

Each page follows the same structure:

- **Why This Matters** — what goes wrong without this guideline
- **What to Include** — specific items to document
- **How to Write It** — step-by-step process for your project
- **Example** — a short, realistic snippet
- **Common Mistakes** — what people get wrong when writing this guideline
- **Tool-Specific Notes** — brief notes on per-tool adaptation

## Choosing Your First Three

If you're not sure which to start with, use this decision tree:

- **You're building an API or backend**: Project Scope + Tech Stack + API Contracts
- **You're building a frontend/fullstack app**: Project Scope + Tech Stack + Directory Structure
- **You're working on an established codebase**: Coding Standards + Testing Strategy + LLM Guardrails
- **You're in a regulated domain**: Project Scope + Security Basics + LLM Guardrails
