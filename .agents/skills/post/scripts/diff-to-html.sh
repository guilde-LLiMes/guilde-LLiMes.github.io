#!/usr/bin/env bash
#
# diff-to-html.sh - Convert diff output to styled HTML
#
# Usage:
#   ./diff-to-html.sh <original-file> <modified-file>
#
# Example:
#   ./diff-to-html.sh _posts/2026-02-24-slug.md.bak _posts/2026-02-24-slug.md
#
# Output: _site/diff/<slug>.html
#
# Exit codes:
#   0 - Success
#   1 - Missing arguments or files not found
#

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <original> <modified>"
  echo "Example: $0 _posts/slug.md.bak _posts/2026-02-24-slug.md"
  exit 1
fi

ORIGINAL="$1"
MODIFIED="$2"

if [[ ! -f "$ORIGINAL" ]]; then
  echo "Error: Original file not found: $ORIGINAL"
  exit 1
fi

if [[ ! -f "$MODIFIED" ]]; then
  echo "Error: Modified file not found: $MODIFIED"
  exit 1
fi

# Extract title from modified file (frontmatter)
TITLE=$(grep -m1 '^title:' "$MODIFIED" | sed 's/^title: *//' | tr -d '"')

# Extract slug from filename (after date)
SLUG=$(basename "$MODIFIED" .md | sed 's/^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}-//')

# Extract date components from filename
YEAR=$(basename "$MODIFIED" | grep -o '^[0-9]\{4\}')
MONTH=$(basename "$MODIFIED" | grep -o '^[0-9]\{4\}-[0-9]\{2\}' | cut -d'-' -f2)
DAY=$(basename "$MODIFIED" | grep -o '^[0-9]\{4\}-[0-9]\{2\}-[0-9]\{2\}' | cut -d'-' -f3)

# Always output to _site/diff/ so Jekyll serves it
mkdir -p _site/diff
OUTPUT="_site/diff/${SLUG}.html"

# Read both files into arrays
mapfile -t ORIG_LINES < "$ORIGINAL"
mapfile -t MOD_LINES < "$MODIFIED"

# Escape HTML entities
escape_html() {
  echo "$1" | sed 's/&/\&amp;/g; s/</\&lt;/g; s/>/\&gt;/g'
}

# Use diff to get change hunks, then build aligned view
# diff -e gives ed script format, we'll parse unified diff instead
DIFF_OUTPUT=$(diff -u "$ORIGINAL" "$MODIFIED" 2>/dev/null || true)

