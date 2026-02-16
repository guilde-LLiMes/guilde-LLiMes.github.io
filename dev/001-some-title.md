# 001 - Principles Alignment Cleanup

## What Shall Be Done

- Keep core guidance principles-first across the docs: method and decision vectors before concrete templates.
- Reduce tool-guide pages to adapter behavior (file location, loading, precedence, limits, caveats) and link to official provider documentation.
- Replace fixed instruction-count claims with budget-aware language (avoid brittle hard numbers as universal truth).
- De-emphasize backend-only example framing where it reads as default guidance; keep examples as optional patterns.
- Resolve ADR sizing guidance so required fields and recommended length are internally consistent.
- Keep references traceable: page-level references already exist, now tighten claim-to-source mapping where practical.

## Why This Shall Be Done

- The framework goal is transferable principles, not prescriptive project recipes.
- Tool behavior can change; official provider docs should remain the source of truth for operational details.
- Hard numeric limits can age quickly and reduce trust when model/tool behavior evolves.
- Backend-centric defaults can narrow perceived audience and reduce practical usefulness for other project types.
- Internal consistency (for example ADR guidance) lowers ambiguity for contributors and readers.
- Better reference traceability increases credibility and makes updates easier when source guidance changes.
