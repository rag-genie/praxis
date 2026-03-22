---
description: Install praxis governance files (rule gates, CI templates, git hooks, constitution) into the current project.
---

## User Input

```text
$ARGUMENTS
```

You **MUST** consider the user input before proceeding (if not empty).

## Goal

Install the praxis governance framework into the current project. This command copies rule files, CI templates, and git hooks to their correct locations, and ensures the constitution template has portable governance sections pre-filled.

This command is idempotent — running it again will not overwrite files that already exist unless the user explicitly requests it with `--force`.

## Execution Steps

### 1. Detect Project Context

- Determine the repository root (git or `.specify/` marker)
- Check if praxis is already installed by looking for `.claude/rules/pre-commit-gate.md`
- If already installed and `--force` not specified: report status and exit

### 2. Collect Project Name

- If `$ARGUMENTS` contains a project name, use it
- Otherwise check if `.specify/memory/constitution.md` exists and extract the project name
- If still unknown, ask the user

### 3. Install Rule Files

Copy the following files to `.claude/rules/`:

- `pre-edit-gate.md` — Four mandatory questions before modifying any source file
- `pre-commit-gate.md` — Enumerated pre-commit checklist with quality gate commands
- `pre-push-gate.md` — Push + PR description atomic update checklist
- `quality-gates.md` — Process over speed, review methodology, three-layer review

If `.claude/rules/` does not exist, create it.

**IMPORTANT**: After copying `pre-commit-gate.md`, remind the user to replace the `{{LINT_CMD}}`, `{{TYPECHECK_CMD}}`, `{{TEST_CMD}}`, and `{{E2E_CMD}}` placeholders with their actual commands.

### 4. Install CI Templates

Copy to `.github/workflows/`:

- `ci.yml` — Parameterized quality gate workflow (from `ci/ci.yml.template`)
- `pr-tasks.yml` — PR task completion checker

Remind the user to uncomment and configure `ci.yml` for their stack.

### 5. Install PR Template

Copy `git/pull_request_template.md` to `.github/pull_request_template.md`.

### 6. Install Git Hook

If `.git/` exists:
- Copy `git/commit-msg.hook` to `.git/hooks/commit-msg`
- Make it executable

If `.git/` does not exist, warn the user and skip.

### 7. Verify Constitution

Check if `.specify/memory/constitution.md` exists:

- If it exists: verify it contains the praxis portable sections (look for "Article V — Testing Standards" and "Article VIII — Evolution & Maintenance"). If missing, warn that the constitution may be using the bare spec-kit template.
- If it does not exist: copy the praxis constitution template and stamp the project name.

### 8. Create Project Directories

Ensure `specs/` and `backlog/` directories exist.

### 9. Report

Output a summary:
- Files installed (with paths)
- Files skipped (already existed)
- Action items for the user:
  1. Configure quality gate commands in `.claude/rules/pre-commit-gate.md`
  2. Configure CI workflow in `.github/workflows/ci.yml`
  3. Fill in project-specific constitution sections (Articles I, II, III, VI, VII)
  4. Start first feature: `/speckit.specify <description>`
