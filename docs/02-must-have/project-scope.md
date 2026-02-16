---
layout: default
title: Project Scope
nav_order: 1
parent: Must-Have
---

# Project Scope

## Why This Matters

Without a scope definition, the LLM treats your project as a blank canvas. Ask it to "add notifications" and it might build an entire email service with templates, queues, and retry logic — when you just needed a boolean flag on a database record.

The model doesn't know your domain. It doesn't know what features exist, what features you've deliberately excluded, or what your users actually do. It fills these gaps with assumptions drawn from training data — which means it defaults to the most common pattern, not your pattern.

A clear scope gives the model boundaries. It answers: "What is this system?" and equally important, "What is this system not?"

## What to Include

- **What the system does** — core domain, main entities, primary user actions
- **What it doesn't do** — explicit exclusions that the model might assume exist
- **Primary user journeys** — the 3-5 most important things users do
- **Non-functional constraints** — performance targets, compliance requirements, scale expectations
- **Domain boundaries** — if the system is part of a larger ecosystem, where its responsibility starts and ends

## How to Write It

1. **Start with one sentence.** What does this system do? If you can't say it in one sentence, you might need to narrow scope further.
2. **List the core entities.** These are the nouns of your domain — the things the system manages.
3. **Write 3-5 user actions.** "A user can create a project." "An admin can invite team members." Keep these concrete.
4. **Write the "not this" list.** Think about what an LLM might assume your system does based on similar systems. If you're building a project tracker, the model might assume you have time tracking, invoicing, or Gantt charts. Say explicitly that you don't.
5. **Add constraints.** If there are hard limits (max 1000 users, must respond in < 200ms, SOC 2 compliant), state them.

## Example

```markdown
## Project Scope

Invoice processing service for freelancers. Receives uploaded PDF invoices,
extracts line items via OCR, and stores structured data for export.

Core entities: Invoice, LineItem, Vendor, ExportJob.

Users can:
- Upload PDF invoices (single or batch)
- Review and correct extracted data
- Export to CSV or QuickBooks format
- Set up vendor auto-matching rules

NOT in scope:
- Payment processing (we don't move money)
- Tax calculation (users handle this in their accounting software)
- Multi-currency (USD only for v1)
- User-facing dashboards or analytics

Constraints:
- Process a single invoice in < 5 seconds
- Handle batch uploads of up to 100 invoices
- All invoice data encrypted at rest (SOC 2)
```

## Common Mistakes

**Too vague.** "We're building a web app for managing things" tells the model nothing. Be specific about your domain.

**Missing the "not this" list.** This is the most valuable part. The model's biggest mistakes come from features it assumes exist. Explicitly exclude them.

**Including implementation details.** Scope is about *what*, not *how*. "We use Redis for caching invoice lookups" belongs in [Tech Stack](tech-stack.md), not here.

**Writing it once and forgetting.** Scope changes — features get added, plans shift. If you added multi-currency in v2 but your scope still says "USD only," the model will enforce the wrong constraint.

## Tool-Specific Notes

- **Claude Code**: Put scope at the top of your CLAUDE.md — it's the most important context for every interaction
- **Cursor**: Consider a dedicated `001-project-scope.mdc` rule with `alwaysApply: true`
- **Copilot**: First section of your `copilot-instructions.md`
- **AGENTS.md**: First section of the root-level file

Scope should be in whatever file loads first and always. It sets the foundation for everything else.

## References

- [External References](../references.md)