# Parse diff to build aligned rows
DIFF_ROWS=""
orig_idx=0
mod_idx=0
orig_len=${#ORIG_LINES[@]}
mod_len=${#MOD_LINES[@]}

# Simple LCS-based alignment using diff markers
# Build arrays tracking which lines are matched
declare -A orig_matched
declare -A mod_matched

# Process diff hunks to find matched/unmatched lines
while IFS= read -r line; do
  if [[ "$line" =~ ^@@.*@@ ]]; then
    # Hunk header: @@ -orig_start,orig_count +mod_start,mod_count @@
    # Extract starting line numbers
    orig_start=$(echo "$line" | grep -o '\-[0-9]*' | head -1 | tr -d '-')
    mod_start=$(echo "$line" | grep -o '+[0-9]*' | head -1 | tr -d '+')
    orig_hunk_idx=$((orig_start - 1))
    mod_hunk_idx=$((mod_start - 1))
  elif [[ "$line" =~ ^- ]] && [[ ! "$line" =~ ^--- ]]; then
    # Deleted line
    orig_hunk_idx=$((orig_hunk_idx + 1))
  elif [[ "$line" =~ ^\+ ]] && [[ ! "$line" =~ ^\+\+\+ ]]; then
    # Added line
    mod_hunk_idx=$((mod_hunk_idx + 1))
  elif [[ "$line" =~ ^[^+-] ]] && [[ -n "$line" ]]; then
    # Context line - these match
    orig_hunk_idx=$((orig_hunk_idx + 1))
    mod_hunk_idx=$((mod_hunk_idx + 1))
    orig_matched[$orig_hunk_idx]=$mod_hunk_idx
    mod_matched[$mod_hunk_idx]=$orig_hunk_idx
  fi
done <<< "$DIFF_OUTPUT"

# Now build aligned rows
while [[ $orig_idx -lt $orig_len ]] || [[ $mod_idx -lt $mod_len ]]; do
  orig_line="${ORIG_LINES[$orig_idx]:-}"
  mod_line="${MOD_LINES[$mod_idx]:-}"

  # Check if current lines match
  if [[ "$orig_line" == "$mod_line" ]]; then
    # Lines match - show as context
    orig_escaped=$(escape_html "$orig_line")
    mod_escaped=$(escape_html "$mod_line")
    DIFF_ROWS+="<tr><td class=\"num\">$((orig_idx + 1))</td><td class=\"context\">${orig_escaped}</td><td class=\"num\">$((mod_idx + 1))</td><td class=\"context\">${mod_escaped}</td></tr>"$'\n'
    orig_idx=$((orig_idx + 1))
    mod_idx=$((mod_idx + 1))
  elif [[ -z "${orig_matched[$((orig_idx + 1))]:-}" ]] && [[ $orig_idx -lt $orig_len ]]; then
    # Original line has no match - deletion
    orig_escaped=$(escape_html "$orig_line")
    DIFF_ROWS+="<tr><td class=\"num del-num\">$((orig_idx + 1))</td><td class=\"del\">${orig_escaped}</td><td class=\"num\"></td><td class=\"empty\"></td></tr>"$'\n'
    orig_idx=$((orig_idx + 1))
  elif [[ -z "${mod_matched[$((mod_idx + 1))]:-}" ]] && [[ $mod_idx -lt $mod_len ]]; then
    # Modified line has no match - addition
    mod_escaped=$(escape_html "$mod_line")
    DIFF_ROWS+="<tr><td class=\"num\"></td><td class=\"empty\"></td><td class=\"num add-num\">$((mod_idx + 1))</td><td class=\"add\">${mod_escaped}</td></tr>"$'\n'
    mod_idx=$((mod_idx + 1))
  else
    # Both have matches but not to each other - advance the one with lower match
    orig_match="${orig_matched[$((orig_idx + 1))]:-999999}"
    mod_match="${mod_matched[$((mod_idx + 1))]:-999999}"

    if [[ $orig_match -le $mod_idx ]]; then
      # orig matches something ahead in mod, advance mod
      mod_escaped=$(escape_html "$mod_line")
      DIFF_ROWS+="<tr><td class=\"num\"></td><td class=\"empty\"></td><td class=\"num add-num\">$((mod_idx + 1))</td><td class=\"add\">${mod_escaped}</td></tr>"$'\n'
      mod_idx=$((mod_idx + 1))
    else
      # mod matches something ahead in orig, advance orig
      orig_escaped=$(escape_html "$orig_line")
      DIFF_ROWS+="<tr><td class=\"num del-num\">$((orig_idx + 1))</td><td class=\"del\">${orig_escaped}</td><td class=\"num\"></td><td class=\"empty\"></td></tr>"$'\n'
      orig_idx=$((orig_idx + 1))
    fi
  fi
done

# Write HTML output
cat > "$OUTPUT" << EOF
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>Diff: ${TITLE:-Post}</title>
  <style>
    * { box-sizing: border-box; }
    body { font-family: system-ui, sans-serif; max-width: 100%; margin: 0; padding: 1rem; }
    h1 { font-size: 1.25rem; margin: 0 0 0.5rem 0; }
    .meta { color: #666; margin-bottom: 1rem; }
    .diff-wrap { border: 1px solid #d1d5da; border-radius: 6px; overflow: hidden; }
    .diff-header { display: grid; grid-template-columns: 1fr 1fr; background: #f6f8fa; border-bottom: 1px solid #d1d5da; }
    .diff-header span { padding: 0.5rem 0.75rem; font-weight: 600; font-size: 0.8rem; color: #586069; }
    .diff-header span:first-child { border-right: 1px solid #d1d5da; }
    .diff-scroll { overflow: auto; max-height: 80vh; }
    table { width: 100%; border-collapse: collapse; }
    colgroup { display: grid; grid-template-columns: auto 1fr auto 1fr; }
    col:first-child, col:nth-child(3) { width: 3rem; }
    col:nth-child(2), col:nth-child(4) { width: calc(50% - 3rem); }
    td { font-family: ui-monospace, Menlo, monospace; font-size: 0.75rem; padding: 0 0.5rem; vertical-align: top; white-space: pre-wrap; word-break: break-all; border-bottom: 1px solid #eaecef; }
    td.num { color: #bbb; text-align: right; background: #fafbfc; user-select: none; border-right: 1px solid #eaecef; }
    td:nth-child(2) { border-right: 1px solid #eaecef; }
    .add { background: #e6ffec; }
    .add-num { background: #ccffd8; }
    .del { background: #ffebe9; }
    .del-num { background: #ffd7d5; }
    .context { background: #fff; }
    .empty { background: #fafbfc; color: #959da5; }
    a { color: #0366d6; }
  </style>
</head>
<body>
  <h1>Side-by-Side Diff: ${TITLE:-Post}</h1>
  <p class="meta">
    <a href="http://localhost:4000/posts/${YEAR}/${MONTH}/${DAY}/${SLUG}/">View published post</a>
  </p>
  <div class="diff-wrap">
    <div class="diff-header">
      <span>Original (.bak)</span>
      <span>Modified</span>
    </div>
    <div class="diff-scroll">
      <table>
        <colgroup>
          <col><col><col><col>
        </colgroup>
        ${DIFF_ROWS}
      </table>
    </div>
  </div>
</body>
</html>
EOF

echo "Created: $OUTPUT"
echo "URL: http://localhost:4000/diff/${SLUG}.html"
