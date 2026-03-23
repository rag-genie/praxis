# 002 — "Design for Intelligence, Ship with Static" as Reusable Pattern

## Origin
Discovered during eb1a-guide validation (2026-03-22).

## Problem
The advisor service layer pattern (UI → hook → privacy guard → swappable provider) is not EB-1A-specific. Any project that wants AI-readiness without v1 AI dependency could use it. Currently, this pattern must be designed from scratch per project.

## Requirements
- Add as an optional architectural pattern in the constitution template §2.6, alongside existing Repository/Service/Adapter patterns
- Define the pattern: service interface with privacy guard, static provider for v1, AI provider stub for v2, single-constant swap for activation
- Include guidance on when to use it (projects planning AI features but wanting to ship without them initially)

## Evidence
- eb1a-guide's advisor architecture follows the Adapter pattern already in praxis §2.6 but applied specifically to AI service integration
- The pattern enforces privacy structurally (guard runs before any provider) rather than by policy

## Deferred Until
After eb1a-guide validation. Need to confirm the pattern works in practice before templating it.
