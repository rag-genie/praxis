#!/usr/bin/env bash
# Praxis — Project Governance Framework Bootstrap
#
# Initializes a new project with the praxis governance structure.
#
# Usage: ./bootstrap.sh <target-project-path>
#
# What it does:
#   1. Copies governance files to correct locations in the target project
#   2. Prompts for project name and stamps it into configuration files
#   3. Sets up the conventional commit git hook
#   4. Prints a summary of what was created and what needs manual configuration

set -euo pipefail

SCRIPT_DIR="$(CDPATH="" cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRAXIS_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Colors (if terminal supports them)
if [ -t 1 ]; then
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    RED='\033[0;31m'
    BOLD='\033[1m'
    NC='\033[0m'
else
    GREEN='' YELLOW='' RED='' BOLD='' NC=''
fi

info()    { echo -e "${GREEN}✓${NC} $1"; }
warn()    { echo -e "${YELLOW}⚠${NC} $1"; }
error()   { echo -e "${RED}✗${NC} $1" >&2; }
heading() { echo -e "\n${BOLD}$1${NC}"; }

usage() {
    echo "Usage: $0 <target-project-path>"
    echo ""
    echo "Initializes a project with the praxis governance framework."
    echo ""
    echo "Options:"
    echo "  -h, --help    Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 /home/user/my-new-project"
    echo "  $0 .  # Initialize current directory"
    exit 0
}

