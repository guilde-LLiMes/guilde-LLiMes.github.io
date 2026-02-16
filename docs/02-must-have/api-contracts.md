---
layout: default
title: API Contracts
nav_order: 6
parent: Must-Have
---

# API Contracts

## Why This Matters

APIs are promises. External consumers, frontend clients, and other services depend on your endpoints behaving exactly as documented. When an LLM modifies an API — renaming a field, changing a response shape, removing a parameter — it can break every consumer silently.

The model doesn't know which parts of your API are public contracts and which are internal implementation. It doesn't know your versioning strategy. Without this guideline, it will change API surfaces as freely as it changes internal code.

## What to Include

- **Schema definition format** — OpenAPI, JSON Schema, Protobuf, or informal conventions
- **Versioning strategy** — URL-based (/v1/), header-based, no versioning
- **Breaking vs non-breaking changes** — what counts as each
- **Backward compatibility rules** — how to evolve without breaking consumers
- **Where contracts live** — file locations for schemas, types, or documentation

## How to Write It

1. **State your schema format.** If you use OpenAPI, say where the spec lives. If you use informal conventions, define the response shape.
2. **Define "breaking change."** The model needs a clear line between changes that are safe and changes that need a new version.
3. **Write the evolution rules.** Can you add fields? Can you deprecate fields? How long do deprecated fields live?
4. **State the process.** Must the model update the schema first? Or implement first and update the schema after?

## Example

```markdown
## API Contracts

Format: OpenAPI 3.1 spec in docs/openapi.yaml
Types generated from spec: src/generated/api-types.ts (don't edit manually)

Versioning: URL path (/api/v1/, /api/v2/)
Current version: v1

Breaking changes (require new version):
- Removing a field from a response
- Renaming a field
- Changing a field's type
- Removing an endpoint
- Making an optional field required

Non-breaking changes (same version):
- Adding a new optional field to a response
- Adding a new endpoint
- Adding a new optional query parameter
- Loosening validation (required → optional)

Rules:
- Update openapi.yaml BEFORE implementing changes
- Never edit generated types — regenerate from spec
- Deprecated fields keep working for 2 major versions
- All endpoints return { data, error, meta } envelope
```

## Common Mistakes

**No definition of "breaking."** If the model doesn't know what counts as a breaking change, it'll rename fields and remove parameters without hesitation.

**Treating internal and external APIs the same.** Internal APIs between your own services may have different rules than public-facing APIs. If so, distinguish them.

**Forgetting generated code.** If types or clients are generated from a schema, the model needs to know not to edit them directly. It should edit the schema and regenerate.

**Over-documenting endpoint details.** Your guidelines don't need to list every endpoint. They need to describe the rules for creating and modifying endpoints. The OpenAPI spec itself handles the details.

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md. If Claude Code can run your code generator (`npm run generate-types`), include that command.
- **Cursor**: Consider glob-scoping API rules to `src/routes/**` or `src/api/**` so they only load when relevant.
- **Copilot**: Include breaking change definitions — Copilot suggests inline changes and needs to know what's safe.
- **AGENTS.md**: Include in root file. Agents that make changes across files need clear API boundary rules.

## References

- [External References](../references.md)
