# Constitution

> This document defines the immutable principles governing the **{{PROJECT_NAME}}** project.
> It is the supreme authority for all development decisions. Every spec, plan, task, and
> implementation must comply with these principles. Deviations require explicit documentation,
> justification, and an amendment to this constitution before implementation — never after.

---

## Article I — Mission & Product Identity

<!-- PROJECT: Replace with your project's content. -->

### 1.1 Purpose

[Describe what this project builds and why it exists. One paragraph that captures the core value proposition.]

### 1.2 What This Project Is

[Bulleted list of what the project IS. Focus on boundaries that prevent scope creep. Example entries:]

- A **[primary function]**, not [common misconception]
- A **[deployment model]** application
- A **[decision philosophy]** — [what it does vs. what it delegates to humans]

### 1.3 What This Project Is Not

[Bulleted list of explicit exclusions. These are permanent — not "not yet" but "not ever." Example entries:]

- Not [adjacent category that users might assume]
- Not [technology trend you are deliberately avoiding]

### 1.4 Design Philosophy

**Simplicity over sophistication.** If a user-facing feature cannot be explained in one
sentence, it is too complex. Internal operational safeguards (recovery, observability,
deployment safety) that make the user experience simpler and more reliable are acceptable
infrastructure complexity.

**Data integrity over speed.** A correct result delivered slowly is infinitely more valuable
than an incorrect one delivered quickly.

**Durability over novelty.** Prefer battle-tested libraries, stable APIs, and proven patterns.
This system should run reliably for years with minimal maintenance.

[Add any project-specific design principles below.]

---

## Article II — Architecture Principles

<!-- PROJECT: Replace with your project's content. -->

### 2.1 System Boundaries

[Define the layers of your system. Each layer should have a single responsibility. No layer may be added without a constitutional amendment.]

Example structure:
1. **[Layer name]** — [Single-sentence responsibility]
2. **[Layer name]** — [Single-sentence responsibility]
3. **[Layer name]** — [Single-sentence responsibility]

### 2.2 Separation of Concerns

- Each layer communicates through well-defined interfaces (typed contracts)
- No layer may directly access the internals of another layer
- The presentation layer never contains business logic
- Database queries are confined to the storage layer; no raw SQL in business logic

[Add project-specific separation rules.]

### 2.3 Data Flow

[Describe how data moves through your system. If your system fetches external data, define whether analysis/processing happens on live data or stored data. This decision has major implications for testability and reliability.]

### 2.4 Configuration Over Code

[Define which values are configurable and how. Recommended classification:]

- **Secrets** (API keys, credentials, auth secrets) — environment variables only (see Article VII)
- **Infrastructure tuning** (timeouts, retry counts, intervals, port numbers) — environment variables with sensible defaults in code
- **Business rules** (thresholds, schedules, feature flags) — configuration files or database records

### 2.5 Repository Structure

[Single repo or monorepo? Microservices or monolith? Define and justify.]

### 2.6 Architectural Patterns

[Define mandatory patterns. Each should enforce one or more constitutional principles. Example patterns:]

**Repository pattern** — All database access is encapsulated in typed query functions
within a dedicated module. No other layer imports the ORM directly or constructs queries.

**Service layer** — Business logic exposes typed function signatures as its public interface.
Consumers depend on these signatures, never on internal implementation details.

**Adapter pattern for external APIs** — Each external provider is accessed through a typed
interface. Concrete implementations (real API client, mock client) are swappable without
changing consuming code.

[Add or remove patterns as appropriate for your architecture.]

---

## Article III — Technology Constraints

<!-- PROJECT: Replace with your project's content. -->

### 3.1 Permitted Stack

Changes to this stack require a constitutional amendment with documented justification.

| Layer | Technology | Rationale |
|-------|-----------|-----------|
| Language | [Your language] | [Why] |
| Runtime | [Your runtime] | [Why] |
| Web Framework | [Your framework] | [Why] |
| Database | [Your database] | [Why] |
| ORM / Query Builder | [Your ORM] | [Why] |
| Testing | [Your test framework] | [Why] |
| Package Manager | [Your package manager] | [Why] |

