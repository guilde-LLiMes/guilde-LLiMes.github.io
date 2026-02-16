---
layout: default
title: LLM Evaluation Loop
nav_order: 6
parent: Nice-to-Have
---

# LLM Evaluation Loop

## Why This Matters

Guidelines are hypotheses about what the model needs to know. Some work well. Others get ignored or misinterpreted. Without a feedback loop, you can't tell the difference.

An evaluation loop tracks which guidelines are effective, which are failing, and how to iterate — turning guideline writing from guesswork into a systematic process.

## What to Include

- **How to track LLM mistakes** — categories, frequency, patterns
- **How to trace mistakes to guidelines** — was the guideline missing, unclear, or ignored?
- **When to update guidelines** — triggers for revision
- **Prompt pattern library** — recording what works for reuse

## How to Write It

1. **Start simple.** A shared document or issue label where the team records "the LLM got this wrong." No tooling needed.
2. **Categorize failures.** Wrong framework, wrong file location, wrong test type, security violation, architecture violation — each category maps to a guideline.
3. **Review monthly.** Look at failure patterns. If one category dominates, that guideline needs work.

## Example

```markdown
## LLM Evaluation

Track failures in: GitHub issues with label "llm-quality"

Failure categories:
- wrong-framework  → Tech Stack guideline
- wrong-location   → Directory Structure guideline
- wrong-test-type  → Testing Strategy guideline
- security-issue   → Security Basics guideline
- style-mismatch   → Coding Standards guideline
- scope-creep      → Project Scope guideline

Monthly review:
- Count failures by category
- Top category → rewrite or expand that guideline
- If a guideline is followed consistently → it's working, leave it
- If a guideline is consistently ignored → it may be too vague, too buried,
  or conflicting with another guideline

Prompt patterns:
- Record prompts that produce consistently good results
- Share in docs/prompts/ as reusable snippets
- Retire prompts that stop working (model updates)
```

## Common Mistakes

**Not tracking at all.** Without data, guideline updates are based on gut feeling. Even a simple tally is better than nothing.

**Blaming the model instead of the guideline.** When the LLM makes a mistake, the first question should be "is there a guideline for this?" followed by "is the guideline clear enough?" The model follows instructions — if it's not following yours, the instructions may be the problem.

**Never retiring guidelines.** Some guidelines become unnecessary as the model improves or the project stabilizes. Keeping them wastes token budget.

## Tool-Specific Notes

- **Claude Code**: CLAUDE.md supports iterative refinement — use `/init` to regenerate periodically and compare with your manual version.
- **All tools**: This is a process guideline, not a tool configuration. It works the same regardless of which LLM tool you use.

## References

- [External References](../references.md)
