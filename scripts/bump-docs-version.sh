#!/usr/bin/env bash
set -euo pipefail

usage() {
  echo "Usage: $0 [major|minor|patch] [--dry-run]"
  echo "Default bump type: patch"
}

bump_type="patch"
dry_run="false"

for arg in "$@"; do
  case "$arg" in
    major|minor|patch)
      bump_type="$arg"
      ;;
    --dry-run)
      dry_run="true"
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Error: unknown argument: $arg"
      usage
      exit 1
      ;;
  esac
done

config_file="_config.yml"

if [[ ! -f "$config_file" ]]; then
  echo "Error: missing $config_file"
  exit 1
fi

current_version="$(sed -n 's/^docs_version:[[:space:]]*//p' "$config_file" | head -n 1)"

if [[ -z "$current_version" ]]; then
  echo "Error: docs_version not found in $config_file"
  exit 1
fi

if [[ ! "$current_version" =~ ^([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
  echo "Error: docs_version is not valid SemVer: $current_version"
  exit 1
fi

major="${BASH_REMATCH[1]}"
minor="${BASH_REMATCH[2]}"
patch="${BASH_REMATCH[3]}"

case "$bump_type" in
  major)
    major=$((major + 1))
    minor=0
    patch=0
    ;;
  minor)
    minor=$((minor + 1))
    patch=0
    ;;
  patch)
    patch=$((patch + 1))
    ;;
esac

next_version="${major}.${minor}.${patch}"

if [[ "$dry_run" == "false" ]]; then
  tmp_file="$(mktemp "${TMPDIR:-/tmp}/config.XXXXXX")"
  awk -v v="$next_version" '
    BEGIN { updated = 0 }
    /^docs_version:[[:space:]]*/ {
      print "docs_version: " v
      updated = 1
      next
    }
    { print }
    END {
      if (!updated) exit 2
    }
  ' "$config_file" > "$tmp_file"

  mv "$tmp_file" "$config_file"
fi

echo "Current docs_version: $current_version"
echo "Next docs_version: $next_version"
echo "Release tag: docs-v$next_version"
if [[ "$dry_run" == "true" ]]; then
  echo "Mode: dry-run (no file changes)"
else
  echo "Updated file: $config_file"
fi
