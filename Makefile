# Bad Paul's Robot Army - Makefile
# Provides convenient shortcuts for managing the Robot Army installation.

.PHONY: help install setup dry-run

# Default target - show help
help:
	@echo "Bad Paul's Robot Army - Installation Commands"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install    - Install all commands and skills to ~/.gemini/"
	@echo "  setup      - Run one-time setup to prepare for installation."
	@echo "  dry-run    - Preview what 'install' would do without making changes."
	@echo ""
	@echo "Examples:"
	@echo "  make setup         # Run this first!"
	@echo "  make install       # Install the army."
	@echo "  make install-force # Install and overwrite any existing files."
	@echo "  make dry-run       # See what would be installed."

# Main install target
install:
	@./scripts/install.sh

# Force installation (overwrite existing files)
install-force:
	@./scripts/install.sh --force

# Initial one-time setup
setup:
	@./scripts/setup.sh

# Preview installation without making changes
dry-run:
	@./scripts/install.sh --dry-run

# Alias for install-force
clean-install: install-force