[Add rows as needed.]

### 3.2 Forbidden Technologies

These are explicitly prohibited. Do not suggest, evaluate, or introduce them.

[List technologies that are out of scope permanently, with brief rationale. Example:]

- **No [category]** ([specific tools]) — [why they are inappropriate for this project]

### 3.3 External API Policy

- All API keys stored in environment variables, never in code or committed configuration files
- Every external API call must have: retry logic with exponential backoff, rate limit awareness, timeout handling, and error logging
- A mock/stub layer must exist for every external API to enable offline development and testing
- New API integrations require a spec documenting: endpoints used, rate limits, cost, data schema, and fallback behavior

### 3.4 Scheduling & Background Jobs

[If your project has scheduled or background work, define the separation between schedule triggers and job execution. If not applicable, remove this section.]

---

## Article IV — Code Quality Standards

### 4.1 Language Discipline

<!-- PROJECT: Replace with your project's content. Language-specific rules go here. -->

[Define your language-specific strictness rules. Examples for typed languages:]

- Strict mode enabled — no exceptions
- No escape hatches (e.g., `any` in TypeScript, `unsafe` in Rust without justification)
- All function signatures must have explicit types
- All external input must be validated at runtime

### 4.2 File and Module Organization

<!-- PROJECT: Replace with your project's content. -->

[Define your directory structure and file naming conventions.]

- One exported concept per file. No god files.
- [Your file naming convention, e.g., kebab-case, snake_case, PascalCase for components]
- Test files mirror the source structure
- No circular imports. If detected, refactor immediately.

### 4.3 Naming Conventions

<!-- PROJECT: Replace with your project's content. -->

[Define naming conventions for files, functions, constants, database entities, API routes, and environment variables.]

### 4.4 Error Handling

<!-- FRAMEWORK: Use as-is. Override only with constitutional amendment. -->

- All errors must be typed. Define custom error classes extending a base error type.
- External failures must never crash the application
- All data-mutating operations must use transactions with appropriate boundaries
- Never swallow errors silently. At minimum, log them with context.

### 4.5 Comments and Documentation

<!-- FRAMEWORK: Use as-is. Override only with constitutional amendment. -->

- Code should be self-documenting through clear naming. Comments explain *why*, never *what*
- Every public function must have a doc comment describing purpose, parameters, and return value
- No TODO comments in main branch. Use issue tracking instead.
- Every public function, API route handler, and page/view must include a `@spec` tag referencing the functional requirement(s) it implements (e.g., `@spec 002-FR-003`). Pure utility functions with no governing FR are exempt.

---

## Article V — Testing Standards

<!-- FRAMEWORK: Use as-is. Override only with constitutional amendment. -->

### 5.1 Coverage Requirements

- All core business logic functions must have unit tests
- All functions that interact with external services must have tests using mock responses
- All database queries must have integration tests against a test database
- All API routes must have integration tests
- UI components do not require unit tests unless they contain conditional rendering logic

### 5.2 Test Quality Rules

- Tests must be deterministic. No reliance on wall-clock time, network, or random values.
- Domain-specific calculation tests must use known reference values to verify correctness
- Every bug fix must include a regression test before the fix is applied
- Test names must describe the behavior being verified, not the implementation (e.g., `should reject input when threshold exceeds maximum` rather than `test validateThreshold`)
- Test `describe` blocks that verify a specific functional requirement must include the FR identifier in the description. Format: `describe("FR-XXX: <behavior>", ...)`. This enables forward traceability from spec requirements to test coverage. Tests that cover cross-cutting concerns or infrastructure (not tied to a single FR) are exempt.

### 5.3 Test Execution

- All tests must pass before any merge to main (enforced by CI pipeline)
- All tests (unit + integration + E2E) must pass before any push (enforced via pre-push hook)
- Unit/integration tests should complete in under 60 seconds
- E2E tests should complete in under 120 seconds
- CI pipeline runs lint, type checking, and tests on every pull request; no merge without green checks

