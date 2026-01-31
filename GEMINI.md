# Bad Paul's Robot Army - Global Context

This file provides guidance to Gemini Code (gemini.google.com) when working with code in this repository.

## Repository Overview

This repository serves as a collection of Gemini Code artifacts including:
- Subagents: Custom agents for specialized tasks
- Slash commands: Quick commands for common operations
- Hooks: Automated actions triggered by events

## Project Structure

```
/
├── README.md              # Repository documentation
├── subagents/            # Directory for subagent definitions
└── GEMINI.md            # This file
```

## Development Notes

As this is a repository for Gemini Code artifacts rather than a traditional software project, there are no build, test, or lint commands. When adding new artifacts:

1. Place subagent definitions in the `subagents/` directory
2. Follow existing naming conventions if any are established
3. Document each artifact's purpose and usage in its respective file

## Working with Artifacts

When creating or modifying Gemini Code artifacts in this repository:
- Ensure artifact files are properly formatted as Markdown
- Include clear documentation within each artifact file
- Test artifacts locally before committing changes
