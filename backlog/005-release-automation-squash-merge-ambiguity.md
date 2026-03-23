# 005 — §9.7 Release Automation vs §8.3 Squash-Merge Ambiguity

## Origin
Discovered in value-scanner (cross-section conflict), confirmed unresolved in praxis template during eb1a-guide validation (2026-03-22).

## Problem
The constitution template §9.7 says: "Changelog and release notes must be generated automatically from conventional commit messages on `main`. Manual changelog maintenance is prohibited."

§8.3 says: "Squash-merge feature branches to keep main history clean."

These conflict: squash-merge means main only has squash commits (one per PR), not the individual conventional commits from feature branches. A new project reading both sections would be confused about how release automation works with squash-merge.

## Resolution (already implemented in value-scanner, NOT in template)
Value-scanner resolved this by amending §9.7 to clarify: "§8.3's squash-merge policy ensures each merge commit is a conventional commit that release-please can parse; branches with multiple releasable changes must follow §8.3's multi-line or split-PR rules."

## Requirements
- Backport value-scanner's §9.7 clarification to the praxis constitution template
- The template should make it clear that squash commits on main follow conventional commit format via the PR title/description
- This is a bug fix, not a feature request — the resolution exists, it just wasn't propagated

## Priority
High — this is a known-resolved ambiguity that will bite every new project using the template.
