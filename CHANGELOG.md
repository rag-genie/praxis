# Changelog

All notable changes to the Praxis governance framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-22

### Added

- **Constitution template** — primary governance artifact with portable sections (testing standards, evolution & maintenance, diagnosability, governance) and guided placeholders for project-specific content (mission, architecture, stack, domain rules, security)
- **Rule files** — AI agent gate files for pre-edit, pre-commit, pre-push, and quality gates
- **Spec workflow templates** — spec, plan, tasks, constitution, checklist, and agent-file templates
- **Slash commands** — 9 commands for the full spec-driven workflow: `/praxis.specify`, `/praxis.clarify`, `/praxis.plan`, `/praxis.tasks`, `/praxis.implement`, `/praxis.analyze`, `/praxis.checklist`, `/praxis.constitution`, `/praxis.taskstoissues`
- **Helper scripts** — common utilities, prerequisite checking, plan setup, feature creation, agent context updates (supports 20+ AI tools)
- **CI templates** — parameterized GitHub Actions CI workflow and language-agnostic PR task checker
- **Git configuration** — conventional commit hook and parameterized PR template
- **Bootstrap script** — interactive project initialization that copies files to correct locations
- **Agent instructions** — cross-tool AGENTS.md and Claude-specific CLAUDE.md entry points
