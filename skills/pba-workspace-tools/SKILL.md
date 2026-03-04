---
name: pba-workspace-tools
description: Workspace-specific tool mappings - customize this for your organization
---

# Workspace Tools Configuration

**CUSTOMIZE THIS FILE** for your organization's tools and workflows.
Commands consult this skill to determine which tools to use.

---

## Active Configuration

Commands will use ONLY the tools listed in this section.

### Source Control: Git

| Capability | Tool | Notes |
|------------|------|-------|
| diff_uncommitted | `git diff` | View uncommitted changes |
| diff_staged | `git diff --staged` | View staged changes |
| log | `git log` | View commit history |
| log_file | `git log --follow -- {file}` | Track file history |
| blame | `git blame {file}` | Line-by-line authorship |
| status | `git status` | Working tree status |

### Issue Tracking: GitHub

| Capability | Tool | Notes |
|------------|------|-------|
| reference_format | `#{number}` | How issues are referenced in text |
| fetch_issue | `gh issue view {id}` | Get issue details |
| create_issue | `gh issue create` | Create new issue |
| list_issues | `gh issue list` | List issues |
| search_issues | `gh issue list --search "{query}"` | Search issues |
| availability_check | `gh auth status` | Check if available |

### Change Requests: GitHub Pull Requests

| Capability | Tool | Notes |
|------------|------|-------|
| reference_format | `PR #{number}` | How PRs are referenced |
| view | `gh pr view {id}` | View PR details |
| diff | `gh pr diff {id}` | View PR diff |
| create | `gh pr create` | Create PR |
| list | `gh pr list` | List PRs |

---

## Fallback Behavior

When a command references a capability NOT listed in Active Configuration:

1. Do NOT guess or hallucinate tool names
2. Do NOT try alternative approaches
3. Inform the user: "The [capability_name] capability is not configured. To enable it, add it to your pba-workspace-tools skill."
4. Continue with other parts of the command if possible
5. For issue tracking, fall back to local `/issues/{number}.md` files

---

## Templates (NOT ACTIVE)

These are TEMPLATES ONLY. They are NOT active.
To use one, COPY it to the Active Configuration section above and customize.

### Source Control: Mercurial/Fig (TEMPLATE)

| Capability | Tool | Notes |
|------------|------|-------|
| diff_uncommitted | `hg_diff` (MCP tool) | View uncommitted changes |
| diff_staged | *not applicable* | Mercurial has no staging |
| log | `hg log` | View changeset history |
| log_file | `hg log --follow {file}` | Track file history |
| blame | `hg annotate -u -d {file}` | Line-by-line authorship |
| status | `hg status` | Working tree status |

### Source Control: Perforce (TEMPLATE)

| Capability | Tool | Notes |
|------------|------|-------|
| diff_uncommitted | `p4 diff` | View uncommitted changes |
| log | `p4 changes` | View changelist history |
| log_file | `p4 filelog {file}` | Track file history |
| blame | `p4 annotate {file}` | Line-by-line authorship |
| status | `p4 status` | Working tree status |

### Issue Tracking: Internal Issue Tracker (TEMPLATE)

| Capability | Tool | Notes |
|------------|------|-------|
| reference_format | `b/{number}` | Bug/ticket format |
| fetch_issue | `render_issue_tracker_item` (MCP) | Get issue details |
| create_issue | `create_bug` (MCP) | Create new bug |
| list_issues | `list_bugs` (MCP) | List bugs |
| search_issues | `search_bugs` (MCP) | Search bugs |
| availability_check | *always available* | Assume available |

### Issue Tracking: Jira (TEMPLATE)

| Capability | Tool | Notes |
|------------|------|-------|
| reference_format | `{PROJECT}-{number}` | Jira issue format |
| fetch_issue | `jira issue view {id}` | Get issue details |
| create_issue | `jira issue create` | Create new issue |
| list_issues | `jira issue list` | List issues |
| search_issues | `jira issue search "{query}"` | Search issues |

### Issue Tracking: Linear (TEMPLATE)

| Capability | Tool | Notes |
|------------|------|-------|
| reference_format | `{TEAM}-{number}` | Linear issue format |
| fetch_issue | `linear issue view {id}` | Get issue details |
| create_issue | `linear issue create` | Create new issue |
| list_issues | `linear issue list` | List issues |

### Change Requests: Gerrit (TEMPLATE)

| Capability | Tool | Notes |
|------------|------|-------|
| reference_format | `CL/{number}` | Change list format |
| view | `gerrit_view` (MCP) | View CL details |
| diff | `gerrit_diff` (MCP) | View CL diff |
| create | `gerrit_upload` (MCP) | Upload for review |

