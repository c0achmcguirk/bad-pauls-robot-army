# Bad Paul's Robot Army - Global Context

This file provides guidance to Gemini CLI when working with code in this repository.

## Repository Overview

This repository is a Gemini CLI extension providing:
- **Skills**: Specialized AI skills for various development tasks
- **Commands**: Slash commands for common operations

## Project Structure

```
/
├── README.md              # Repository documentation
├── GEMINI.md              # This file (global context for Gemini CLI)
├── gemini-extension.json  # Extension manifest
├── settings.json.example  # Example Gemini CLI settings
├── Makefile               # Extension install/uninstall shortcuts
├── commands/              # Slash command definitions (.toml files)
├── skills/                # Skill definitions (SKILL.md files)
│   ├── pba-accessibility-specialist/
│   ├── pba-api-designer/
│   ├── pba-architect/
│   ├── pba-build-master/
│   ├── pba-cloud-developer/
│   ├── pba-code-documentor/
│   ├── pba-code-historian/
│   ├── pba-code-modernizer/
│   ├── pba-concurrency-expert/
│   ├── pba-configuration-manager/
│   ├── pba-database-designer/
│   ├── pba-debugger/
│   ├── pba-deployment-specialist/
│   ├── pba-development-manager/
│   ├── pba-exception-handling-master/
│   ├── pba-impact-reporter/
│   ├── pba-internationalization-specialist/
│   ├── pba-launch-announcer/
│   ├── pba-logging-master/
│   ├── pba-mentor/
│   ├── pba-performance-optimizer/
│   ├── pba-product-manager/
│   ├── pba-quality-assurance-expert/
│   ├── pba-refactorer/
│   ├── pba-security-master/
│   ├── pba-technical-reviewer/
│   ├── pba-technical-scoper/
│   ├── pba-test-automator/
│   ├── pba-toolsmith/
│   └── pba-workspace-tools/
└── scripts/               # Development utility scripts
```

## Development Notes

As this is a repository for Gemini CLI artifacts rather than a traditional software project, there are no build, test, or lint commands. When adding new artifacts:

1. Place command definitions in the `commands/` directory as `.toml` files
2. Place skill definitions in `skills/{skill-name}/SKILL.md`
3. Follow existing naming conventions (use `pba-` prefix)
4. Document each artifact's purpose and usage in its respective file

## Working with Artifacts

When creating or modifying Gemini CLI artifacts in this repository:
- Command files use TOML format with `description` and `prompt` fields
- Use `<args>` placeholder in prompts to capture user arguments
- Skill files must have YAML frontmatter with name and description fields
- Test commands and skills locally before committing changes
- Reference skills in commands using natural language (e.g., "Using the architect skill...")

## Installation

Run `gemini extensions link .` to link this extension for local development.
