---
layout: default
title: Security Basics
nav_order: 7
parent: Must-Have
---

# Security Basics

## Why This Matters

LLMs optimize for functionality. If adding a `console.log(user)` helps debug a problem, the model will add it — even if `user` contains an auth token, email address, or password hash. If hardcoding an API key makes the code work, the model will hardcode it.

The model isn't malicious. It's indifferent to security unless you make security rules explicit. One missed guideline can result in secrets in version control, PII in log files, or authentication checks that only exist in some routes.

## What to Include

- **Authentication model** — how users authenticate (JWT, session, OAuth, API key)
- **Authorization pattern** — where and how permissions are checked
- **Secrets handling** — how secrets are stored, accessed, and what must never be hardcoded
- **Sensitive data rules** — what counts as PII/sensitive, what can and can't be logged
- **Compliance constraints** — any domain-specific rules that must never be violated

## How to Write It

1. **Describe the auth flow in 3-4 lines.** The model needs to know if auth is middleware-based, decorator-based, or checked inside each handler.
2. **List what's secret.** API keys, tokens, connection strings, credentials — enumerate the categories.
3. **Define logging boundaries.** What can appear in logs, what can't, and where the boundary is.
4. **State compliance rules as hard constraints.** "Patient data must never leave the VPC" is clearer than "follow HIPAA."

## Example

```markdown
## Security

Auth: JWT bearer tokens in Authorization header
- Validated by authMiddleware (src/middleware/auth.ts)
- Apply to all routes except /health and /auth/login
- Token contains: userId, role, teamId (no PII)

Authorization:
- Role-based: admin, member, viewer
- Check with requireRole() middleware on route level
- Never check permissions inside service layer

Secrets:
- All secrets in environment variables
- Access via src/config/env.ts (validated at startup)
- Never hardcode API keys, tokens, or connection strings
- Never commit .env files (gitignored)

Logging:
- NEVER log: passwords, tokens, API keys, email addresses, IP addresses
- OK to log: userId, teamId, action performed, status codes, timing
- Use logger.sanitize() for objects that might contain sensitive fields

Constraints:
- All data encrypted in transit (HTTPS only) and at rest (AES-256)
- User data deletion must be complete within 30 days of request
- No third-party analytics or tracking on user data
```

## Common Mistakes

**Assuming the model knows what's sensitive.** It doesn't. "Don't log PII" is too vague — the model may not classify an email address or IP as PII. List specific field names and data types.

**Missing the auth application rule.** Saying "we use JWT" tells the model the mechanism but not where it's enforced. State explicitly: "All routes except X go through auth middleware."

**Not mentioning .env files.** LLMs will sometimes create or modify .env files with real-looking secrets as examples. State that .env files are gitignored and shouldn't be created or modified.

**Security through vagueness.** "Be careful with security" is not actionable. Specific rules like "never log the Authorization header" are.

## Tool-Specific Notes

- **Claude Code**: Critical for CLAUDE.md. Claude Code can read and create files — it needs hard boundaries on secrets and sensitive files.
- **Cursor**: Consider a dedicated security rule with `alwaysApply: true`. Security rules should never be conditional.
- **Copilot**: Include logging boundaries. Copilot's inline suggestions are the most likely to accidentally include sensitive data in log statements.
- **AGENTS.md**: Root-level, always loaded. Agents that operate autonomously need the strongest security boundaries.
