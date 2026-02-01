# Bad Paul's Robot Army

Your elite development force - a comprehensive suite of specialized AI skills and commands for Gemini CLI that supercharge your development workflow.

## 🚀 Quick Start

**New to the Robot Army?** This collection of tools provides powerful, skill-based capabilities directly in your command line.

**Ready to deploy?** Install the commands and skills:

```bash
# 1. Run the one-time setup script
make setup

# 2. Install the commands and skills
make install
```

After installation, restart Gemini CLI to access your new Robot Army.

## 🎯 What's Inside

This repository includes **18 commands** and **21 specialized skills** organized into:

-   **Review & Analysis Commands**: Accessibility, API, database, concurrency, and documentation audits.
-   **Code Intelligence Commands**: History analysis, evolution tracking, and codebase understanding.
-   **Development Workflow Commands**: PRD creation and issue decomposition.
-   **Operations Commands**: Build, deployment, cloud, configuration, and tooling reviews.
-   **21 Specialized Skills**: Including architect, mentor, debugger, security-master, and more.

## Organizational Customization

This toolkit is designed to work with different source control systems, issue trackers, and internal tools. All tool mappings are configured in a single skill file: `skills/workspace-tools/SKILL.md`.

### Quick Setup

1. After installation, edit `~/.gemini-cli/skills/workspace-tools/SKILL.md`
2. The file has two sections:
   - **Active Configuration**: Tools that commands will actually use
   - **Templates (NOT ACTIVE)**: Examples you can copy and customize

### Example: Switching to Mercurial + Internal Issue Tracker

1. In the `workspace-tools/SKILL.md` file, replace the "Source Control: Git" section with the "Source Control: Mercurial/Fig" template
2. Replace the "Issue Tracking: GitHub" section with the "Issue Tracking: Internal Issue Tracker" template
3. Customize the tool names to match your MCP tools

### What You Can Configure

| Capability | Default | Example Alternatives |
|------------|---------|---------------------|
| Source Control | Git (`git diff`, `git log`) | Mercurial, Perforce |
| Issue Tracking | GitHub (`gh issue view`) | Jira, Internal (`b/123`), Linear |
| Change Requests | GitHub PRs | Gerrit CLs, Phabricator |
| Knowledge Base | Not configured | Internal search tools |
| Code Search | Not configured | Internal code search |

### Graceful Degradation

When a capability isn't configured:
- Commands will NOT hallucinate alternative tools
- Users receive a clear message about what's missing
- Commands continue with available capabilities
- For issue tracking, falls back to local `/issues/` files

For detailed instructions, see `skills/workspace-tools/SKILL.md`.

##  License

This project is licensed under the Apache License 2.0 - see the [LICENSE](LICENSE) file for details.

## 🛠️ Installation Tooling

This repository includes tooling for installing the commands and skills into your Gemini CLI configuration directory (`~/.gemini-cli/`).

### Quick Start

```bash
# Run this first to make scripts executable
make setup

# Install everything to ~/.gemini-cli/
make install

# To see what would be installed without changing files
make dry-run

# To overwrite existing files without being asked
make install-force
```

### The Install Script

The core logic is in `scripts/install.sh`. It intelligently copies the command (`.toml`) and skill files from this repository to the correct locations in your `~/.gemini-cli` directory.

### Safety Features

-   **Confirmation Prompts**: The script will ask before overwriting any files that have been modified.
-   **Dry-run Mode**: Use `make dry-run` to see a preview of all actions without making any changes.
-   **Force Mode**: Use `make install-force` to bypass prompts and overwrite existing files, useful for CI/CD or fresh installs.

---

**Welcome to Bad Paul's Robot Army, Commander. Your forces await your orders!** 🫡
