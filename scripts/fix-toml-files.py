#!/usr/bin/env python3
"""
Fix TOML files for Gemini CLI compatibility.

Removes Claude Code-specific YAML frontmatter from prompt fields and
replaces {optional_scope} with <args> for Gemini CLI argument handling.
"""

import re
import sys
from pathlib import Path


def fix_toml_content(content: str) -> str:
    """Fix a TOML file's content for Gemini CLI compatibility."""

    # Pattern to match the YAML frontmatter inside the prompt
    # It's between the first """ and starts with ---
    frontmatter_pattern = re.compile(
        r'(prompt\s*=\s*""")\s*---\s*\n'
        r'name:.*?\n'
        r'description:.*?\n'
        r'pattern:.*?\n'
        r'---\s*\n',
        re.DOTALL
    )

    # Remove the frontmatter, keeping the prompt = """ part
    content = frontmatter_pattern.sub(r'\1\n', content)

    # Replace {optional_scope} with <args> for Gemini CLI argument handling
    content = content.replace('{optional_scope}', '<args>')

    return content


def process_file(filepath: Path) -> bool:
    """Process a single TOML file. Returns True if file was modified."""
    try:
        original = filepath.read_text()
        fixed = fix_toml_content(original)

        if original != fixed:
            filepath.write_text(fixed)
            print(f"Fixed: {filepath}")
            return True
        else:
            print(f"No changes needed: {filepath}")
            return False
    except Exception as e:
        print(f"Error processing {filepath}: {e}", file=sys.stderr)
        return False


def main():
    commands_dir = Path(__file__).parent.parent / "commands"

    if not commands_dir.exists():
        print(f"Commands directory not found: {commands_dir}", file=sys.stderr)
        sys.exit(1)

    toml_files = list(commands_dir.rglob("*.toml"))

    if not toml_files:
        print("No TOML files found", file=sys.stderr)
        sys.exit(1)

    print(f"Found {len(toml_files)} TOML files")

    modified_count = 0
    for filepath in toml_files:
        if process_file(filepath):
            modified_count += 1

    print(f"\nSummary: Modified {modified_count} of {len(toml_files)} files")


if __name__ == "__main__":
    main()