### 5.4 Tests as Deliverables

Automated tests are a deliverable of implementation, not a separate phase. A task that
produces testable code is not complete until its corresponding tests exist and pass.

- Every database query function must ship with an integration test in the same commit
- Every API route must ship with an integration test in the same commit
- Every business logic function must ship with a unit test in the same commit. External API adapters must be tested using mock implementations of the adapter interface.
- E2E tests verifying a user story's acceptance scenarios must be written as part of that user story's implementation. A user story is not complete until its acceptance scenarios are covered by automated E2E tests that pass.
- When a user story does not produce a user-facing surface (no HTTP endpoint, no UI interaction, no observable system behavior), E2E tests may be omitted for that story. This decision must be documented in the task file with a brief justification. Integration or unit tests remain mandatory for all testable code regardless.

The task generation process must include explicit test tasks for every user story that
produces testable code. Tests are never optional.

---

## Article VI — Domain Integrity Rules

<!-- PROJECT: Replace with your project's content. -->

### 6.1 Data Accuracy

[Define the non-negotiable rules for your domain's data. What types of errors are unacceptable? What precision is required? Example considerations:]

- Numeric precision requirements (fixed-point vs. floating-point, decimal places)
- Required metadata fields for auditability (timestamps, source attribution)
- Guards against common calculation errors (division by zero, overflow)

### 6.2 Data Freshness & Staleness

[If your system ingests external data, define staleness thresholds and how stale data is surfaced to users. If not applicable, remove this section.]

### 6.3 Source Attribution

[If your system displays derived or calculated values, define how users can trace back to source data and understand the calculation. If not applicable, remove this section.]

### 6.4 Validation Strategy

[Define how data quality is enforced. Recommended strategies:]

- **Range guards** — configurable plausible bounds for domain values
- **Delta checks** — flag values that change more than a threshold between consecutive periods
- **Cross-source validation** — compare values from multiple providers when available
- **Completeness checks** — required fields enforced by schema validation; missing data surfaced, never silently filled

---

## Article VII — Security & Privacy

### 7.1 Authentication

<!-- PROJECT: Replace with your project's content. -->

[Define your authentication model. Consider:]

- When is authentication required? (Day one? Only in production?)
- What authentication methods are supported?
- Are there any routes exempt from authentication? (e.g., health checks)

### 7.2 Secrets Management

<!-- FRAMEWORK: Use as-is. Override only with constitutional amendment. -->

- API keys, database credentials, and auth secrets in environment variables only
- Secret files (e.g., `.env`) must be in `.gitignore`. CI must verify they are not committed.
- A secrets example file with placeholder values must be maintained for onboarding

### 7.3 Data Privacy

<!-- FRAMEWORK: Use as-is. Override only with constitutional amendment. -->

- No telemetry, analytics, or external tracking of any kind
- No data leaves the system except as explicit API requests to configured providers
- Server logs must not contain secrets or full data payloads

---

## Article VIII — Evolution & Maintenance

<!-- FRAMEWORK: Use as-is. Override only with constitutional amendment. -->

### 8.1 Incremental Development

This project is built in phases. Each phase must be fully functional and tested before the
next phase begins — where "fully functional" means all requirements applicable to that phase
(accounting for phase qualifiers in individual sections) are implemented and tested. Partially
implemented features must never exist in the main branch.

**Phase transition gate** — Before starting a new phase, the traceability script must report
zero uncovered FRs across all in-scope specs (everything in `specs/`). Every FR in a spec
must be either runtime-traced, config-assertion-traced, or manually verified. FRs that cannot
be delivered in the current phase must be moved to `backlog/` before the phase is considered
complete — not deferred in place within a spec.

**Backlog** — The `backlog/` directory holds requirements that are known but not yet designed
or scoped to a phase. Backlog items are lighter than specs — they contain requirements and
origin, but no design artifacts or tasks. Items in `backlog/` are not enforced by the
traceability script (they are reported for visibility only). When a backlog item is pulled
into scope during a phase-start review, it graduates to a proper spec in `specs/` with full
design artifacts and tasks.

**Phase-start backlog review** — At the start of each phase, all items in `backlog/` must be
reviewed against current knowledge. For each item, decide: graduate to a spec and pull into
this phase's scope, split (graduate deliverable FRs into a new spec and leave the rest in
backlog), or defer for future review. If an item has been reviewed and deferred at 2 or more
consecutive phase boundaries, it requires written justification to defer again (a
`## Deferral Justification` section with the phase number and rationale). This prevents
silent accumulation of perpetually-deferred work.

