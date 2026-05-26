---
name: validation-protocol
description: Create a concise DEBUG.md daily debugging guide for verified application runtimes, with optional ignored DEBUG.audit.md evidence.
---

# Runtime Validation Protocol

## Objective

Create `/DEBUG.md` as the daily debugging guide for this repository's verified
application runtimes. Optimize for future agent use: short commands, expected
signals, safe state setup, and links to canonical deeper docs.

Full validation evidence belongs outside the daily guide, usually in local
`/DEBUG.audit.md`.

## Execution Mode

Default: one-shot bootstrap. Build a usable baseline `DEBUG.md` in a single run.

Optional: targeted refresh. Re-verify only runtimes affected by code,
configuration, or command changes.

## Deliverables

Required:

- `/DEBUG.md`: concise daily runbook for verified application runtimes.
- A link to `DEBUG.md` from `AGENTS.md` or `CLAUDE.md` when those files exist.

Optional:

- `/DEBUG.audit.md`: evidence log, blocked checks, command output summaries, and
  temporary validation notes. Add it to `.gitignore` unless the user asks to
  commit audit evidence.
- `/debug/*.sh`, `/debug/*.js`, `/debug/*.py`: helper tools that were executed
  successfully and are useful beyond this run.

Do not reference `DEBUG.audit.md` from `DEBUG.md` unless the user asks.

## Output Policy

`DEBUG.md` should be a runbook, not an audit report.

Include only:

- Ports and URLs for the scoped application runtimes.
- Quick status commands and expected signals.
- Start/stop/restart commands.
- Backend loop: isolated startup, minimal probes, test commands.
- Frontend loop: startup/probe commands and core test/build commands.
- Browser, worker, or injected-runtime notes only when they are part of the app.
- Safety rules for agents.
- Links to canonical docs for detailed test fixtures, seed endpoints, env
  behavior, or architecture.

Do not include:

- Long evidence blocks.
- Complete test fixture or seed endpoint documentation when another repo doc owns
  it.
- Stale doc-only runtimes.
- Adjacent apps, design tools, wireframes, examples, or playgrounds unless the
  user explicitly scopes them in.
- Optional audit filenames unless requested.

`DEBUG.audit.md` may include:

- Runtime inventory drafts and excluded candidates.
- Exact action/signal/constraint records.
- Blocked capabilities and reproduction steps.
- Temporary marker notes and cleanup proof.
- Doc drift observations.

## Operating Invariants

1. Evidence outranks assumptions.
2. Reading code is discovery, not verification.
3. Actual files, configs, and processes outrank stale documentation.
4. Scope runtimes tightly to the application requested by the user.
5. Do not disrupt running services casually.
6. Track every process you start and stop it before finishing.
7. Use isolated data roots for destructive or stateful validation.
8. Avoid temporary source markers when possible.
9. If temporary markers are used, remove them immediately and verify with search.
10. Keep debug surfaces local, development-only, and removable.
11. Do not leak secrets in logs, requests, docs, or test artifacts.

## Verification Guardrails

Do not mark a method verified unless you executed it and observed the signal.

Common false verification:

- Reading a logger, server, or test file and assuming it works.
- Seeing a configured port or script and assuming the process starts.
- Assuming hot reload works without changing code and confirming the new signal.
- Documenting a debug receiver without sending and receiving a real payload.

Proof requires:

- Exact command or snippet executed.
- Observed output, response, log, page state, process state, or test result.
- Cleanup proof for any temporary marker, hook, service, or credential.

## Stage 0: Scope And Safety Gate

Run this before topology mapping.

1. Identify the repository root and current dirty state.
2. Read local instructions such as `AGENTS.md` or `CLAUDE.md`.
3. Inspect active ports and relevant processes before lifecycle validation.
4. Identify candidate runtimes from actual entrypoints/configs:
   - `package.json`, lockfiles, Vite/Next configs, frontend entrypoints
   - `requirements.txt`, `pyproject.toml`, ASGI/WSGI entrypoints
   - service managers, task runners, Procfiles
   - extension manifests, worker entrypoints, mobile configs
5. Exclude candidates that exist only in stale docs or absent files.
6. Exclude adjacent workspaces/tooling unless explicitly requested.
7. Announce before starting or stopping long-running services.
8. Choose isolated ports/data roots for validation when feasible.

Record excluded or stale candidates in `DEBUG.audit.md`, not `DEBUG.md`.

## Runtime Inventory Contract

Treat each scoped application runtime as an independent verification target.

Required fields per runtime:

- `id`: unique runtime identifier.
- `class`: backend, frontend, worker, extension-host, content-script, mobile,
  job-runner, or equivalent.
- `entry`: startup entry path.
- `owner`: parent runtime or `root`.
- `observe`: where runtime signals appear.
- `control`: start/stop/restart commands.
- `rollout`: rebuild plus restart/reload commands.
- `test`: test command and current status.

Best-effort fields:

- `inject`: live execution mechanism or explicit gap.
- `egress`: export mechanism for sandboxed runtimes.
- `state`: state setup mechanism.

## Validation Stages

### Stage 1: Observation Channel

Establish where output is visible before asserting lifecycle success.

Preferred proof, in order:

1. Existing health endpoint or command output.
2. Existing startup log line.
3. Browser or runtime console output.
4. Temporary marker only when no lower-risk signal exists.

