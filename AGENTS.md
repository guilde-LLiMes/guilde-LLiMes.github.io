# guide-LLiMes

Framework for building LLM coding guidelines. Markdown docs site (Jekyll + Just the Docs).

## Structure
docs/00-introduction/  → Concepts: why guidelines matter, good guideline properties, tool landscape
docs/01-fundamentals/  → Framework: three-tier model, token budgets, incremental adoption
docs/02-must-have/     → 8 critical guidelines (scope, stack, standards, testing, structure, APIs, security, guardrails)
docs/03-should-have/   → 7 consistency guidelines
docs/04-nice-to-have/  → 6 scale/compliance guidelines
docs/05-tool-guides/   → Tool-specific: Claude Code, Cursor, Copilot, AGENTS.md

## Conventions
- Tone: direct, imperative, no filler
- Guideline page template: Why → What → How → Example → Mistakes → Tool Notes
- Examples: short (10-20 lines), realistic projects, no foo/bar
- All .md files need Jekyll frontmatter (layout, title, nav_order, parent)
- Content teaches WHY and HOW, not prescriptive rules
- Tool-agnostic core, tool-specific appendices

## Don't
- Don't modify _config.yml theme or LICENSE.md
- Don't add build tooling (pure Jekyll, no plugins beyond github-pages gem)
- Don't create boilerplate templates (framework teaches method, not copy-paste)
