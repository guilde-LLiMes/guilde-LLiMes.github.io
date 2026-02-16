# guide-LLiMes

## Scope
Framework teaching WHY and HOW to build LLM coding guidelines for any project.
Markdown-first docs site (Jekyll + Just the Docs). NOT a template generator or CLI tool.
Audience: team leads and individual devs using LLM coding tools.

## Stack
Static site: Jekyll with just-the-docs remote theme, GitHub Pages.
Content: Markdown with YAML frontmatter. No JavaScript, no build step.
Repo: github.com/guilde-LLiMes/guilde-LLiMes.github.io

## Structure
docs/00-introduction/  → Why guidelines matter, what makes a good one, tool landscape
docs/01-fundamentals/  → Three-tier model, token budgets, incremental adoption
docs/02-must-have/     → 8 non-negotiable guideline categories (scope, stack, standards, testing, structure, APIs, security, guardrails)
docs/03-should-have/   → 7 consistency guidelines (specs, ADRs, reviews, errors, performance, test data, docs)
docs/04-nice-to-have/  → 6 scale/compliance guidelines (CI gates, arch tests, glossary, migrations, security playbook, eval loop)
docs/05-tool-guides/   → Claude Code, Cursor, Copilot, AGENTS.md implementation guides
glossary.md            → Key terms
_config.yml            → Jekyll config (dark theme, search enabled)

## Standards
Tone: direct, imperative, no fluff, no emojis.
Guideline pages follow template: Why This Matters → What to Include → How to Write It → Example → Common Mistakes → Tool-Specific Notes.
Examples: short realistic snippets (10-20 lines), never foo/bar.
All pages need Jekyll frontmatter: layout, title, nav_order, parent (if child page).
Links: relative markdown links between pages.

## Content Principles
- Teach WHY and HOW, not prescriptive WHAT
- Tool-agnostic core, tool-specific appendices
- Token budget conscious — dense, scannable, actionable
- Incremental adoption — start with 3 must-haves, grow from there

## Guardrails
Don't modify: _config.yml theme settings, LICENSE.md
After changes: verify all internal markdown links resolve
Keep guideline pages under 120 lines each
