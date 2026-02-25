---
title: "Announcing guide-LLiMes"
layout: post
date: 2026-02-24
author: kirby
tags: [announcement, introduction]
---

**TL;DR:** guide-LLiMes is a framework for writing LLM coding guidelines that models actually follow. Instead of prompting tricks, it uses structured documentation with tiered rules (Must/Should/Nice) that you expand based on real failures.

---

We're excited to introduce **guide-LLiMes**, a framework for building LLM coding guidelines that actually work.

## The Problem

If you've worked with LLMs on code, you've probably experienced:

- Inconsistent output quality
- Hallucinated dependencies or patterns
- Code that "works" but violates project conventions
- Instructions that get ignored or forgotten

Sound familiar? You're not alone.

## Our Approach

guide-LLiMes is built on a few core principles:

### Context Over Tricks

Rather than relying on clever prompting hacks, we focus on giving models **stable project facts**: scope, stack, structure, and constraints. Models perform better when they understand the terrain.

### Tiered Guidance

Not all rules are equal. We use a **Must / Should / Nice** tier system:

- **Must**: Non-negotiable rules that prevent breakage
- **Should**: Guidelines that improve consistency
- **Nice**: Maturity practices for scale

This lets you start minimal and expand based on real failures, not hypothetical ones.

### Tool-Agnostic Core

The principles work across Claude Code, Cursor, Copilot, and other tools. Only the file format and loading behavior change.

## Getting Started

1. **Assess your current state** — Use the [framework checklist](/docs/00-introduction/framework-checklist/) to see what documentation you already have and what's missing.

2. **Understand the methodology** — Browse the [fundamentals](/docs/01-fundamentals/) to learn how structured guidance differs from ad-hoc instructions.

3. **Run the audit skill** — If you're using Claude Code, the `llimes-audit` skill can analyze your existing documentation and identify gaps.

## What's Next

We're building out:

- **Skills** for auditing and improving your documentation
- **Tool guides** for specific IDEs and workflows
- **Patterns** drawn from real-world usage

---

*This is an open project. Contributions and feedback welcome.*
