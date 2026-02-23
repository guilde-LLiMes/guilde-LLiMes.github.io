---
name: validation-protocol
description: Create DEBUG.md as an operational debugging contract by validating and recording proven runtime workflows for every repository runtime.
---

# Runtime Validation Protocol

## Objective

Create `/DEBUG.md` as the operational debugging contract for this repository by validating and recording proven runtime workflows.

## Execution Mode

Default: one-shot bootstrap. Build a usable baseline `DEBUG.md` in a single run.
Optional: targeted refresh. Re-verify only runtimes affected by code or configuration changes.

## Deliverables

Required:
- `/DEBUG.md` with verified procedures only
- A runtime coverage index in `DEBUG.md`
- A link to `DEBUG.md` from `AGENTS.md` or `CLAUDE.md` when those files exist

Optional:
- `/debug/*.sh`, `/debug/*.js`, `/debug/*.py` helper tools that you executed successfully
- `/debug/*.md` deep-dive notes for complicated setups

## Operating Invariants

1. Evidence outranks assumptions.
2. Never treat source inspection as verification.
3. Cover every runtime, including injected and child runtimes.
4. Treat hot reload as advisory, not authoritative.
5. Automate state setup when possible.
6. Keep debug surfaces local, development-only, and removable.
7. Do not leak secrets in logs, requests, or test artifacts.

## Required Coverage Per Runtime

Must verify:
- `OBSERVE`
- `CONTROL`
- `ROLLOUT`
- `TEST`

Best-effort (conditional):
- `INJECT`
- `EGRESS`
- `STATE`

When a best-effort capability is not achievable in this run, record it as `BLOCKED` with failure evidence and next action.

## Runtime Inventory Contract

Treat each runtime as an independent verification target and describe it with a consistent shape.

Required fields per runtime:
- `id`: unique runtime identifier
- `class`: backend, frontend, worker, extension-host, content-script, mobile, job-runner, or equivalent
- `entry`: startup entry path
- `owner`: parent runtime or `root`
- `observe`: where runtime signals appear
- `control`: start/stop/restart commands
- `inject`: live execution mechanism or explicit gap
- `rollout`: rebuild + restart/reload commands
- `test`: test command(s) and current status

Map runtime relationships, for example:
- Process A spawns Process B
- Extension host injects content script
- Backend exposes websocket used by frontend tools

## Capability Matrix

Document these capabilities for each runtime:
- `OBSERVE` (required): produce and locate runtime output
- `CONTROL` (required): start, stop, restart with health confirmation
- `ROLLOUT` (required): rebuild + restart/reload and verify code is active
- `TEST` (required): execute automated checks or document absence/failure
- `INJECT` (best-effort): run live code without full rebuild
- `EGRESS` (best-effort, conditional): export debug data from sandboxed contexts
- `STATE` (best-effort): drive runtime into a target state programmatically

## Validation Stages

### Stage 0: Topology Mapping

Identify all runtimes before validating any runtime.

Suggested discovery targets:
- `package.json`, lockfiles, monorepo configs
- `requirements.txt`, `pyproject.toml`
- `go.mod`, `Cargo.toml`
- Docker compose files, Procfiles, task runners
- extension manifests and worker entrypoints
- active process and port surfaces when available

Output:
- A complete runtime inventory draft (not yet in `DEBUG.md` as verified)

### Stage 1: Observation Channel

Establish where output is visible before asserting lifecycle success.

Procedure:
1. Add a temporary marker log in runtime code
2. Trigger the path
3. Capture the exact output channel and marker signal
4. Remove marker

### Stage 2: Lifecycle Control

Prove start/stop/restart using the observation channel from Stage 1.

Minimum proof:
1. Start command executes
2. Health signal appears (port, process, log heartbeat, or endpoint)
3. Stop action succeeds
4. Restart succeeds and health returns

If a step fails, run failure handling and do not record success text.

### Stage 3: Live Execution Channel (Critical)

Establish an interactive execution route for runtime probing.

Target result:
- Execute expression/code without full rebuild
- Receive response
- Access meaningful runtime state

Selection order:
1. Native REPL or built-in console
2. Debugger console attached to runtime
3. Development-only local bridge endpoint (HTTP or IPC)

If no mechanism exists, mark `INJECT` as `BLOCKED` with exact failure evidence and a practical next action. Implement a local development-only bridge only when low-risk and feasible in this one-shot run.

### Stage 4: Deterministic Rollout

Validate code promotion with a hard confirmation loop:
1. Change code (small marker)
2. Rebuild
3. Restart or reload using known mechanism
4. Confirm marker is active

Do not treat hot reload alone as proof. Require marker confirmation after explicit rollout actions.

### Stage 5: Debug Egress (Conditional)

For sandboxed runtimes (content scripts, workers, isolated contexts), prove data can be exported.

Procedure:
1. Start receiver
2. Emit payload from sandboxed code
3. Confirm receipt
4. Record constraints (CORS/CSP/permissions) and working workaround

### Stage 6: State Driving

Create and run programmatic state transitions.

Examples:
- API seed/setup calls
- DB fixture script
- browser automation route
- deep-link bootstrapping

Must include clear "state reached" signal.

### Stage 7: Test Execution

Prove test entrypoints for each runtime area.

Required:
- Run known test command(s)
- Record pass/fail behavior
- If tests are absent or broken, document current limitation and nearest viable check

## Evidence Rule

No claim in `DEBUG.md` without:
- Action: exact command or snippet
- Signal: actual observed output, response, or state marker
- Constraints: prerequisites, caveats, limits, or environment assumptions

Use this pattern:

```markdown
### Runtime `<runtime-id>` / `<capability>` / VERIFIED

- Action: `<exact command or snippet>`
- Signal: `<output, response, or state marker>`
- Constraints: <prerequisites, caveats, limits>
```

For blocked capabilities, use:

```markdown
### Runtime `<runtime-id>` / `<capability>` / BLOCKED

- Attempted: `<exact command or snippet>`
- Failure: `<error or behavior>`
- Next action: <most viable follow-up>
```

## Failure Handling Protocol

When a stage fails:
1. Record exact command and output
2. Classify failure: environment, configuration, code, or permission
3. Apply focused fix
4. Re-run the full stage from the beginning
5. If unresolved, record as `BLOCKED` with reproduction steps

## Optional Refresh Triggers

Re-run this protocol only when one of these triggers occurs:
1. A new runtime is introduced
2. Startup/build/test/reload commands change
3. A previously verified command in `DEBUG.md` stops working

## Out Of Scope

Do not expand this protocol into:
- production incident response tooling
- deep performance profiling programs
- full security audit programs
- CI/CD architecture redesign

## Completion Contract

The protocol is complete when `DEBUG.md` contains:
1. Every discovered runtime is listed
2. Verified `OBSERVE`, `CONTROL`, `ROLLOUT`, and `TEST` capabilities per runtime
3. `INJECT`, `EGRESS`, and `STATE` recorded as `VERIFIED` or `BLOCKED` with reason
4. Evidence record attached to every capability claim
5. Blocked items include reproducible steps and next action
6. Known limitations are explicit and reproducible

## Optional Refresh Procedure

When one or more refresh triggers occur:
- Re-run only affected runtime sections
- Update stale commands immediately
- Keep unaffected runtime evidence unchanged

`DEBUG.md` is an operations artifact, not a theory document.
Keep it executable, current, and evidence-backed.
