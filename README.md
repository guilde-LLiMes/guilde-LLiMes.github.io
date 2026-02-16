---
layout: default
title: Home
nav_order: 1
permalink: /
---

# guide-LLiMes

**A framework for building LLM coding guidelines that actually work.**

Most teams using LLMs for code generation struggle with the same problem: the model doesn't know your project. It doesn't know your stack, your conventions, your architecture decisions, or what it should never touch. So it guesses — and the guesses are inconsistent, sometimes wrong, and expensive to fix.

The fix isn't better prompts. It's better project context.

guide-LLiMes teaches you **why** each type of guideline matters and **how** to write one that LLMs can actually follow. It's not a template to copy-paste. It's a method for building guidelines that fit your specific project, team, and tools.

## Who This Is For

- **Team leads and architects** setting up guidelines for a team
- **Individual developers** who want better LLM output on their own projects
- **Anyone** using Claude Code, Cursor, GitHub Copilot, or other LLM coding tools

## The Core Idea

Not all guidelines are equally important. guide-LLiMes organizes them into three tiers:

| Tier | Purpose | When to add |
|------|---------|-------------|
| [**Must-have**](docs/02-must-have/index.md) | Prevent breakage. Without these, LLMs will hallucinate features, break APIs, and create files in wrong places. | Day 1 |
| [**Should-have**](docs/03-should-have/index.md) | Reduce variance. These make LLM output more consistent and reviewable. | Month 1 |
| [**Nice-to-have**](docs/04-nice-to-have/index.md) | Scale and compliance. These matter when your team grows or regulations apply. | Quarter 1+ |

Start with 3 must-haves. Add more as you see what the LLM gets wrong.

## Reading Paths

| You want to... | Start here | Time |
|---|---|---|
| Get guidelines running fast | [Three-tier model](docs/01-fundamentals/three-tier-model.md) → pick 3 from [Must-haves](docs/02-must-have/index.md) → write them | ~15 min |
| Understand the full framework | [Why guidelines matter](docs/00-introduction/why-guidelines-matter.md) → read through Fundamentals → all Must-haves | ~2 hrs |
| Set up a specific tool | [Tool guides](docs/05-tool-guides/index.md) → your tool → reference Must-haves for content | ~30 min |
| Understand LLM context limits | [Token budgets](docs/01-fundamentals/token-budgets.md) | ~10 min |

## Table of Contents

### Introduction
- [Why Guidelines Matter](docs/00-introduction/why-guidelines-matter.md) — the cost of not having them
- [What Makes a Good Guideline](docs/00-introduction/what-makes-a-good-guideline.md) — dense, scannable, LLM-consumable
- [Tool Landscape](docs/00-introduction/tool-landscape.md) — CLAUDE.md, Cursor rules, Copilot instructions, AGENTS.md

### Fundamentals
- [Three-Tier Model](docs/01-fundamentals/three-tier-model.md) — must / should / nice-to-have framework
- [Token Budgets](docs/01-fundamentals/token-budgets.md) — context window limits and information density
- [Incremental Adoption](docs/01-fundamentals/incremental-adoption.md) — from zero to full coverage

### Must-Have Guidelines
- [Overview](docs/02-must-have/index.md)
- [Project Scope](docs/02-must-have/project-scope.md) — what the system does and doesn't do
- [Tech Stack](docs/02-must-have/tech-stack.md) — languages, frameworks, architecture
- [Coding Standards](docs/02-must-have/coding-standards.md) — how code should look
- [Testing Strategy](docs/02-must-have/testing-strategy.md) — test types, boundaries, coverage
- [Directory Structure](docs/02-must-have/directory-structure.md) — where things go
- [API Contracts](docs/02-must-have/api-contracts.md) — schemas, versioning, compatibility
- [Security Basics](docs/02-must-have/security-basics.md) — auth, secrets, compliance
- [LLM Guardrails](docs/02-must-have/llm-guardrails.md) — what the model can and can't do

### Should-Have Guidelines
- [Overview](docs/03-should-have/index.md)
- [Spec Templates](docs/03-should-have/spec-templates.md) — standard format for new work
- [Architecture Decision Records](docs/03-should-have/adrs.md) — why things are the way they are
- [Review Guidelines](docs/03-should-have/review-guidelines.md) — what reviewers check
- [Error Handling](docs/03-should-have/error-handling.md) — error taxonomy and patterns
- [Performance Expectations](docs/03-should-have/performance-expectations.md) — SLAs and bottlenecks
- [Test Data Conventions](docs/03-should-have/test-data-conventions.md) — fixtures and isolation
- [Documentation Structure](docs/03-should-have/documentation-structure.md) — where docs live

### Nice-to-Have Guidelines
- [Overview](docs/04-nice-to-have/index.md)
- [CI Quality Gates](docs/04-nice-to-have/ci-quality-gates.md) — automated checks
- [Architecture Tests](docs/04-nice-to-have/architecture-tests.md) — constraints as code
- [Domain Glossary](docs/04-nice-to-have/domain-glossary.md) — ubiquitous language
- [Migration Rules](docs/04-nice-to-have/migration-rules.md) — schema changes and rollouts
- [Security Playbook](docs/04-nice-to-have/security-playbook.md) — incident response
- [LLM Evaluation Loop](docs/04-nice-to-have/llm-evaluation-loop.md) — feedback and refinement

### Tool Guides
- [Overview](docs/05-tool-guides/index.md) — cross-tool mental model
- [Claude Code](docs/05-tool-guides/claude-code.md) — CLAUDE.md
- [Cursor](docs/05-tool-guides/cursor.md) — .cursor/rules/*.mdc
- [GitHub Copilot](docs/05-tool-guides/github-copilot.md) — copilot-instructions.md
- [AGENTS.md](docs/05-tool-guides/agents-md.md) — the emerging standard

### Reference
- [Glossary](glossary.md) — key terms and definitions
