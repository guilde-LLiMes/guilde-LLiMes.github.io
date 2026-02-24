#!/usr/bin/env bash
#
# validate-post.sh - Validate blog post frontmatter
#
# Usage:
#   ./validate-post.sh <post-file>
#
# Output:
#   - Prints missing/invalid fields to stdout
#   - Exit 0 if valid, exit 1 if invalid
#
# Required fields:
#   - title (string, non-empty)
#   - layout (must be "post")
#   - date (YYYY-MM-DD format)
#
# Optional but recommended:
#   - author
#   - tags
#

set -euo pipefail

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <post-file>"
  exit 1
fi

POST="$1"

if [[ ! -f "$POST" ]]; then
  echo "Error: File not found: $POST"
  exit 1
fi

# Check if file is in _posts directory
if [[ ! "$POST" =~ _posts/ ]]; then
  echo "Warning: File is not in _posts/ directory"
fi

# Check filename format (YYYY-MM-DD-slug.md)
FILENAME=$(basename "$POST")
if [[ ! "$FILENAME" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}-.+\.md$ ]]; then
  echo "Error: Filename must match YYYY-MM-DD-slug.md format"
  echo "  Got: $FILENAME"
  exit 1
fi

ERRORS=0
WARNINGS=0

# Extract frontmatter
FRONTMATTER=$(sed -n '/^---$/,/^---$/p' "$POST" | sed '1d;$d')

# Check title
TITLE=$(echo "$FRONTMATTER" | grep '^title:' | sed 's/^title: *//' | tr -d '"')
if [[ -z "$TITLE" ]]; then
  echo "Error: Missing required field 'title'"
  ERRORS=$((ERRORS + 1))
fi

# Check layout
LAYOUT=$(echo "$FRONTMATTER" | grep '^layout:' | sed 's/^layout: *//')
if [[ -z "$LAYOUT" ]]; then
  echo "Error: Missing required field 'layout'"
  ERRORS=$((ERRORS + 1))
elif [[ "$LAYOUT" != "post" ]]; then
  echo "Error: layout must be 'post', got '$LAYOUT'"
  ERRORS=$((ERRORS + 1))
fi

# Check date
DATE=$(echo "$FRONTMATTER" | grep '^date:' | sed 's/^date: *//')
if [[ -z "$DATE" ]]; then
  echo "Error: Missing required field 'date'"
  ERRORS=$((ERRORS + 1))
elif [[ ! "$DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
  echo "Error: date must be YYYY-MM-DD format, got '$DATE'"
  ERRORS=$((ERRORS + 1))
fi

# Check author (recommended)
AUTHOR=$(echo "$FRONTMATTER" | grep '^author:' | sed 's/^author: *//')
if [[ -z "$AUTHOR" ]]; then
  echo "Warning: Missing recommended field 'author'"
  WARNINGS=$((WARNINGS + 1))
fi

# Check tags (recommended)
TAGS=$(echo "$FRONTMATTER" | grep '^tags:' | sed 's/^tags: *//')
if [[ -z "$TAGS" ]]; then
  echo "Warning: Missing recommended field 'tags'"
  WARNINGS=$((WARNINGS + 1))
fi

# Check for excerpt/TL;DR in content (recommended)
if ! grep -qi "tl;dr\|summary\|excerpt" "$POST" 2>/dev/null; then
  echo "Warning: No TL;DR or summary found in content"
  WARNINGS=$((WARNINGS + 1))
fi

# Check for curly quotes in frontmatter (breaks YAML parsing)
# Curly quotes: U+201C (" = e2 80 9c) and U+201D (" = e2 80 9d)
if echo "$FRONTMATTER" | LC_ALL=C grep -q $'\xe2\x80\x9c\|\xe2\x80\x9d'; then
  echo "Error: Curly quotes found in frontmatter (breaks YAML parsing)"
  echo "  Fix: Replace \" and \" with straight \" quotes"
  ERRORS=$((ERRORS + 1))
fi

# Check for curly quotes in content (optional - can cause issues in some contexts)
CONTENT=$(sed -n '/^---$/,/^---$/p' "$POST" | tail -n +2 | sed '1,/^---$/d')
if echo "$CONTENT" | LC_ALL=C grep -q $'\xe2\x80\x9c\|\xe2\x80\x9d'; then
  echo "Warning: Curly quotes found in content (may cause display issues)"
  echo "  Tip: Replace with straight quotes for consistency"
  WARNINGS=$((WARNINGS + 1))
fi

# Summary
echo ""
echo "Validation: $POST"
echo "  Errors: $ERRORS"
echo "  Warnings: $WARNINGS"

if [[ $ERRORS -gt 0 ]]; then
  exit 1
fi

echo "  Status: VALID"
exit 0
