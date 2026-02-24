#!/usr/bin/env bash
#
# rename-and-backup.sh - Rename draft to dated format and create backup
#
# Usage:
#   ./rename-and-backup.sh <source-file> <target-slug>
#   ./rename-and-backup.sh _posts/my-draft.md my-slug
#   ./rename-and-backup.sh _posts/my-draft.md 2026-02-24-my-slug.md
#
# If target-slug doesn't start with date, today's date is prepended.
# Creates .bak backup of the renamed file.
#

set -euo pipefail

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <source-file> <target-slug-or-filename>"
  echo "Examples:"
  echo "  $0 _posts/draft.md my-article-slug"
  echo "  $0 _posts/draft.md 2026-02-24-my-article.md"
  exit 1
fi

SOURCE="$1"
TARGET="$2"

# Verify source exists
if [[ ! -f "$SOURCE" ]]; then
  echo "Error: Source file not found: $SOURCE"
  exit 1
fi

# Get directory
DIR=$(dirname "$SOURCE")

# If target doesn't start with date, add today's date
if [[ ! "$TARGET" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}- ]]; then
  TODAY=$(date +%Y-%m-%d)
  TARGET="${TODAY}-${TARGET}"
fi

# Ensure .md extension
if [[ ! "$TARGET" =~ \.md$ ]]; then
  TARGET="${TARGET}.md"
fi

# Full target path
TARGET_PATH="${DIR}/${TARGET}"

# Check if target already exists
if [[ -f "$TARGET_PATH" ]]; then
  echo "Error: Target already exists: $TARGET_PATH"
  exit 1
fi

# Rename
mv "$SOURCE" "$TARGET_PATH"
echo "Renamed: $SOURCE -> $TARGET_PATH"

# Create backup
cp "${TARGET_PATH}" "${TARGET_PATH}.bak"
echo "Backup:  ${TARGET_PATH}.bak"

# Output the new filename for use in subsequent commands
echo ""
echo "New file: $TARGET_PATH"