# Parse arguments
if [ $# -eq 0 ] || [ "$1" = "-h" ] || [ "$1" = "--help" ]; then
    usage
fi

TARGET="$(cd "$1" 2>/dev/null && pwd || echo "$1")"

if [ ! -d "$TARGET" ]; then
    echo "Target directory does not exist: $TARGET"
    read -rp "Create it? [Y/n] " create_dir
    if [ "${create_dir:-Y}" = "n" ] || [ "${create_dir:-Y}" = "N" ]; then
        echo "Aborted."
        exit 1
    fi
    mkdir -p "$TARGET"
    TARGET="$(cd "$TARGET" && pwd)"
fi

# Prompt for project name
heading "Praxis — Project Governance Bootstrap"
echo ""
read -rp "Project name: " PROJECT_NAME
if [ -z "$PROJECT_NAME" ]; then
    error "Project name is required."
    exit 1
fi

echo ""
heading "Copying governance files..."

# Helper: copy file, creating parent dirs as needed
copy_file() {
    local src="$1" dest="$2"
    mkdir -p "$(dirname "$dest")"
    cp "$src" "$dest"
    info "$(echo "$dest" | sed "s|$TARGET/||")"
}

# Helper: copy directory contents
copy_dir() {
    local src="$1" dest="$2"
    mkdir -p "$dest"
    cp -r "$src"/* "$dest"/
}

# 1. Constitution template → .specify/memory/constitution.md
copy_file "$PRAXIS_ROOT/constitution-template.md" "$TARGET/.specify/memory/constitution.md"

# 2. Rule files → .claude/rules/
for rule in pre-edit-gate.md pre-commit-gate.md pre-push-gate.md quality-gates.md; do
    copy_file "$PRAXIS_ROOT/rules/$rule" "$TARGET/.claude/rules/$rule"
done

# 3. Spec workflow templates → .specify/templates/
for tmpl in spec-template.md plan-template.md tasks-template.md constitution-template.md checklist-template.md agent-file-template.md; do
    if [ -f "$PRAXIS_ROOT/templates/$tmpl" ]; then
        copy_file "$PRAXIS_ROOT/templates/$tmpl" "$TARGET/.specify/templates/$tmpl"
    fi
done

# 4. Slash commands → .claude/commands/
for cmd in "$PRAXIS_ROOT"/commands/praxis.*.md; do
    if [ -f "$cmd" ]; then
        copy_file "$cmd" "$TARGET/.claude/commands/$(basename "$cmd")"
    fi
done

# 5. Helper scripts → .specify/scripts/bash/
for script in common.sh check-prerequisites.sh setup-plan.sh create-new-feature.sh update-agent-context.sh; do
    if [ -f "$PRAXIS_ROOT/scripts/bash/$script" ]; then
        copy_file "$PRAXIS_ROOT/scripts/bash/$script" "$TARGET/.specify/scripts/bash/$script"
        chmod +x "$TARGET/.specify/scripts/bash/$script"
    fi
done

# 6. PR template → .github/pull_request_template.md
copy_file "$PRAXIS_ROOT/git/pull_request_template.md" "$TARGET/.github/pull_request_template.md"

# 7. CI templates → .github/workflows/ (rename .template → .yml)
if [ -f "$PRAXIS_ROOT/ci/ci.yml.template" ]; then
    copy_file "$PRAXIS_ROOT/ci/ci.yml.template" "$TARGET/.github/workflows/ci.yml"
fi
if [ -f "$PRAXIS_ROOT/ci/pr-tasks.yml" ]; then
    copy_file "$PRAXIS_ROOT/ci/pr-tasks.yml" "$TARGET/.github/workflows/pr-tasks.yml"
fi

# 8. Agent files → project root
copy_file "$PRAXIS_ROOT/agents/CLAUDE.md" "$TARGET/CLAUDE.md"
copy_file "$PRAXIS_ROOT/agents/AGENTS.md" "$TARGET/AGENTS.md"

# 9. Stamp project name into config files
heading "Stamping project name: $PROJECT_NAME"

for file in "$TARGET/CLAUDE.md" "$TARGET/AGENTS.md" "$TARGET/.specify/memory/constitution.md"; do
    if [ -f "$file" ]; then
        sed -i "s/{{PROJECT_NAME}}/$PROJECT_NAME/g" "$file"
        info "Stamped $(echo "$file" | sed "s|$TARGET/||")"
    fi
done

# 10. Set up git hook (only if .git exists)
if [ -d "$TARGET/.git" ]; then
    heading "Setting up git hooks..."
    copy_file "$PRAXIS_ROOT/git/commit-msg.hook" "$TARGET/.git/hooks/commit-msg"
    chmod +x "$TARGET/.git/hooks/commit-msg"
else
    warn "No .git directory found — skipping commit-msg hook installation"
    warn "Run 'git init' first, then copy git/commit-msg.hook to .git/hooks/commit-msg"
fi

# 11. Create specs/ and backlog/ directories
mkdir -p "$TARGET/specs" "$TARGET/backlog"
info "specs/"
info "backlog/"

# Summary
heading "Bootstrap complete!"
echo ""
echo "Files created:"
echo "  .specify/memory/constitution.md    — Project constitution (edit this first!)"
echo "  .specify/templates/               — Spec workflow templates"
echo "  .specify/scripts/bash/            — Helper scripts"
echo "  .claude/rules/                    — AI agent gate files"
echo "  .claude/commands/                 — Slash commands (/praxis.*)"
echo "  .github/workflows/               — CI templates"
echo "  .github/pull_request_template.md  — PR template"
echo "  CLAUDE.md                         — Claude Code entry point"
echo "  AGENTS.md                         — Cross-tool AI instructions"
echo "  specs/                            — Feature specifications"
echo "  backlog/                          — Future requirements"
echo ""
heading "Next steps:"
echo "  1. Edit .specify/memory/constitution.md — fill in project-specific sections"
echo "     (Articles I, II, III, VI, VII are placeholder — fill them in)"
echo "  2. Edit .github/workflows/ci.yml — uncomment and configure for your stack"
echo "  3. Edit .claude/rules/pre-commit-gate.md — replace {{LINT_CMD}} etc. with your commands"
echo "  4. Edit CLAUDE.md — add your project's commands"
echo "  5. Start your first feature: /praxis.specify <feature description>"
echo ""