If a marker is required:

- Make it unique and harmless.
- Keep it local to the shortest possible path.
- Remove it immediately after proof.
- Verify removal with search.

### Stage 2: Lifecycle Control

Prove start/stop/restart only for scoped runtimes.

Minimum proof:

1. Start command executes or existing running service is observed.
2. Health signal appears: port, endpoint, process, log heartbeat, or page load.
3. Stop action succeeds when you started or were asked to stop it.
4. Restart succeeds only when restart validation is needed and non-disruptive.

Do not restart user-running services just to complete the protocol. Record
unverified restart behavior in `DEBUG.audit.md` and keep `DEBUG.md` practical.

### Stage 3: State Driving

Create and run programmatic state transitions when useful.

Examples:

- API seed/setup calls.
- DB fixture script.
- Browser automation route.
- Deep-link bootstrapping.

Use isolated state by default. In `DEBUG.md`, include only the minimal daily
state command and link to canonical fixture docs for details.

### Stage 4: Deterministic Rollout

Validate code promotion with a hard confirmation loop when feasible:

1. Change code or use an existing visible version/build signal.
2. Rebuild.
3. Restart or reload using the known mechanism.
4. Confirm the expected signal is active.

Do not treat hot reload alone as proof. If full rollout would disrupt the user,
record it as not re-verified in `DEBUG.audit.md`.

### Stage 5: Live Execution And Egress

For each scoped runtime, best-effort verify:

- `INJECT`: REPL, debugger console, browser console, or local debug bridge.
- `EGRESS`: export data from sandboxed contexts such as workers or content
  scripts.

Use existing consoles, REPLs, debuggers, or app-local probes first. Add a debug
bridge only when it is low-risk, local-only, gated, removable, and necessary for
the requested validation.

If no safe mechanism exists, record the exact gap and next action in
`DEBUG.audit.md`. In `DEBUG.md`, keep only the daily debugging route.

### Stage 6: Test Execution

Run known test/build commands or document why they were not run.

Record in `DEBUG.md`:

- Core backend test command.
- Core frontend build/test commands.
- Current known failures only when actionable for daily work.
- Links to deeper test docs.

Record in `DEBUG.audit.md`:

- Exact pass/fail evidence.
- Interrupted commands.
- Long failure details.

## Evidence Pattern For `DEBUG.audit.md`

Use this pattern for verified capabilities:

```markdown
### Runtime `<runtime-id>` / `<capability>` / VERIFIED

- Action: `<exact command or snippet>`
- Signal: `<output, response, or state marker>`
- Constraints: <prerequisites, caveats, limits>
```

Use this pattern for blocked capabilities:

```markdown
### Runtime `<runtime-id>` / `<capability>` / BLOCKED

- Attempted: `<exact command or snippet>`
- Failure: `<error or behavior>`
- Next action: <most viable follow-up>
```

## `DEBUG.md` Shape

Use this compact structure unless the repository demands otherwise:

```markdown
# <Project> Debugging Guide

Use this as the daily agent runbook for `<scoped runtimes>`.

## Ports

| Service | Port | URL |
|---|---:|---|

## Quick Status

## Service Control

## Backend Loop

## Frontend Loop

## Browser / Worker Notes

## Safety Rules
```

Prefer links over duplication. For example, link to:

- `AGENTS.md` for service management and project-level commands.
- `backend/tests/AGENTS.md` for backend test architecture.
- `frontend/tests/AGENTS.md` for E2E ports, fixtures, and seed endpoints.
- Environment docs for variable semantics.

## Failure Handling Protocol

When a stage fails:

1. Record exact command and output in `DEBUG.audit.md`.
2. Classify failure: environment, configuration, code, permission, or stale docs.
3. Apply a focused fix only if it is necessary to complete validation and within
   the user's requested scope.
4. Re-run the failed stage from the beginning.
5. If unresolved, record a blocked item with reproduction steps.

## Optional Refresh Triggers

Refresh only affected sections when:

1. A scoped runtime is introduced or removed.
2. Startup/build/test/reload commands change.
3. A verified command in `DEBUG.md` stops working.
4. Canonical test or environment docs move.

## Validation Scenarios

Before finishing, check the result against these scenarios:

- Stale Docker docs but no Docker files: flag drift in audit, do not add Docker
  to `DEBUG.md`.
- Adjacent tooling or design workspace exists: exclude it unless the user scoped
  it in.
- Services are already running: observe first and do not casually restart them.
- Audit evidence exists: `DEBUG.audit.md` is ignored and not linked from the
  daily guide unless requested.
- `DEBUG.md` remains short, operational, and suitable for daily agent use.

## Completion Contract

The protocol is complete when:

1. Scoped application runtimes are listed in `DEBUG.md`.
2. `DEBUG.md` contains executable daily commands and expected signals.
3. Detailed evidence is moved to `DEBUG.audit.md` when useful.
4. `DEBUG.audit.md` is ignored unless the user asks to commit it.
5. `AGENTS.md` or `CLAUDE.md` links to `DEBUG.md` when present.
6. Temporary markers and debug endpoints are removed.
7. Processes started by validation are stopped or explicitly handed off.
8. Known limitations are explicit and reproducible.
