---
layout: default
title: Security Playbook
nav_order: 5
parent: Nice-to-Have
---

# Security Playbook

## Why This Matters

[Security Basics](../02-must-have/security-basics.md) covers the day-to-day rules: don't log secrets, use auth middleware, encrypt data. A security playbook covers what happens when something goes wrong — or when the stakes are high enough that normal coding rules aren't sufficient.

This is most relevant for teams handling sensitive data, operating in regulated industries, or building systems where a security mistake has outsized consequences.

## What to Include

- **Incident response steps** — what to do when a security issue is discovered
- **Data classification** — what data is sensitive, what's public, what's internal
- **When to escalate** — situations where a human must be involved
- **Compliance-specific constraints** — HIPAA, SOC 2, GDPR, PCI-DSS

## Example

```markdown
## Security Playbook

Data classification:
- Public: product descriptions, pricing, company info
- Internal: user IDs, team names, project metadata
- Sensitive: emails, passwords (hashed), payment tokens, health records
- Restricted: raw payment data, SSNs, encryption keys

Sensitive data rules:
- Sensitive fields encrypted at rest (AES-256)
- Sensitive fields masked in all logs (show last 4 chars max)
- Restricted data never stored in application DB — use dedicated vault

Escalation triggers:
- Any suspected data leak → notify security team immediately
- Authentication bypass discovered → halt feature, notify team lead
- PII exposed in logs → rotate credentials, purge logs, notify compliance

Compliance (SOC 2):
- Audit trail for all data access (who, what, when)
- User data deletion within 30 days of request
- Annual access review for all service accounts
- No production data in development or staging environments
```

## Common Mistakes

**Conflating security basics with the playbook.** Basics are preventive (daily rules). The playbook is reactive (incident response) and risk-classification. Keep them separate.

**No data classification.** Without classification, the model treats all data the same. Some data is fine to log; some must never leave the database unencrypted.

**Compliance rules without actionable specifics.** "Follow HIPAA" is not actionable. "Patient data must be encrypted with AES-256, never logged, never stored outside the primary database" is.

## Tool-Specific Notes

- **Claude Code**: Reference in CLAUDE.md for projects with compliance requirements. The model should know the data classification and escalation triggers.
- **All tools**: This guideline is most impactful in regulated domains. Startups building a todo app don't need a security playbook.