### Change Requests: Phabricator (TEMPLATE)

| Capability | Tool | Notes |
|------------|------|-------|
| reference_format | `D{number}` | Differential format |
| view | `arc diff --preview` | View diff details |
| create | `arc diff` | Create differential |

### Knowledge Base: Internal Search (TEMPLATE)

When searching internal knowledge, use these tools based on query type:

| Tool | Use For | Notes |
|------|---------|-------|
| `search_intranet` | Company policies, announcements, org structure | Official company info |
| `search_wiki` | Technical docs, how-tos, architecture | Engineering questions |
| `search_data_store` | Data schemas, metrics, tables | Data/analytics questions |

**Search strategy**:
- Broad questions: Try `search_intranet` first
- Technical questions: Prefer `search_wiki`
- Data questions: Start with `search_data_store`
- Comprehensive answers: Query multiple tools and synthesize

### Code Search: Internal (TEMPLATE)

| Tool | Use For | Parameters |
|------|---------|------------|
| `codesearch` | Find code by pattern | `query`, `lang`, `repo` |
| `cs_symbols` | Find function/class definitions | `symbol_name`, `type` |
| `cs_refs` | Find references to a symbol | `symbol`, `include_tests` |

**Guidance**:
- To find definitions: Use `cs_symbols`
- To find usages: Use `cs_refs`
- General text search: Use `codesearch`

### Documentation: Internal Docs (TEMPLATE)

| Capability | Tool | Notes |
|------------|------|-------|
| search | `search_docs` (MCP) | Search internal documentation |
| fetch | `render_doc` (MCP) | Render a specific doc |
| create | `create_doc` (MCP) | Create new documentation |

### Calendar: Google Calendar via gcalcli (TEMPLATE)

Used by `/pba-meeting-prep` to look up upcoming meetings and fetch event details.

| Capability | Tool | Notes |
|------------|------|-------|
| list_upcoming | `gcalcli agenda "now" "1 week" --tsv` | List events in the next 7 days (tab-separated) |
| get_event | `gcalcli calinfo "{title}"` | Get full event details including description and attendees |
| search_events | `gcalcli agenda --tsv "{query}"` | Search events by keyword |

**Notes**:
- Requires `gcalcli` installed and authenticated: `pip install gcalcli && gcalcli init`
- Event descriptions often contain attached document URLs — parse them from the description text
- For other calendar systems (Outlook, internal), replace with your calendar CLI or MCP tool

### People Directory (TEMPLATE)

Used by `/pba-meeting-prep` and `/pba-kudos` to look up attendee titles and team information.

| Capability | Tool | Notes |
|------------|------|-------|
| lookup_person | `lookup_person` (MCP) | Look up a person by name or email — returns title, team, department |
| search_people | `search_people` (MCP) | Search directory by name, team, or keyword |

**Notes**:
- Replace `lookup_person` and `search_people` with your organization's people directory MCP tool names
- If no people directory is available, commands fall back to web search and source control activity

### Email Search (TEMPLATE)

Used by `/pba-meeting-prep` to find relevant email threads related to a meeting topic.

| Capability | Tool | Notes |
|------------|------|-------|
| search_email | `search_email` (MCP) | Search email threads by keyword, sender, or date range |
| get_thread | `get_thread` (MCP) | Fetch a specific email thread by ID or subject |

**Notes**:
- Replace `search_email` and `get_thread` with your email MCP tool names (e.g., Gmail MCP, Outlook MCP)
- If not configured, meeting prep commands skip email search and note it in Sources Consulted

### Link Patterns (TEMPLATE)

These are TEMPLATES ONLY. They are NOT active.
To use, COPY this section to the Active Configuration area above and customize
with your organization's URL patterns.

Configure shorthand link patterns that appear in documents. Each row maps a
prefix pattern to a full URL. Use `{id}` as the placeholder for the variable
part that follows the prefix slash.

| Pattern | URL Template | Example |
|---------|-------------|---------|
| `b/{id}` | `http://bugsystem.corp.somesite.com/bugs/{id}` | b/123 -> [b/123](http://bugsystem.corp.somesite.com/bugs/123) |
| `go/{id}` | `http://go/{id}` | go/foo-bar -> [go/foo-bar](http://go/foo-bar) |
| `jira/{id}` | `https://jira.onsitehost.corp.com/{id}` | jira/84 -> [jira/84](https://jira.onsitehost.corp.com/84) |
| `cl/{id}` | `https://critique.corp.somesite.com/{id}` | cl/456789 -> [cl/456789](https://critique.corp.somesite.com/456789) |
