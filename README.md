# Praxis

A deterministic governance framework for AI-assisted software development. Praxis gives any project — regardless of stack, domain, or scale — a spec-driven development workflow with constitutional authority, quality gates, and bidirectional traceability from commit zero.

## What's in the box

| Directory | Purpose | Installs to |
|-----------|---------|-------------|
| `constitution-template.md` | Primary governance artifact — portable rules + guided placeholders | `.specify/memory/constitution.md` |
| `rules/` | AI agent gate files (pre-edit, pre-commit, pre-push, quality) | `.claude/rules/` |
| `templates/` | Spec workflow templates (spec, plan, tasks, constitution, checklist) | `.specify/templates/` |
| `commands/` | Slash commands for the full workflow (`/praxis.*`) | `.claude/commands/` |
| `scripts/` | Helper scripts (feature creation, prerequisite checks, agent context) | `.specify/scripts/` |
| `ci/` | GitHub Actions CI templates (parameterized quality gates, PR task checker) | `.github/workflows/` |
| `git/` | Conventional commit hook + PR template | `.git/hooks/`, `.github/` |
| `agents/` | Cross-tool AI instructions (AGENTS.md, CLAUDE.md) | project root |

## Quick start

### 1. Bootstrap a new project

```bash
git clone https://github.com/rag-genie/praxis.git
cd praxis
./scripts/bootstrap.sh /path/to/your/project
```

The bootstrap script will:
- Copy all governance files to their correct locations
- Prompt for your project name
- Install the conventional commit git hook
- Print what needs manual configuration

### 2. Configure your project

After bootstrap, fill in the project-specific sections:

1. **Constitution** (`.specify/memory/constitution.md`) — fill in Articles I (Mission), II (Architecture), III (Stack), VI (Domain Rules), VII (Security)
2. **CI workflow** (`.github/workflows/ci.yml`) — uncomment and configure for your stack
3. **Pre-commit gate** (`.claude/rules/pre-commit-gate.md`) — replace `{{LINT_CMD}}`, `{{TYPECHECK_CMD}}`, `{{TEST_CMD}}`, `{{E2E_CMD}}` with your commands
4. **CLAUDE.md** — add your project's build/test commands

### 3. Start building

```
/praxis.specify I want to build a user authentication system with OAuth2
```

This kicks off the spec-driven workflow:
1. `/praxis.specify` — creates a feature spec from your description
2. `/praxis.clarify` — identifies and resolves ambiguities
3. `/praxis.plan` — generates implementation plan with architecture
4. `/praxis.tasks` — breaks the plan into ordered, testable tasks
5. `/praxis.implement` — executes the task plan with quality gates
6. `/praxis.analyze` — cross-artifact consistency check

## The workflow

```
Idea → Spec → Clarify → Plan → Tasks → Implement → Validate
         ↑                                    |
         └────── Update spec if needed ───────┘
```

Every feature follows this workflow without exception. The constitution is the supreme authority — if a spec, plan, or task conflicts with a constitutional principle, the constitution wins.

## Constitution template

The constitution template is the primary artifact. It has two types of sections:

**Portable (filled in)** — governance rules that work for any project:
- Article V: Testing standards (coverage, quality rules, tests-as-deliverables)
- Article VIII: Evolution & maintenance (spec-driven workflow, git discipline, quality gates)
- Article IX §9.6: Diagnosability (three-tier traceability: runtime, config-assertion, manual)
- Article X: Governance (supremacy, amendments, least surprise)

**Project-specific (placeholders)** — guided sections you fill in:
- Article I: Mission & identity
- Article II: Architecture
- Article III: Technology stack
- Article VI: Domain integrity rules
- Article VII: Security & privacy
- Article IX §9.1-9.5, §9.7-9.8: Performance & reliability budgets

## AI tool support

Praxis works with any AI coding tool. The `update-agent-context.sh` script supports 20+ tools including Claude Code, Gemini CLI, GitHub Copilot, Cursor, Windsurf, Kilo Code, and more. The slash commands (`/praxis.*`) are Claude Code commands; the governance rules and workflow apply regardless of tooling.

## License

MIT
