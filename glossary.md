---
layout: default
title: Glossary
nav_order: 8
---

# Glossary

Key terms used throughout guide-LLiMes.

**ADR (Architecture Decision Record)** — A short document recording a significant technical decision: what was decided, why, and what alternatives were rejected. See [ADRs](docs/03-should-have/adrs.md).

**Context window** — The total amount of text an LLM can process at once, including system prompt, conversation, code, and your guidelines. Measured in tokens.

**Guardrail** — A constraint on LLM behavior: files it can't modify, steps it must run, decisions that require human approval. See [LLM Guardrails](docs/02-must-have/llm-guardrails.md).

**Guideline** — An explicit instruction that gives the LLM context about your project. Dense, scannable, actionable. Not documentation for humans — instructions for the model.

**Must-have** — A guideline that prevents fundamental breakage. Without it, the LLM will produce code that doesn't fit the project at all. See [Must-Have Guidelines](docs/02-must-have/index.md).

**Nice-to-have** — A guideline that matters at scale or in regulated domains. Adds rigor but isn't needed until the project matures. See [Nice-to-Have Guidelines](docs/04-nice-to-have/index.md).

**Should-have** — A guideline that reduces variance in LLM output. The model can work without it, but quality and consistency improve with it. See [Should-Have Guidelines](docs/03-should-have/index.md).

**System prompt** — Hidden instructions prepended to every LLM conversation. Your guidelines become part of this prompt (or are loaded alongside it) by the tool you use.

**Token** — The unit of text that LLMs process. Roughly 1 token = 0.75 words in English. Your guidelines consume tokens from the context window.

**Token budget** — The practical limit on how many instructions your guidelines can contain before the model starts ignoring or conflating rules. See [Token Budgets](docs/01-fundamentals/token-budgets.md).

**Three-tier model** — guide-LLiMes' framework for prioritizing guidelines: must-have (prevent breakage), should-have (reduce variance), nice-to-have (scale and compliance). See [Three-Tier Model](docs/01-fundamentals/three-tier-model.md).

**Ubiquitous language** — A shared vocabulary where every concept has exactly one name, used consistently in code, documentation, and conversation. From Domain-Driven Design. See [Domain Glossary](docs/04-nice-to-have/domain-glossary.md).
