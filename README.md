# Praxis

A governance extension for [spec-kit](https://github.com/github/spec-kit) that provides battle-tested constitutional authority, quality gates, and bidirectional traceability from commit zero. Works as a spec-kit extension or standalone.

## What praxis adds to spec-kit

Spec-kit provides the workflow engine (specify → plan → tasks → implement). Praxis adds the governance layer:

| Artifact | What it provides |
|----------|-----------------|
| `constitution-template.md` | Constitution with portable sections pre-filled (testing standards, evolution & maintenance, diagnosability, governance) + guided placeholders for project-specific content |
| `rules/` | 4 AI agent gate files — pre-edit, pre-commit, pre-push, quality gates |
| `templates/` | Template overrides with traceability language baked in |
| `ci/` | Parameterized GitHub Actions CI + language-agnostic PR task checker |
| `git/` | Conventional commit hook + PR template |
| `agents/` | Cross-tool AI instructions (CLAUDE.md, AGENTS.md) |
| `scripts/` | Helper scripts (feature creation, prerequisite checks, agent context for 20+ AI tools) |

## Install

### As a spec-kit extension (recommended)

```bash
# After running: specify init
specify extension add --dev /path/to/praxis

# Then install governance files into your project
/speckit.praxis.setup
```

### Standalone (without spec-kit)

```bash
git clone https://github.com/rag-genie/praxis.git
./praxis/scripts/bootstrap.sh /path/to/your/project
```

## After installation

1. **Constitution** (`.specify/memory/constitution.md`) — fill in project-specific sections: Articles I (Mission), II (Architecture), III (Stack), VI (Domain Rules), VII (Security)
2. **CI workflow** (`.github/workflows/ci.yml`) — uncomment and configure for your stack
3. **Pre-commit gate** (`.claude/rules/pre-commit-gate.md`) — replace `{{LINT_CMD}}`, `{{TYPECHECK_CMD}}`, `{{TEST_CMD}}`, `{{E2E_CMD}}` with your commands
4. **CLAUDE.md** — add your project's build/test commands
5. **Start building**: `/speckit.specify <feature description>`

## The workflow

```
Idea → Spec → Clarify → Plan → Tasks → Implement → Validate
         ↑                                    |
         └────── Update spec if needed ───────┘
```

Spec-kit provides the workflow commands. Praxis provides the governance rules that constrain them — the constitution is the supreme authority for all development decisions.

## Constitution template

The primary artifact. Two types of sections:

**Portable (pre-filled)** — governance rules that work for any project:
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

Praxis governance works with any AI coding tool. `CLAUDE.md` is read by Claude Code, `AGENTS.md` by Codex CLI/Amp/Kiro. The `update-agent-context.sh` script supports 20+ tools. The rule files and constitution apply regardless of tooling.

## Staying current with spec-kit

Praxis is an extension, not a fork. When spec-kit releases a new version, check if the extension schema or template resolution changed. If not, nothing to do.

## License

MIT