**Planned phases:**

<!-- PROJECT: Replace with your project's phases. -->

1. **[Phase name]** — [Scope summary]
2. **[Phase name]** — [Scope summary]
3. **[Phase name]** — [Scope summary]

### 8.2 Spec-Driven Workflow

Every feature follows this workflow without exception:

1. **Spec** — Define what the feature does and why (behavior, not implementation)
2. **Plan** — Define how it will be built (architecture, contracts, dependencies)
3. **Tasks** — Break the plan into ordered, testable units of work
4. **Implement** — Build each task with its automated tests, verify both pass, commit together
5. **Validate** — Run full test suite, verify against spec acceptance criteria

Specs, plans, and task files are living documents. When implementation reveals a needed
change, update the spec first, then the code. Task completion must be tracked: when a task
is implemented and its tests pass, the task must be marked complete (`[x]`) in tasks.md in
the same commit as the implementation. A task file that does not reflect the current
implementation state is a process violation.

**Pre-edit gate** — Before modifying any source file, the following questions must be
answered:

1. **What spec governs this area?** Identify the spec in `specs/` whose scope covers the
   file being changed. If no spec exists and the change is not a lightweight exception
   (below), one must be created.
2. **Does the spec reflect the intended change?** If the spec does not describe the behavior
   being implemented, update the spec first. Code must not advance beyond what the spec
   describes.
3. **Does tasks.md have a task for this work?** If no task exists, add one before
   implementing. Untasked work cannot be tracked or verified.
4. **Only then: implement.** Write code and tests, mark the task `[x]` in the same commit.

**Lightweight change exception** — Changes that only modify configuration values (environment
variables, config file values, or code-embedded defaults), fix bugs without altering
specified behavior (the spec already describes the correct behavior; the code was simply
wrong), or update dependencies do not require a full spec-plan-task cycle. A conventional
commit message, a regression test (for bug fixes per Article V), and an updated spec
acceptance status (if affected) are sufficient. If the bug reveals a gap in the spec itself
(spec describes wrong behavior), the spec must be updated first — this is a spec amendment,
not a lightweight change. A branch that accumulates more than 5 lightweight changes should be
split into separate PRs. Lightweight changes must not be bundled with spec-governed changes
(features, refactors) on the same branch.

### 8.3 Git Discipline

- `main` branch is always deployable
- All work happens on feature branches
- Feature-branch commits are atomic and descriptive, following Conventional Commits: `feat`, `fix`, `refactor`, `test`, `docs`, `chore`
- No force-pushes to main
- Squash-merge feature branches to keep main history clean. The squash commit message is
  derived from the **PR description**. The PR description MUST follow conventional commit
  format: the PR title is the commit title, and the PR body becomes the commit body.
- If a branch contains multiple independently releasable changes, the preferred approach is
  to split into separate PRs before merge.
- **PR description must be updated on every push.** The PR description is the single source
  of truth for the squash commit message and must accurately reflect the current state of the
  branch at all times. A PR description that does not reflect the branch contents is a process
  violation.
- Commit messages for `feat` and `fix` types must describe the change from the user's
  perspective, as these are extracted into user-facing release notes.
- A pre-push hook must enforce that all tests pass before code leaves the local machine.
- **Post-merge branch hygiene** — After a squash merge, the source branch must not be reused
  for further work. Squash merges sever commit linkage: git cannot recognize that the squash
  commit on main is the same work as the original branch commits. Continuing to build on the
  old branch causes phantom merge conflicts when main is later integrated. Instead, create a
  new branch from main for any continuation work. Similarly, never branch from another
  developer's unmerged branch — wait for their PR to merge, then branch from main.

