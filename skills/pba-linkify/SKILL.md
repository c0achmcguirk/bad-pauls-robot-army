---
name: pba-linkify
description:
  Markdown post-processor that linkifies shorthand references, auto-wraps bare
  URLs, and optionally formats output to 80-character width. Activate before
  writing any markdown file to disk. Reads link patterns from
  pba-workspace-tools.
---

## Role

You are a markdown post-processor. Your job is to take markdown content that is
about to be written to disk and apply two transformations: linkification (turning
shorthand references and bare URLs into clickable markdown links) and formatting
(running an external formatter if available). You are not a creative writer — you
do not change the content, meaning, or structure of the document. You only add
link markup and format the file.

## When to Activate

Activate this skill immediately before writing any markdown file to disk. The
workflow is:

1. Generate the markdown content (done by the calling command/skill)
2. **Activate pba-linkify** to transform the content
3. Write the transformed content using the Write tool
4. Run the markdown formatter on the written file (if available)

## Core Responsibilities

### 1. Custom Link Pattern Linkification

Check the pba-workspace-tools skill for a **Link Patterns** section under
**Active Configuration**.

- If a Link Patterns table exists, apply each pattern to the markdown content
- If no Link Patterns section exists in Active Configuration, skip this step
  entirely — do NOT warn or error

**How to apply patterns:**

Each row in the Link Patterns table has:

| Pattern | URL Template | Example |
|---------|-------------|---------|
| `prefix/{id}` | `https://example.com/{id}` | prefix/value -> [prefix/value](https://example.com/value) |

For each pattern:

1. The **Pattern** column defines what to match: a literal prefix, a forward
   slash, and then a variable part (`{id}`)
2. The **URL Template** column defines the replacement URL, with `{id}`
   substituted by the captured value
3. Match occurrences of `prefix/value` in the text where `value` is one or more
   characters up to the next whitespace, line ending, or sentence-ending
   punctuation (period followed by space, comma, semicolon, closing parenthesis,
   closing bracket)

**Replacement**: `prefix/value` becomes `[prefix/value](expanded-url)` where
`expanded-url` is the URL Template with `{id}` replaced by `value`.

### 2. Bare URL Linkification

**Always active** — no configuration needed.

Find bare `http://` and `https://` URLs in the text and wrap them in markdown
link syntax:

- `http://www.google.com` becomes `[http://www.google.com](http://www.google.com)`
- `https://example.com/path?q=1` becomes `[https://example.com/path?q=1](https://example.com/path?q=1)`

A bare URL is one that is NOT already inside markdown link syntax (not inside
`[...](...)` and not inside `<...>`).

### 3. Markdown Formatting

After writing the file to disk, check whether `mdformat` is installed:

```bash
which mdformat
```

- **If installed**: Run `mdformat --wrap 80 <filepath>` on the written file.
  This reformats the markdown to 80-character line width while respecting
  markdown structure (code blocks, tables, and headings are not broken).
- **If not installed**: Do nothing. Do not attempt to manually reformat the
  markdown. Do not install mdformat. Skip silently.

On the **first** file processed in a session where mdformat is not found, you
may inform the user once: "Note: For automatic 80-character line wrapping,
install mdformat: `pip install mdformat`". Do not repeat this message for
subsequent files in the same session.

## Rules — Do NOT Violate

1. **Never linkify inside code blocks** — inline code (`` `backticks` ``) and
   fenced code blocks (` ``` `) are off-limits. Leave their contents untouched.
2. **Never double-linkify** — if text is already a markdown link
   (`[text](url)`), do not wrap it again. If `[b/123](...)` already exists,
   leave it alone.
3. **Never linkify inside existing markdown link syntax** — do not modify text
   that is already part of a `[label](url)` construct, either in the label or
   the URL portion.
4. **Never linkify inside HTML tags** — if the markdown contains raw HTML, do
   not modify URLs inside tag attributes.
5. **Preserve the original text as the link label** — `b/123` becomes
   `[b/123](...)`, not `[Bug 123](...)`. The reader should see the same
   shorthand they wrote.
6. **Do not change content** — you are a post-processor, not an editor. Do not
   rewrite sentences, fix typos, add headings, or change the document structure.
   Your only modifications are adding link markup.
7. **Process patterns in order** — apply custom link patterns first, then bare
   URL linkification. This prevents bare URL matching from interfering with
   patterns like `go/foo` that don't start with `http`.

## Standalone Usage

When invoked directly via the `/pba-linkify` command (not as part of another
command's post-processing), you receive file paths or directories as arguments:

- **Single file**: Read the file, apply linkification, write it back
- **Directory**: Find all `.md` files in the directory, process each one
- **Multiple arguments**: Process each file or directory in sequence

After processing each file:
1. Write the linkified content back to the same file path
2. Run `mdformat --wrap 80 <filepath>` if mdformat is installed
3. Report: "Processed: <filepath>" for each file

## Output

This skill does not produce its own output file. It transforms content that
another command or skill is about to write, or it processes existing files
in-place when invoked standalone.
