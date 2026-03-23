# 001 — Conditional Constitution Sections Based on Project Profile

## Origin
Discovered during eb1a-guide validation (first non-value-scanner project, 2026-03-22).

## Problem
Constitution template's "FRAMEWORK: Use as-is" sections (Articles V, VIII, IX) bake in full-stack assumptions — database queries, API routes, migrations, backup, restart resilience. Client-side SPA projects must N/A or override a significant portion (~40% of framework sections).

## Requirements
- Project profile declaration at the top of the constitution (e.g., has_backend, has_database, has_api_routes, has_background_jobs, deployment_model)
- Framework sections conditionally included based on profile
- Governance sections (workflow, quality gates, traceability, review methodology) remain universal — always included regardless of profile
- Projects that don't match a profiled surface get clean N/A instead of requiring per-project amendments

## Evidence
- eb1a-guide (client-side React SPA): no database, no API routes, no backend, no migrations, no backup/restart resilience — all required N/A with justification
- value-scanner (Next.js full-stack): all sections applied as-is

## Deferred Until
After eb1a-guide validation is complete. Need two concrete data points (full-stack + SPA) before designing the profile system.
