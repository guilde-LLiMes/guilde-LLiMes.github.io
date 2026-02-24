#!/usr/bin/env bash
#
# discover-drafts.sh - Find blog post drafts that need processing
#
# Usage:
#   ./discover-drafts.sh
#
# Output:
#   Lists draft files (undated or uncommitted) that need processing
#   Exit 0 if drafts found, exit 1 if none
#

set -euo pipefail

POSTS_DIR="_posts"
FOUND=0

echo "=== Discovering Drafts ==="
echo ""

# Check for files without date prefix
echo "Files without date prefix (YYYY-MM-DD-*.md):"
for f in "$POSTS_DIR"/*.md; do
  [[ -f "$f" ]] || continue
  filename=$(basename "$f")
  if [[ ! "$filename" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}- ]]; then
    echo "  $f"
    FOUND=1
  fi
done

if [[ $FOUND -eq 0 ]]; then
  echo "  (none)"
fi

echo ""

# Check for uncommitted changes
echo "Uncommitted changes in _posts/:"
if git diff --name-only HEAD -- "$POSTS_DIR/" 2>/dev/null | grep -q .; then
  git diff --name-only HEAD -- "$POSTS_DIR/"
  FOUND=1
else
  echo "  (none)"
fi

echo ""

# Check for untracked files
echo "Untracked files in _posts/:"
if git ls-files --others --exclude-standard "$POSTS_DIR/" 2>/dev/null | grep -q .; then
  git ls-files --others --exclude-standard "$POSTS_DIR/"
  FOUND=1
else
  echo "  (none)"
fi

echo ""

if [[ $FOUND -eq 1 ]]; then
  echo "Status: Drafts found"
  exit 0
else
  echo "Status: No drafts to process"
  exit 1
fi