### 8.4 Dependency Management

- New dependencies require justification: what problem does it solve that cannot be solved with existing tools or a small utility function?
- Prefer zero-dependency or low-dependency libraries
- Pin exact versions for direct dependencies (no version ranges). Transitive dependency versions are managed by the lockfile.
- Run dependency audits regularly; address critical vulnerabilities within 7 days

**Schema-managing dependencies** — Dependencies that manage their own database schema are
exempt from the boot-migration prohibition (Article IX) for their internal tables. Major
version upgrades of such dependencies must be tested against a database backup before
production deployment and documented in the deployment runbook with rollback steps.

### 8.5 Technical Debt

- Technical debt is tracked in the issue tracker with a dedicated label
- Debt is reviewed and prioritized at the start of each new phase
- No new feature work begins if critical tech debt exists from the prior phase. "Critical"
  means: the debt violates a constitutional mandate applicable to the current phase or blocks
  implementation of the next phase's features. Non-critical debt should be addressed but does
  not block phase transitions.

### 8.6 Quality Gates

**Governing principle** — Process adherence takes priority over implementation velocity.
A correct process that delivers slowly is preferable to a fast process that delivers
incorrectly, because incorrect deliverables require rework that exceeds the time saved.

**Review methodology** — Reviews that verify cross-artifact consistency (constitution vs
spec, spec vs code, code vs tests) must achieve two consecutive clean passes before the
review is considered complete. A "clean pass" means zero findings at any severity. Pass
counting must be explicit: "Round N: clean. Round M: clean. Consecutive clean count: 2 of
2." Never declare a pass count without listing the specific rounds.

**Review posture** — The goal of every review round is to find what is wrong, not to
confirm what is right. Frame each review as "try to break this" — actively search for
contradictions, missing coverage, stale references, and deferral claims that conflict with
mandates. A review that finds nothing should provoke skepticism, not satisfaction,
especially in early rounds.

**Three-layer review process** — Before any merge to main, the following review layers
execute in order:

1. **Layer 1: Constitution -> Spec** — Verify every plan.md Constitution Check claim matches
   current constitution text, cross-spec references are accurate, and no deferral contradicts
   a mandate applicable to the current phase.
2. **Layer 2: Spec -> Code** — Verify every spec FR/SC is implemented, file paths match
   actual files on disk, API shapes match contracts. Exhaustively enumerate testable surfaces
   and verify each has a test file on disk. For each spec user story, verify every acceptance
   scenario has a corresponding test case.
3. **Layer 3: Pre-commit gate** — Run lint, type checking, unit tests, E2E tests. This layer
   should find nothing new if layers 1 and 2 were thorough. If it does, root-cause which
   earlier layer should have caught the finding before proceeding.

Each layer requires two consecutive clean passes before advancing to the next. If layer 3
finds issues, identify which earlier layer missed them, fix that layer's checks, and re-run
from that layer.

**Context integrity** — Tasks that require full conversation context — cross-artifact
reviews, compliance verification, deferral validation — must not be delegated to agents
that lack that context. Delegation is appropriate for bounded, self-contained queries.

---

## Article IX — Performance & Reliability

### 9.1 Response Time Budgets

<!-- PROJECT: Replace with your project's content. -->

