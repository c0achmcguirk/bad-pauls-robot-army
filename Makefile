# Poliver's Bot Army - Makefile
# Provides convenient shortcuts for managing the Robot Army installation.

.PHONY: help install install-force setup dry-run clean-install uninstall uninstall-dry-run uninstall-legacy uninstall-legacy-dry-run

# Default target - show help
help:
	@echo "Poliver's Bot Army - Installation Commands"
	@echo ""
	@echo "Usage: make [target]"
	@echo ""
	@echo "Targets:"
	@echo "  install              - Install all commands and skills to ~/.gemini/"
	@echo "  install-force        - Install and overwrite any existing files."
	@echo "  setup                - Run one-time setup to prepare for installation."
	@echo "  dry-run              - Preview what 'install' would do without making changes."
	@echo "  uninstall            - Safely move installed pba-* files to ~/pba-backup/"
	@echo "  uninstall-dry-run    - Preview what 'uninstall' would do."
	@echo "  uninstall-legacy     - Uninstall legacy files (without pba- prefix)."
	@echo "  uninstall-legacy-dry-run - Preview legacy uninstall."
	@echo ""
	@echo "Examples:"
	@echo "  make setup                  # Run this first!"
	@echo "  make install                # Install the army."
	@echo "  make dry-run                # See what would be installed."
	@echo "  make uninstall              # Safely remove installed files."
	@echo "  make uninstall-legacy       # Remove legacy-named files."

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

# Uninstall - safely move installed files to backup
uninstall:
	@./scripts/uninstall.sh

# Preview uninstallation without making changes
uninstall-dry-run:
	@./scripts/uninstall.sh --dry-run

# Uninstall legacy-named files (pre-pba- prefix)
uninstall-legacy:
	@./scripts/uninstall.sh --legacy

# Preview legacy uninstallation
uninstall-legacy-dry-run:
	@./scripts/uninstall.sh --legacy --dry-run
