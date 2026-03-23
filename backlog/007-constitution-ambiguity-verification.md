# 007 — Constitution Ambiguity Verification Step

## Origin
Discovered during eb1a-guide constitution review (2026-03-22). Spec-kit has a `clarify` command for feature specs but nothing equivalent for constitutions.

## Problem
The constitution review process currently has cross-section conflict detection and two consecutive clean passes, but no structured ambiguity scan. Ambiguities found during eb1a-guide review (stale template references, measurement gaps, cross-reference validity) were caught ad hoc rather than through a systematic taxonomy. Spec-kit's `clarify` command provides a taxonomy for feature spec ambiguity but it doesn't apply to constitutions, which have different concerns.

## Requirements
- Add a constitution-specific ambiguity verification step to the review process
- Define a taxonomy adapted for constitutional concerns:
  - Are mandates measurable and enforceable? (e.g., "WCAG AA" is testable; "high quality" is not)
  - Do N/A justifications hold against the project profile?
  - Are cross-references between sections valid and bidirectional?
  - Do "FRAMEWORK: Use as-is" sections actually apply to this project type?
  - Are there stale references from the template that weren't adapted?
  - Do overlapping sections (e.g., §3.2 and §7.2 both mentioning localStorage) have clear authority hierarchy?
  - Are phase-scoped mandates clearly marked vs universal mandates?
- This step runs before the cross-section conflict detection and two clean passes
- Could be implemented as a praxis command (like spec-kit's `clarify`) or as an addition to the quality-gates rule file

## Evidence
- eb1a-guide Round 1 found 6 issues that a structured taxonomy would have caught systematically: stale "API route handler" reference, duplicated localStorage prohibition without cross-reference, "100% coverage" tension with E2E exemption, orphaned release notes reference, missing font size mandate, service layer bypass ambiguity
- Spec-kit's `clarify` taxonomy (functional scope, domain model, interaction/UX, non-functional) is a useful model but needs adaptation for constitution-level documents

## Deferred Until
After eb1a-guide validation is complete.
