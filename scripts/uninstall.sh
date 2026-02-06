#!/usr/bin/env bash
#
# uninstall.sh - Uninstall Poliver's Bot Army commands and skills from Gemini CLI.
#
# This script safely moves installed PBA files from ~/.gemini/ to ~/pba-backup/
# for user verification before permanent deletion.

set -euo pipefail

# --- Configuration ---
GEMINI_BASE_DIR="$HOME/.gemini"
GEMINI_COMMANDS_DIR="$GEMINI_BASE_DIR/commands"
GEMINI_SKILLS_DIR="$GEMINI_BASE_DIR/skills"
BACKUP_BASE_DIR="$HOME/pba-backup"

# --- Colors for Output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# --- Script Options ---
DRY_RUN=false
VERBOSE=false
LEGACY=false

# --- Counters ---
COMMANDS_MOVED=0
SKILLS_MOVED=0

# --- Helper Functions ---
log() {
    echo -e "${BLUE}▶${NC} $*"
}

success() {
    echo -e "${GREEN}✔${NC} $*"
}

warn() {
    echo -e "${YELLOW}⚠${NC} $*"
}

error() {
    echo -e "${RED}✖${NC} $*" >&2
}

verbose() {
    if [[ "$VERBOSE" == "true" ]]; then
        echo -e "  $*"
    fi
}

show_help() {
    echo "Usage: $(basename "$0") [options]"
    echo ""
    echo "Uninstalls Poliver's Bot Army from Gemini CLI by moving files to a backup."
    echo ""
    echo "Options:"
    echo "  -d, --dry-run    Show what would be uninstalled without making changes."
    echo "  -h, --help       Show this help message."
    echo "  -l, --legacy     Uninstall legacy-named files (without pba- prefix)."
    echo "  -v, --verbose    Enable verbose output."
    echo ""
    echo "Examples:"
    echo "  $(basename "$0")              # Uninstall current pba-* files"
    echo "  $(basename "$0") --legacy     # Uninstall legacy files (pre-pba- prefix)"
    echo "  $(basename "$0") --dry-run    # Preview what would be uninstalled"
}

# Get legacy name by stripping pba- prefix
get_legacy_name() {
    local name="$1"
    echo "${name#pba-}"
}

# --- Main Logic ---

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--dry-run) DRY_RUN=true; shift ;;
        -v|--verbose) VERBOSE=true; shift ;;
        -l|--legacy) LEGACY=true; shift ;;
        -h|--help) show_help; exit 0 ;;
        *) error "Unknown option: $1"; show_help; exit 1 ;;
    esac
done

# --- Determine mode and find files ---

if [[ "$LEGACY" == "true" ]]; then
    log "Legacy mode: Looking for files without pba- prefix..."
    MODE_DESC="legacy"
else
    log "Looking for pba-* prefixed files..."
    MODE_DESC="current"
fi

echo ""

# Collect files to uninstall
declare -a COMMAND_FILES=()
declare -a SKILL_DIRS=()

if [[ "$LEGACY" == "true" ]]; then
    # Legacy mode: Look for known legacy filenames (without pba- prefix)
    # Commands at root level
    LEGACY_ROOT_COMMANDS=(
        "accessibility-review.toml"
        "api-review.toml"
        "beginners-mind.toml"
        "codebase-overview.toml"
        "code-history-detailed.toml"
        "code-history.toml"
        "concurrency-review.toml"
        "create-prd.toml"
        "database-review.toml"
        "decompose-issue.toml"
        "doc-review.toml"
        "does-this-clash.toml"
        "exception-review.toml"
        "explain.toml"
        "implementation-plan-from-prd.toml"
        "implement-issue.toml"
        "internationalization-review.toml"
        "learn.toml"
        "logging-review.toml"
        "modernization-review.toml"
        "perf-review.toml"
        "plan.toml"
        "polivers-bot-army.toml"
        "process-implementation-plan-feedback.toml"
        "process-prd-feedback.toml"
        "quality-review.toml"
        "refactor-review.toml"
        "security-review.toml"
        "tasks-from-plan.toml"
        "technical-review.toml"
        "test-review.toml"
        "update-plan-status.toml"
        "what-would-break.toml"
        "why-this-way.toml"
        "write-scoping-doc.toml"
    )

    for cmd in "${LEGACY_ROOT_COMMANDS[@]}"; do
        if [[ -f "$GEMINI_COMMANDS_DIR/$cmd" ]]; then
            COMMAND_FILES+=("$cmd")
        fi
    done

    # arch/ subdirectory
    if [[ -f "$GEMINI_COMMANDS_DIR/arch/review.toml" ]]; then
        COMMAND_FILES+=("arch/review.toml")
    fi

    # ops/ subdirectory
    LEGACY_OPS_COMMANDS=(
        "build-review.toml"
        "cloud-review.toml"
        "configuration-review.toml"
        "deployment-review.toml"
        "tooling-review.toml"
    )

    for cmd in "${LEGACY_OPS_COMMANDS[@]}"; do
        if [[ -f "$GEMINI_COMMANDS_DIR/ops/$cmd" ]]; then
            COMMAND_FILES+=("ops/$cmd")
        fi
    done

    # Legacy skills (without pba- prefix)
    LEGACY_SKILLS=(
        "accessibility-specialist"
        "api-designer"
        "architect"
        "build-master"
        "cloud-developer"
        "code-documentor"
        "code-historian"
        "code-modernizer"
        "concurrency-expert"
        "configuration-manager"
        "database-designer"
        "debugger"
        "deployment-specialist"
        "development-manager"
        "exception-handling-master"
        "internationalization-specialist"
        "logging-master"
        "mentor"
        "performance-optimizer"
        "product-manager"
        "quality-assurance-expert"
        "refactorer"
        "security-master"
        "technical-reviewer"
        "technical-scoper"
        "test-automator"
        "toolsmith"
        "workspace-tools"
    )

    for skill in "${LEGACY_SKILLS[@]}"; do
        if [[ -d "$GEMINI_SKILLS_DIR/$skill" ]]; then
            SKILL_DIRS+=("$skill")
        fi
    done
