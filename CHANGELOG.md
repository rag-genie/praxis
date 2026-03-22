# Changelog

All notable changes to the Praxis governance framework will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.0] - 2026-03-22

### Added

- **spec-kit extension manifest** (`extension.yml`) — declares praxis as a valid spec-kit extension with template overrides, hooks, and the setup command
- **Constitution template** — primary governance artifact with portable sections (testing standards, evolution & maintenance, diagnosability, governance) and guided placeholders for project-specific content
- **Setup command** (`speckit.praxis.setup`) — installs rule files, CI templates, git hooks, and constitution into the target project
- **Rule files** — 4 AI agent gate files for pre-edit, pre-commit, pre-push, and quality gates
- **Template overrides** — spec, tasks, and constitution templates with governance and traceability language pre-filled
- **CI templates** — parameterized GitHub Actions CI workflow and language-agnostic PR task checker
- **Git configuration** — conventional commit hook and parameterized PR template
- **Bootstrap script** — standalone project initialization for use without spec-kit
- **Helper scripts** — common utilities, prerequisite checking, plan setup, feature creation, agent context updates (supports 20+ AI tools)
- **Agent instructions** — cross-tool AGENTS.md and Claude-specific CLAUDE.md entry points
- **Configuration template** — project-level governance config (gate commands, review settings)
