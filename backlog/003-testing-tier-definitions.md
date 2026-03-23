# 003 — Testing Tier Definitions Are Full-Stack-Specific

## Origin
Discovered during eb1a-guide validation (2026-03-22).

## Problem
Article V (Testing Standards, marked "FRAMEWORK: Use as-is") mandates testing tiers tied to full-stack surfaces: "database queries must have integration tests," "API routes must have integration tests," §5.4 ties deliverables to "database query functions" and "API routes."

For a client-side SPA, these surfaces don't exist. The testing *principles* (tests are deliverables, deterministic, ship with code) are universal. The *tier definitions and surface enumeration* are project-type-specific.

## Requirements
- Separate universal testing principles (keep as "FRAMEWORK: Use as-is") from surface-specific tier definitions (make conditional based on project profile)
- Define tier templates per project type:
  - Full-stack: unit → DB/API integration → E2E
  - Client-side SPA: unit → component interaction → E2E + accessibility
  - CLI: unit → command integration → acceptance
- §5.4 (Tests as Deliverables) surface enumeration needs to be parameterized by project type

## Evidence
- eb1a-guide testing tiers: unit (logic), component (React Testing Library), E2E (Playwright), accessibility (axe-core) — none match the template's assumed tiers
- value-scanner testing tiers: unit (Vitest), integration (DB/API), E2E (Playwright) — match the template exactly

## Related
Gap #1 (conditional sections), but distinct — this is about content within a section, not whether the section applies.

## Deferred Until
After eb1a-guide validation. Need both project types' testing experiences to define the right tier templates.
