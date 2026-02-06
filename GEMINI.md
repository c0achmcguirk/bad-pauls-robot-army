# Poliver's Bot Army - Global Context

This file provides guidance to Gemini CLI when working with code in this repository.

## Repository Overview

This repository serves as a collection of Gemini CLI artifacts including:
- **Skills**: Specialized AI skills for various development tasks
- **Commands**: Slash commands for common operations

## Project Structure

```
/
├── README.md              # Repository documentation
├── GEMINI.md              # This file (global context for Gemini CLI)
├── settings.json          # Gemini CLI settings
├── Makefile               # Build and install automation
├── setup.sh               # Initial setup script
├── commands/              # Slash command definitions (.toml files)
│   ├── arch/              # Architecture review commands
│   └── ops/               # Operations/DevOps commands
├── skills/                # Skill definitions (SKILL.md files)
│   ├── pba-accessibility-specialist/
│   ├── pba-api-designer/
│   ├── pba-architect/
│   ├── pba-build-master/
│   ├── pba-cloud-developer/
│   ├── pba-code-documentor/
│   ├── pba-code-historian/
│   ├── pba-concurrency-expert/
│   ├── pba-configuration-manager/
│   ├── pba-database-designer/
│   ├── pba-debugger/
│   ├── pba-deployment-specialist/
│   ├── pba-exception-handling-master/
│   ├── pba-logging-master/
│   ├── pba-mentor/
│   ├── pba-performance-optimizer/
│   ├── pba-product-manager/
│   ├── pba-refactorer/
│   ├── pba-security-master/
│   ├── pba-test-automator/
│   └── pba-toolsmith/
└── scripts/               # Installation and utility scripts
```

## Development Notes

As this is a repository for Gemini CLI artifacts rather than a traditional software project, there are no build, test, or lint commands. When adding new artifacts:

1. Place command definitions in the `commands/` directory as `.toml` files
2. Place skill definitions in `skills/{skill-name}/SKILL.md`
3. Follow existing naming conventions
4. Document each artifact's purpose and usage in its respective file

## Working with Artifacts

When creating or modifying Gemini CLI artifacts in this repository:
- Command files use TOML format with `description` and `prompt` fields
- Use `<args>` placeholder in prompts to capture user arguments
- Skill files must have YAML frontmatter with name and description fields
- Test commands and skills locally before committing changes
- Reference skills in commands using natural language (e.g., "Using the architect skill...")

## Installation

Run `make install` to install commands and skills to your Gemini CLI configuration directory.
