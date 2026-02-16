---
layout: default
title: Error Handling
nav_order: 4
parent: Should-Have
---

# Error Handling

## Why This Matters

Without a standard error pattern, LLMs invent a new approach each time. One function throws a string, the next returns null, the third uses a custom Result type. Error messages lack structure, some errors are silently swallowed, and the calling code doesn't know what to expect.

A defined error handling pattern gives the model a consistent shape to follow across every function, service, and route.

## What to Include

- **Error taxonomy** — categories of errors (validation, auth, not-found, internal)
- **Error shape** — what properties every error must have
- **Propagation rules** — where errors are caught, where they're rethrown, where they're logged
- **What to never do** — swallow errors, throw strings, use generic Error()

## How to Write It

1. **Define 4-6 error categories.** Most apps need: validation, authentication, authorization, not-found, conflict, internal. Map them to HTTP status codes if applicable.
2. **Show the error class.** A 5-line code block is more useful than a paragraph of description.
3. **Draw the catch boundary.** Errors should propagate upward and be caught at a defined boundary (route handler, middleware, top-level handler), not scattered across every function.

## Example

```markdown
## Error Handling

Error class: AppError (src/errors/app-error.ts)
Properties: code (string), message (string), httpStatus (number), context (object, optional)

Categories:
- VALIDATION_ERROR (400) — bad input
- UNAUTHORIZED (401) — not authenticated
- FORBIDDEN (403) — not authorized
- NOT_FOUND (404) — resource doesn't exist
- CONFLICT (409) — duplicate or state conflict
- INTERNAL (500) — unexpected failure

Rules:
- Services throw AppError with appropriate category
- Route handlers don't catch — error middleware catches all
- Error middleware logs and returns standardized response
- Never throw raw strings or generic Error()
- Never silently catch and ignore errors
- Include context: throw new AppError('NOT_FOUND', 'User not found', 404, { userId })
```

## Common Mistakes

**Too many error categories.** 4-6 cover most applications. More than that and the model starts choosing wrong categories.

**No catch boundary.** If you don't say where errors are caught, the model wraps every function in try/catch.

**Missing the "shape" definition.** Saying "use typed errors" without showing the class leads to different interpretations each time.

## Tool-Specific Notes

- **Claude Code**: Include in CLAUDE.md. Point to the actual error class file so Claude can reference it.
- **Cursor**: Can scope to `src/services/**` and `src/routes/**` where error handling matters most.
- **All tools**: Error handling is one of the most impactful should-haves. Models default to inconsistent patterns without guidance.
