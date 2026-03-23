# 004 — Constitution Template Stack Table Missing Common Rows

## Origin
Discovered during eb1a-guide validation (2026-03-22).

## Problem
Article III's stack table prompts for: Language, Runtime, Web Framework, Database, ORM, Testing, Package Manager. The template says "[Add rows as needed]" but relying on projects to remember what to add leads to inconsistent coverage.

Missing common rows:
- Build tool / Bundler (Vite, webpack, esbuild, Next.js built-in)
- CSS framework / approach (Tailwind, CSS Modules, styled-components)
- Deployment target (static hosting, container, serverless)
- Icon library
- Charting library
- State management approach

## Requirements
- Expand the default table to include all common stack dimensions
- Use "remove if N/A" guidance rather than "add if you think of it"
- Keep "[Add rows as needed]" for truly unusual stack components

## Evidence
- eb1a-guide needs Vite (build), Tailwind (CSS), static hosting (deployment), lucide-react (icons), recharts (charts), useReducer (state) — none prompted by current template
- value-scanner: Next.js handles bundling implicitly, but Tailwind, Recharts, pino (logging) were also not prompted

## Deferred Until
After eb1a-guide validation. Low risk — this is a template completeness issue, not a structural one.
