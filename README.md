---
layout: default
title: Home
nav_order: 1
permalink: /
---

# <span class="home-brand-title"><span class="home-brand-logos" aria-hidden="true"><img src="/assets/img/logo-inline-56-light.png" alt="" class="theme-logo theme-logo-light" /><img src="/assets/img/logo-inline-56-dark.png" alt="" class="theme-logo theme-logo-dark" /></span><span>guide-<span class="logo-accent">L</span><span class="logo-accent">L</span>i<span class="logo-accent">M</span>es</span></span>

**A framework for building LLM coding guidelines that actually work.**

> **Contributing to the documentation?** Start with the [Contributing Guide](CONTRIBUTING.md). It defines the issue process, PR workflow, and quality bar we use to keep this framework strong.

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
| [**Must-have**](docs/02-must-have/index.md) | Prevent breakage. Without these, LLMs will hallucinate features, break APIs, and create files in wrong places. | Stage 1 |
| [**Should-have**](docs/03-should-have/index.md) | Reduce variance. These make LLM output more consistent and reviewable. | Stage 2 |
| [**Nice-to-have**](docs/04-nice-to-have/index.md) | Scale and compliance. These matter when your team grows or regulations apply. | Stage 3+ |

Start with 3 must-haves. Add more as you see what the LLM gets wrong.

## Reading Paths

| You want to... | Start here | Time |
|---|---|---|
| Get guidelines running fast | [Three-tier model](docs/01-fundamentals/three-tier-model.md) → pick 3 from [Must-haves](docs/02-must-have/index.md) → write them | ~15 min |
| Understand the full framework | [Why guidelines matter](docs/00-introduction/why-guidelines-matter.md) → read through Fundamentals → all Must-haves | ~2 hrs |
| Set up a specific tool | [Tool guides](docs/05-tool-guides/index.md) → your tool → reference Must-haves for content | ~30 min |
| Understand LLM context limits | [Token budgets](docs/01-fundamentals/token-budgets.md) | ~10 min |

## For Contributors

If you want to improve this framework, use the [Contributing Guide](CONTRIBUTING.md) before opening a PR. We intentionally ask contributors to invest in the core concepts first so new content raises the quality bar instead of adding noise.

## Navigation

- [Introduction](docs/00-introduction/index.md)
- [Fundamentals](docs/01-fundamentals/index.md)
- [Must-Have Guidelines](docs/02-must-have/index.md)
- [Should-Have Guidelines](docs/03-should-have/index.md)
- [Nice-to-Have Guidelines](docs/04-nice-to-have/index.md)
- [Tool Guides](docs/05-tool-guides/index.md)
- [Glossary](glossary.md)
- [Contributing Guide](CONTRIBUTING.md)

---

[![GitHub stars](https://img.shields.io/github/stars/guilde-LLiMes/guilde-LLiMes.github.io?style=social)](https://github.com/guilde-LLiMes/guilde-LLiMes.github.io)
[guilde-LLiMes.github.io](https://guilde-llimes.github.io) | [MIT License](LICENSE.md) | [GitHub](https://github.com/guilde-LLiMes/guilde-LLiMes.github.io)

## References

- [External References](docs/references.md)