else
    # Current mode: Look for pba-* prefixed files
    # Commands at root level
    if [[ -d "$GEMINI_COMMANDS_DIR" ]]; then
        while IFS= read -r -d '' file; do
            rel_path="${file#$GEMINI_COMMANDS_DIR/}"
            COMMAND_FILES+=("$rel_path")
        done < <(find "$GEMINI_COMMANDS_DIR" -type f -name "pba-*.toml" -print0 2>/dev/null || true)
    fi

    # Skills with pba- prefix
    if [[ -d "$GEMINI_SKILLS_DIR" ]]; then
        while IFS= read -r -d '' dir; do
            skill_name="$(basename "$dir")"
            SKILL_DIRS+=("$skill_name")
        done < <(find "$GEMINI_SKILLS_DIR" -maxdepth 1 -type d -name "pba-*" -print0 2>/dev/null || true)
    fi
fi

# Check if there's anything to uninstall
if [[ ${#COMMAND_FILES[@]} -eq 0 && ${#SKILL_DIRS[@]} -eq 0 ]]; then
    warn "Nothing to uninstall. No $MODE_DESC PBA files found in $GEMINI_BASE_DIR/"
    exit 0
fi

# --- Create backup directory ---
TIMESTAMP=$(date +"%Y-%m-%d_%H%M%S")
BACKUP_DIR="$BACKUP_BASE_DIR/$TIMESTAMP"

if [[ "$DRY_RUN" == "false" ]]; then
    log "Creating backup directory: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR/commands"
    mkdir -p "$BACKUP_DIR/skills"
else
    log "Dry run: Would create backup directory: $BACKUP_DIR"
fi

echo ""

# --- Move commands ---
if [[ ${#COMMAND_FILES[@]} -gt 0 ]]; then
    log "Moving commands to backup..."

    for cmd_file in "${COMMAND_FILES[@]}"; do
        src="$GEMINI_COMMANDS_DIR/$cmd_file"
        dst="$BACKUP_DIR/commands/$cmd_file"

        if [[ "$DRY_RUN" == "true" ]]; then
            echo "  Would move: $src"
            verbose "         to: $dst"
        else
            # Ensure destination directory exists
            mkdir -p "$(dirname "$dst")"
            mv "$src" "$dst"
            verbose "Moved: $cmd_file"
        fi
        COMMANDS_MOVED=$((COMMANDS_MOVED + 1))
    done

    if [[ "$DRY_RUN" == "false" ]]; then
        success "Moved $COMMANDS_MOVED command(s) to backup."
    else
        echo "  Total: $COMMANDS_MOVED command(s)"
    fi
else
    log "No commands to uninstall."
fi

echo ""

# --- Move skills ---
if [[ ${#SKILL_DIRS[@]} -gt 0 ]]; then
    log "Moving skills to backup..."

    for skill_dir in "${SKILL_DIRS[@]}"; do
        src="$GEMINI_SKILLS_DIR/$skill_dir"
        dst="$BACKUP_DIR/skills/$skill_dir"

        if [[ "$DRY_RUN" == "true" ]]; then
            echo "  Would move: $src/"
            verbose "         to: $dst/"
        else
            mv "$src" "$dst"
            verbose "Moved: $skill_dir/"
        fi
        SKILLS_MOVED=$((SKILLS_MOVED + 1))
    done

    if [[ "$DRY_RUN" == "false" ]]; then
        success "Moved $SKILLS_MOVED skill(s) to backup."
    else
        echo "  Total: $SKILLS_MOVED skill(s)"
    fi
else
    log "No skills to uninstall."
fi

echo ""

# --- Summary ---
if [[ "$DRY_RUN" == "true" ]]; then
    warn "This was a dry run. No files were actually moved."
    echo ""
    echo "To perform the actual uninstall, run without --dry-run"
else
    success "Poliver's Bot Army ($MODE_DESC) has been uninstalled!"
    echo ""
    echo "Backup location: $BACKUP_DIR"
    echo ""
    echo "Review the backup, then delete it when ready:"
    echo "  rm -rf $BACKUP_DIR"
    echo ""
    echo "To reinstall, run: make install"
fi
