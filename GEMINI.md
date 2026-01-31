# Bad Paul's Robot Army - Global Context

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
│   ├── accessibility-specialist/
│   ├── api-designer/
│   ├── architect/
│   ├── build-master/
│   ├── cloud-developer/
│   ├── code-documentor/
│   ├── code-historian/
│   ├── concurrency-expert/
│   ├── configuration-manager/
│   ├── database-designer/
│   ├── debugger/
│   ├── deployment-specialist/
│   ├── exception-handling-master/
│   ├── logging-master/
│   ├── mentor/
│   ├── performance-optimizer/
│   ├── product-manager/
│   ├── refactorer/
│   ├── security-master/
│   ├── test-automator/
│   └── toolsmith/
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
- Ensure command files have proper YAML frontmatter with name, description, and pattern
- Skill files must have YAML frontmatter with name and description fields
- Test commands and skills locally before committing changes
- Reference skills in commands using natural language (e.g., "Using the architect skill...")

## Installation

Run `make install` to install commands and skills to your Gemini CLI configuration directory.
