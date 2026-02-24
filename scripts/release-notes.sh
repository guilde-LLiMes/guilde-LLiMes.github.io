#!/usr/bin/env bash
set -euo pipefail

from_ref="${1:-}"
to_ref="${2:-HEAD}"

if ! git rev-parse --verify "$to_ref" >/dev/null 2>&1; then
  echo "Error: invalid to_ref: $to_ref"
  exit 1
fi

range_label=""
log_range=""

if [[ -n "$from_ref" ]]; then
  if ! git rev-parse --verify "$from_ref" >/dev/null 2>&1; then
    echo "Error: invalid from_ref: $from_ref"
    exit 1
  fi
  log_range="${from_ref}..${to_ref}"
  range_label="${from_ref}..${to_ref}"
elif git describe --tags --abbrev=0 >/dev/null 2>&1; then
  latest_tag="$(git describe --tags --abbrev=0)"
  log_range="${latest_tag}..${to_ref}"
  range_label="${latest_tag}..${to_ref}"
else
  log_range="${to_ref}"
  range_label="repo-start..${to_ref}"
fi

tmp_dir="$(mktemp -d "${TMPDIR:-/tmp}/release-notes.XXXXXX")"
trap 'rm -rf "$tmp_dir"' EXIT

highlights_file="${tmp_dir}/highlights.txt"
breaking_file="${tmp_dir}/breaking.txt"
docs_file="${tmp_dir}/docs.txt"
followups_file="${tmp_dir}/followups.txt"
files_file="${tmp_dir}/files.txt"
doc_commits_found="0"

touch "$highlights_file" "$breaking_file" "$docs_file" "$followups_file" "$files_file"

is_doc_file() {
  [[ "$1" =~ ^docs/.*\.md$ || "$1" == "README.md" || "$1" == "CONTRIBUTING.md" ]]
}

while IFS=$'\t' read -r sha subject; do
  [[ -z "$subject" ]] && continue

  commit_files="$(git show --pretty="" --name-only "$sha" | sed '/^$/d')"
  has_doc_change="0"
  while IFS= read -r file; do
    if is_doc_file "$file"; then
      has_doc_change="1"
      break
    fi
  done <<< "$commit_files"

  if [[ "$has_doc_change" != "1" ]]; then
    continue
  fi

  doc_commits_found="1"
  lower_subject="$(printf '%s' "$subject" | tr '[:upper:]' '[:lower:]')"

  case "$lower_subject" in
    *breaking*|*!:*)
      printf '%s\n' "$subject" >> "$breaking_file"
      ;;
    feat:*|fix:*|perf:*|refactor:*)
      printf '%s\n' "$subject" >> "$highlights_file"
      ;;
    docs:*|doc:*)
      printf '%s\n' "$subject" >> "$docs_file"
      ;;
    *)
      printf '%s\n' "$subject" >> "$followups_file"
      ;;
  esac
done < <(git log --no-merges --pretty=format:'%H%x09%s' "$log_range")

if [[ "$log_range" == *".."* ]]; then
  git diff --name-only "$log_range" | sed '/^$/d' | while IFS= read -r file; do
    if is_doc_file "$file"; then
      echo "$file"
    fi
  done | sort -u > "$files_file"
else
  git show --pretty="" --name-only "$to_ref" | sed '/^$/d' | while IFS= read -r file; do
    if is_doc_file "$file"; then
      echo "$file"
    fi
  done | sort -u > "$files_file"
fi

print_section() {
  local title="$1"
  local file="$2"
  local max_items="$3"

  printf '### %s\n' "$title"
  if [[ -s "$file" ]]; then
    head -n "$max_items" "$file" | sed 's/^/- /'
  else
    echo "- None."
  fi
  echo
}

echo "## Release Notes (${range_label})"
echo
if [[ "$doc_commits_found" != "1" ]]; then
  echo "_No document changes found in this range (docs/, README.md, CONTRIBUTING.md)._"
  echo
fi
print_section "Highlights" "$highlights_file" 3
print_section "Breaking / Behavior Changes" "$breaking_file" 2
print_section "Doc Updates" "$docs_file" 2
print_section "Follow-ups" "$followups_file" 1
print_section "Files Changed" "$files_file" 8
