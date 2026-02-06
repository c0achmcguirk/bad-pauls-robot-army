#!/usr/bin/env bash
#
# setup.sh - Quick setup for Poliver's Bot Army
# This script ensures the necessary directories exist and makes scripts executable.

set -euo pipefail

# --- Colors for Output ---
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${BLUE}▶ Setting up Poliver's Bot Army...${NC}"
echo

# --- Create local script directory if it doesn't exist ---
log "Ensuring local scripts directory exists..."
mkdir -p scripts
success "Local scripts directory is ready."
echo

# --- Make scripts executable ---
log "Making installation scripts executable..."
chmod +x scripts/install.sh
success "Scripts are now executable."
echo

# --- Ensure Gemini CLI directories exist ---
log "Checking for Gemini CLI configuration directories..."
if [[ ! -d "$HOME/.gemini-cli" ]]; then
    warn "Gemini CLI directory not found at ~/.gemini-cli."
    log "Creating base directory structure for you."
    mkdir -p "$HOME/.gemini-cli/commands"
    mkdir -p "$HOME/.gemini-cli/skills"
    success "Created Gemini CLI directories."
else
    success "Gemini CLI directory found."
fi
echo

# --- Final Instructions ---
success "Setup complete!"
echo
echo "You are now ready to install the Robot Army."
echo "Run the following command to install:"
echo -e "  ${GREEN}./scripts/install.sh${NC}"
echo
echo "This will copy all commands and skills to your Gemini CLI configuration."
echo "Restart Gemini CLI after installation to use the new tools."
