# Bad Paul's Robot Army - Makefile

.PHONY: help install uninstall status

help:
	@echo "Bad Paul's Robot Army - Extension Commands"
	@echo ""
	@echo "  make install    - Link this extension into Gemini CLI for development"
	@echo "  make uninstall  - Remove this extension from Gemini CLI"
	@echo "  make status     - Show installed extensions"

install:
	gemini extensions link .

uninstall:
	gemini extensions uninstall bad-pauls-robot-army

status:
	gemini extensions list
