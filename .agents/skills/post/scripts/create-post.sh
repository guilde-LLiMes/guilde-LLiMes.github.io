#!/usr/bin/env bash
#
# create-post.sh - Create a new Jekyll blog post with proper frontmatter
#
# Usage:
#   ./create-post.sh "Your Post Title Here" [options]
#
# Options:
#   -a, --author <name>    Author name (default: kirby)
#   -t, --tags <tags>      Comma-separated tags (default: draft)
#   -d, --date <date>      Date in YYYY-MM-DD format (default: today)
#   -o, --open             Open the file for editing after creation
#   -e, --editor <editor>  Editor to use (default: $EDITOR or code)
#   -s, --slug <slug>      Custom slug (default: generated from title)
#   -h, --help             Show this help message
#
# Examples:
#   ./create-post.sh "How to Write Better Guidelines"
#   ./create-post.sh "Announcing v2.0" -a alice -t announcement,release
#   ./create-post.sh "My Post" -d 2026-03-15 -o
#
# Output:
#   Creates _posts/YYYY-MM-DD-slug.md with frontmatter
#   Prints the file path on success
#

set -euo pipefail

# Default values
DEFAULT_AUTHOR="kirby"
DEFAULT_TAGS="draft"
DEFAULT_EDITOR="${EDITOR:-code}"
POSTS_DIR="_posts"

# Initialize variables
TITLE=""
AUTHOR="$DEFAULT_AUTHOR"
TAGS="$DEFAULT_TAGS"
DATE=""
OPEN_FILE=false
EDITOR_CMD="$DEFAULT_EDITOR"
CUSTOM_SLUG=""

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# Help function
show_help() {
  sed -n '/^# Usage:/,/^$/p' "$0" | sed 's/^# //'
  exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    -h|--help)
      show_help
      ;;
    -a|--author)
      AUTHOR="$2"
      shift 2
      ;;
    -t|--tags)
      TAGS="$2"
      shift 2
      ;;
    -d|--date)
      DATE="$2"
      shift 2
      ;;
    -o|--open)
      OPEN_FILE=true
      shift
      ;;
    -e|--editor)
      EDITOR_CMD="$2"
      shift 2
      ;;
    -s|--slug)
      CUSTOM_SLUG="$2"
      shift 2
      ;;
    -*)
      echo -e "${RED}Error: Unknown option $1${NC}" >&2
      exit 1
      ;;
    *)
      if [[ -z "$TITLE" ]]; then
        TITLE="$1"
      else
        echo -e "${RED}Error: Title already set. Unknown argument: $1${NC}" >&2
        exit 1
      fi
      shift
      ;;
  esac
done

# Validate required arguments
if [[ -z "$TITLE" ]]; then
  echo -e "${RED}Error: Title is required${NC}" >&2
  echo "Usage: $0 \"Your Post Title\" [options]" >&2
  echo "Run '$0 --help' for more information" >&2
  exit 1
fi

# Generate slug from title
generate_slug() {
  local title="$1"
  # Convert to lowercase
  # Replace spaces and special chars with hyphens
  # Remove consecutive hyphens
  # Remove leading/trailing hyphens
  echo "$title" | \
    tr '[:upper:]' '[:lower:]' | \
    sed 's/[^a-z0-9]/-/g' | \
    sed 's/--*/-/g' | \
    sed 's/^-//' | \
    sed 's/-$//'
}

# Use custom slug or generate from title
if [[ -n "$CUSTOM_SLUG" ]]; then
  SLUG="$CUSTOM_SLUG"
else
  SLUG=$(generate_slug "$TITLE")
fi

# Validate slug
if [[ -z "$SLUG" ]]; then
  echo -e "${RED}Error: Could not generate slug from title${NC}" >&2
  exit 1
fi

# Set date (default to today)
if [[ -z "$DATE" ]]; then
  DATE=$(date +%Y-%m-%d)
fi

# Validate date format
if [[ ! "$DATE" =~ ^[0-9]{4}-[0-9]{2}-[0-9]{2}$ ]]; then
  echo -e "${RED}Error: Invalid date format. Use YYYY-MM-DD${NC}" >&2
  exit 1
fi

# Ensure _posts directory exists
if [[ ! -d "$POSTS_DIR" ]]; then
  echo -e "${YELLOW}Creating $POSTS_DIR directory...${NC}"
  mkdir -p "$POSTS_DIR"
fi

# Build filename and path
FILENAME="${DATE}-${SLUG}.md"
FILEPATH="${POSTS_DIR}/${FILENAME}"

# Check if file already exists
if [[ -f "$FILEPATH" ]]; then
  echo -e "${RED}Error: File already exists: $FILEPATH${NC}" >&2
  echo "Use a different date, title, or specify a custom slug with -s" >&2
  exit 1
fi

# Format tags as YAML array
# Convert comma-separated to YAML array format
format_tags() {
  local tags="$1"
  # Remove spaces around commas, then format as YAML array
  echo "$tags" | \
    sed 's/, */, /g' | \
    sed 's/^/[/' | \
    sed 's/$/]/'
}

TAGS_FORMATTED=$(format_tags "$TAGS")

# Create frontmatter and content
cat > "$FILEPATH" << EOF
---
title: "${TITLE}"
layout: post
date: ${DATE}
author: ${AUTHOR}
tags: ${TAGS_FORMATTED}
---

**TL;DR:** [One-sentence summary of the post]

---

[Your content here]

## Section Heading

Content goes here...
EOF

echo -e "${GREEN}Created: $FILEPATH${NC}"
echo ""
echo "Frontmatter:"
echo "  title:  \"$TITLE\""
echo "  date:   $DATE"
echo "  author: $AUTHOR"
echo "  tags:   $TAGS_FORMATTED"
echo "  slug:   $SLUG"
echo ""

# Open file if requested
if [[ "$OPEN_FILE" == true ]]; then
  echo "Opening in $EDITOR_CMD..."
  $EDITOR_CMD "$FILEPATH"
fi

# Output just the path for easy capture by scripts
echo "File: $FILEPATH"