[Define response time budgets for your application's key operations. Example:]

- Page loads: < 2 seconds on first load, < 500ms on navigation
- [Primary operation]: < [budget] for [scale]
- Background processing: best-effort, respecting external rate limits

### 9.2 Availability

<!-- PROJECT: Replace with your project's content. Operational patterns below are optional guidance. -->

- The system must gracefully degrade when external dependencies are unavailable
- Cached/stored data must always be accessible regardless of network state
- Database migrations must be backward-compatible. Breaking schema changes must follow the expand-contract pattern (see Non-Disruptive Upgrades). Migration scripts must be idempotent and must never run on application boot.

### 9.3 Observability

<!-- PROJECT: Replace with your project's content. -->

- Structured logging for all significant operations and errors
- A health check endpoint for monitoring
- [Define what operational status is visible in the UI, if applicable]

### 9.4 Data Protection & Backup

<!-- PROJECT: Optional section. Include if your project stores valuable data. -->

[If your project stores data that is costly to recreate, define backup requirements:]

- Backup schedule (configurable, with a sensible default)
- Backup storage location (separate from application host)
- Backup integrity verification (documented restore procedure)
- Backup status visibility (last success, last failure, age)
- Restore procedure that accounts for schema migrations applied after the backup
- Backups must not contain secrets beyond what is already in environment variables

### 9.5 Restart Resilience

<!-- PROJECT: Optional section. Include if your project is self-hosted. -->

[If your project runs on infrastructure that may restart unexpectedly, define resilience requirements:]

- Automatic restart policy (no manual intervention after host reboot)
- Data persistence across container/process restarts
- Explicit separation between "restart" and "destroy data"

### 9.6 Diagnosability

<!-- FRAMEWORK: Use as-is. Override only with constitutional amendment. -->

Every observable system behavior must be traceable back to the governing spec requirement
or identifiable as unsupported. When a user observes unexpected behavior, the diagnosis
path must not require guesswork.

Three mechanisms enforce this traceability:

**Spec-referenced errors** — Application errors should carry a reference identifying the
governing requirement (e.g., `"003-FR-006"`). When an error surfaces in logs or UI, the spec
reference provides the direct path to the requirement that defines the expected behavior.
Errors without a governing requirement indicate a gap in the spec and must be resolved by
updating the spec, not by adding undocumented error handling.

**Code-level traceability** — Every public function, API route handler, and page/view must
carry a `@spec` tag referencing the requirement(s) it implements. This enables direct
navigation from code to governing spec. Functions that implement no specific FR (pure
utilities, helpers) are exempt.

**Test-level traceability** — Test `describe` blocks that verify a specific FR must include
the FR identifier in the description (e.g., `describe("FR-004: CI pipeline runs on every PR", ...)`).
This enables forward traceability from spec to tests and automated coverage reporting.

**Automated traceability validation** — A traceability script must parse all spec FRs and
verify that each is covered by at least one of the following tiers:

1. **Runtime-traced** (fully traced) — FR has both a `@spec` tag in implementation code and
   an FR-tagged test `describe` block. This is the standard tier for FRs implemented by
   application source code.

2. **Config-assertion-traced** (test-only) — FR has an FR-tagged test `describe` block but
   no `@spec` tag, because the FR governs a configuration file, infrastructure artifact, or
   tooling convention rather than runtime code. The test reads the config artifact and asserts
   the required property.

3. **Manually verified** — FR governs a non-automatable quality (documentation correctness,
   operational procedure validity, behavioral properties requiring manual execution). These
   FRs are tracked in the **Manual Verification Register** (see below) and are exempt from
   automated code/test coverage requirements.

Uncovered FRs — those matching none of the three tiers — are reported as gaps. The script
should be runnable locally and optionally in CI.

**Manual Verification Register** — FRs that cannot be verified by automated tests must be
tracked in a verification register document. Each entry must include:
- **FR identifier** and artifact path
- **Verifier** — must not be the same person who last modified the artifact (separation of
  duties). In single-contributor phases, self-verification is permitted but must be annotated.
- **Date** of verification
- **Method** — a specific description of what the verifier did. Generic methods ("reviewed",
  "read it") are insufficient.
- **Expires** — verification date plus the configured expiration period (default: 90 days).
  Verification also expires immediately when the governed artifact is modified.

The register is append-only within a verification cycle. The traceability script must parse
the register and flag expired or missing verifications alongside code/test gaps.

**Spec diagnostic section** — Every feature spec must include a "Diagnosability" section
listing key observable behaviors, the governing requirement, and whether the behavior is
expected.

### 9.7 Non-Disruptive Upgrades

<!-- PROJECT: Optional section. Include if your project is deployed as a long-running service. -->

[If applicable, define upgrade requirements. Recommended subsections:]

**Stateless application** — [Define session strategy and state storage to enable rolling restarts.]

**Graceful shutdown** — On receiving a termination signal, the application must stop accepting
new requests, finish in-flight requests (up to a configurable timeout), and exit cleanly.

**Readiness gating** — The application must not receive traffic until it is ready to serve
requests.

**Migration discipline** — Database migrations must never run automatically on application
boot. Migrations are a separate, explicit step in the deployment process.

**Expand-contract migrations** — Schema changes that would break the running application
must use a two-phase approach:
1. **Expand** — Add the new structure alongside the old. Deploy code that writes to both,
   reads from new with fallback to old. Backfill existing data.
2. **Contract** — After the expanded schema is stable and verified, deploy code that only
   uses the new schema, then remove the old structure.

**Rollback capability** — Every deployment must be reversible. The previous application
version must be retained until the new version is verified stable.

**Release automation** — Changelog and release notes must be generated automatically from
conventional commit messages on `main` using a tool such as release-please. §8.3's
squash-merge policy ensures each merge commit on `main` is a single conventional commit
that release tooling can parse; branches with multiple independently releasable changes
must be split into separate PRs per §8.3 so each squash commit represents one releasable
unit. Manual changelog maintenance is prohibited to prevent drift and human error.

[Define release note tiers if applicable. Common pattern:]

- **Internal** (full commit history): generated automatically, includes all conventional
  commit types for developer reference.
- **External** (user-facing): includes only `feat` and `fix` entries, written from the
  user's perspective per §8.3.

### 9.8 Idempotency & Recovery

<!-- PROJECT: Optional section. Include if your project has background jobs or data mutations. -->

[If applicable, define recovery guarantees. A **recovery guarantee** means that after any
crash, the operation either completed fully or can be retried to completion without manual
intervention, data corruption, or duplicate side effects.]

**Idempotent data mutations** — All data-mutating operations must be safe to retry without
producing duplicates or side effects (e.g., upsert semantics, deduplication guards).

**Transaction boundaries** — Each logical unit of work must be wrapped in a database
transaction. A logical unit is the smallest set of mutations that must succeed or fail
together.

**Idempotent migrations** — Database migration scripts must be re-runnable. Use defensive
DDL (`IF NOT EXISTS` for creates, `IF EXISTS` for drops). A migration that partially applied
due to a crash and is re-run must not fail or corrupt data.

**Non-idempotent side effects** — For operations with external side effects that cannot be
undone (e.g., sending notifications), use a sent-status record as a deduplication guard.

**Crash-consistent recovery** — After any crash, restarting the system and re-running any
interrupted operation must produce a correct final state without manual data cleanup.

---

## Article X — Governance

<!-- FRAMEWORK: Use as-is. Override only with constitutional amendment. -->

### 10.1 Constitution Supremacy

This constitution supersedes all other project documents. If a spec, plan, or task conflicts
with a constitutional principle, the constitution wins and the conflicting document must be
revised. When two constitutional rules conflict, the more specific rule takes precedence. If
specificity is equal, the later amendment takes precedence. Unresolvable conflicts require a
new amendment to clarify.

### 10.2 Amendment Process

Amendments to this constitution require:

1. A written proposal documenting: the current principle, the proposed change, and the rationale
2. An impact analysis: what existing specs, plans, or code would be affected
3. A migration plan if existing code must change
4. The amendment is appended to the changelog below with a date and summary

Amendments must never be made retroactively to justify existing violations.

### 10.3 Principle of Least Surprise

When the constitution is silent on a topic, prefer the choice that would least surprise a
developer reading the code for the first time. When in doubt, choose the simpler option.

---

## Changelog

| Date | Amendment | Rationale |
|------|-----------|-----------|
| {{DATE}} | v1.0.0 — Initial constitution ratified | Project inception |

**Version**: 1.0.0 | **Ratified**: {{DATE}}
