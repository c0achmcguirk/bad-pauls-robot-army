# Bad Paul's Robot Army

Your elite development force - a comprehensive suite of specialized AI skills
and commands for Gemini CLI that supercharge your development workflow. This
extension brazenly steals the work of Dave Griffith's
[bad-daves-robot-army](https://github.com/dgriffith/bad-daves-robot-army)
designed for Claude Code. If you love it as much as I do, support his work on
[Substack](https://davegriffith.substack.com/).

## Quick Start

Install directly from GitHub:

```bash
gemini extensions install <github-url>
```

Or for local development:

```bash
git clone <repo-url>
cd bad-pauls-robot-army
make install
```

After installation, restart Gemini CLI to access your new Robot Army.

## What's Inside

This extension includes **42 commands** and **29 specialized skills** organized
into:

- **Review & Analysis Commands**: Accessibility, API, architecture, database,
  concurrency, documentation, and more.
- **Code Intelligence Commands**: History analysis, evolution tracking, codebase
  understanding, pattern consistency, and impact analysis.
- **Development Workflow Commands**: PRD creation, issue decomposition,
  implementation planning, and scoping documents.
- **Operations Commands**: Build, deployment, cloud, configuration, and tooling
  reviews.
- **29 Specialized Skills**: Including architect, mentor, debugger,
  security-master, and more.

Run `/pba-bad-pauls-robot-army` in Gemini CLI for the full command reference.

## Organizational Customization

This toolkit is designed to work with different source control systems, issue
trackers, and internal tools. All tool mappings are configured in a single skill
file: `skills/pba-workspace-tools/SKILL.md`.

### Quick Setup

1. After installation, edit
   `~/.gemini/extensions/bad-pauls-robot-army/skills/pba-workspace-tools/SKILL.md`
2. The file has two sections:
   - **Active Configuration**: Tools that commands will actually use
   - **Templates (NOT ACTIVE)**: Examples you can copy and customize

### Example: Switching to Mercurial + Internal Issue Tracker

1. In the `workspace-tools/SKILL.md` file, replace the "Source Control: Git"
   section with the "Source Control: Mercurial/Fig" template
2. Replace the "Issue Tracking: GitHub" section with the "Issue Tracking:
   Internal Issue Tracker" template
3. Customize the tool names to match your MCP tools

### What You Can Configure

| Capability      | Default                     | Example Alternatives             |
| --------------- | --------------------------- | -------------------------------- |
| Source Control  | Git (`git diff`, `git log`) | Mercurial, Perforce              |
| Issue Tracking  | GitHub (`gh issue view`)    | Jira, Internal (`b/123`), Linear |
| Change Requests | GitHub PRs                  | Gerrit CLs, Phabricator          |
| Knowledge Base  | Not configured              | Internal search tools            |
| Code Search     | Not configured              | Internal code search             |

### Graceful Degradation

When a capability isn't configured:

- Commands will NOT hallucinate alternative tools
- Users receive a clear message about what's missing
- Commands continue with available capabilities
- For issue tracking, falls back to local `/issues/` files

For detailed instructions, see `skills/pba-workspace-tools/SKILL.md`.

## Migration from Manual Install

If you previously installed using `make install` with the old copy-based
scripts, remove the old files first:

```bash
# Remove old pba-* files from ~/.gemini/commands/ and ~/.gemini/skills/
rm ~/.gemini/commands/pba-*.toml
rm -rf ~/.gemini/skills/pba-*/
```

Then install as an extension using the Quick Start instructions above.

## License

This project is licensed under the Apache License 2.0 - see the
[LICENSE](LICENSE) file for details.

---

**Welcome to Bad Paul's Robot Army, Commander. Your forces await your orders!**
