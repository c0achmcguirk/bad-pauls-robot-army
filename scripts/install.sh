#!/usr/bin/env bash
#
# install.sh - Install Poliver's Bot Army commands and skills for Gemini CLI.
#
# This script copies the command and skill files from this repository into the
# user's Gemini CLI configuration directory (~/.gemini/).

set -euo pipefail

# --- Configuration ---
# Base directory for Gemini CLI configuration
GEMINI_BASE_DIR="$HOME/.gemini"
# Source directories in this repository
REPO_COMMANDS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/commands"
REPO_SKILLS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/skills"

# --- Colors for Output ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# --- Script Options ---
DRY_RUN=false
VERBOSE=false
FORCE=false

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

show_help() {
    echo "Usage: $(basename "$0") [options]"
    echo ""
    echo "Installs Poliver's Bot Army for Gemini CLI."
    echo ""
    echo "Options:"
    echo "  -d, --dry-run    Show what would be installed without making changes."
    echo "  -f, --force      Overwrite existing files without prompting."
    echo "  -h, --help       Show this help message."
    echo "  -v, --verbose    Enable verbose output."
}

# --- Main Logic ---

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -d|--dry-run) DRY_RUN=true; shift ;;
        -v|--verbose) VERBOSE=true; shift ;;
        -f|--force) FORCE=true; shift ;;
        -h|--help) show_help; exit 0 ;;
        *) error "Unknown option: $1"; show_help; exit 1 ;;
    esac
done

# Define target directories
GEMINI_COMMANDS_DIR="$GEMINI_BASE_DIR/commands"
GEMINI_SKILLS_DIR="$GEMINI_BASE_DIR/skills"

# --- Installation ---

log "Starting installation of Poliver's Bot Army..."

# 1. Create target directories if they don't exist
if [[ "$DRY_RUN" == "false" ]]; then
    log "Ensuring Gemini CLI directories exist..."
    mkdir -p "$GEMINI_COMMANDS_DIR"
    mkdir -p "$GEMINI_SKILLS_DIR"
    success "Directories are ready."
else
    log "Dry run: Would ensure directories exist:"
    echo "    - $GEMINI_COMMANDS_DIR"
    echo "    - $GEMINI_SKILLS_DIR"
fi

echo ""

# 2. Install Commands
log "Installing commands..."
if [[ "$DRY_RUN" == "true" ]]; then
    echo "Dry run: The following commands would be installed to $GEMINI_COMMANDS_DIR:"
    # Exclude copying the arch review.toml file
    find "$REPO_COMMANDS_DIR" -type f -name "*.toml" -not -path "*arch/pba-review.toml*" -print | sed "s|^$REPO_COMMANDS_DIR/|  - |"
    echo "  - arch/pba-review.toml" # Manually add it to the list
else
    # Copy all .toml files, preserving directory structure, but exclude the arch review.toml file for now
    rsync -av --prune-empty-dirs --include="*/" --include="*.toml" --exclude="*" --exclude="arch/pba-review.toml" "$REPO_COMMANDS_DIR/" "$GEMINI_COMMANDS_DIR/"
    
    # Ensure the arch directory exists and copy the review.toml file
    mkdir -p "$GEMINI_COMMANDS_DIR/arch"
    cp "$REPO_COMMANDS_DIR/arch/pba-review.toml" "$GEMINI_COMMANDS_DIR/arch/pba-review.toml"

    success "All commands installed."
fi
echo ""

# 3. Install Skills
log "Installing skills..."
if [[ "$DRY_RUN" == "true" ]]; then
    echo "Dry run: The following skills would be installed to $GEMINI_SKILLS_DIR:"
    find "$REPO_SKILLS_DIR" -mindepth 1 -maxdepth 1 -type d -print | sed "s|^$REPO_SKILLS_DIR/|  - |"
else
    rsync -av "$REPO_SKILLS_DIR/" "$GEMINI_SKILLS_DIR/"
    success "All skills installed."
fi
echo ""

success "Poliver's Bot Army has been successfully installed!"
if [[ "$DRY_RUN" == "true" ]]; then
    warn "This was a dry run. No files were actually changed."
fi
echo -e "Restart Gemini CLI to load the new commands and skills."
