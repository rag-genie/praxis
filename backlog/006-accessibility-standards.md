# 006 — Constitution Template Has No Accessibility Section

## Origin
Discovered during eb1a-guide validation (2026-03-22).

## Problem
The praxis constitution template has no section addressing accessibility. Accessibility requirements (WCAG compliance, keyboard navigation, semantic HTML, screen reader support, contrast ratios, focus management) are not prompted or mentioned anywhere in the template. Projects that need accessibility must define it from scratch, and projects that don't think about it will omit it entirely.

## Requirements
- Add an accessibility section to Article IV (Code Quality Standards) as a framework-level standard
- Define a baseline tier that applies universally (semantic HTML, keyboard navigation, focus management) — these are good practice regardless of project type
- Allow projects to specify their compliance level (WCAG A, AA, AAA, or N/A with justification for non-user-facing projects like CLIs or APIs)
- Include guidance on how accessibility is tested (automated checks like axe-core, manual verification for screen readers)

## Evidence
- eb1a-guide requires WCAG AA as a hard constraint (immigration tool used by diverse global population) — had to define accessibility requirements from scratch since the template provides no guidance
- value-scanner has user-facing UI but no explicit accessibility section in its constitution — this gap likely exists there too

## Deferred Until
After eb1a-guide validation is complete.
