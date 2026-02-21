#!/usr/bin/env bash
set -euo pipefail

repo_root="${1:-.}"
cd "$repo_root"

list_or_none() {
  local title="$1"
  shift
  echo "$title"
  if [ "$#" -eq 0 ]; then
    echo "- <none>"
    return
  fi
  local item
  for item in "$@"; do
    echo "- $item"
  done
}

mapfile -t playwright_configs < <(
  find . -type f \( -name 'playwright.config.ts' -o -name 'playwright.config.js' -o -name 'playwright.config.mts' -o -name 'playwright.config.mjs' \) \
    -not -path '*/node_modules/*' \
    | sed 's#^\./##' \
    | sort
)

mapfile -t e2e_dirs < <(
  find . -type d \( -name 'e2e' -o -name 'playwright' -o -name '__e2e__' \) \
    -not -path '*/node_modules/*' \
    | sed 's#^\./##' \
    | sort
)

mapfile -t package_jsons < <(
  find . -type f -name 'package.json' \
    -not -path '*/node_modules/*' \
    | sed 's#^\./##' \
    | sort
)

frontend_roots=()
for pkg in "${package_jsons[@]}"; do
  if grep -Eiq '"(react|next|vue|svelte|angular|@angular/core)"' "$pkg"; then
    frontend_roots+=("$(dirname "$pkg")")
  fi
done

if [ "${#frontend_roots[@]}" -gt 0 ]; then
  mapfile -t frontend_roots < <(printf '%s\n' "${frontend_roots[@]}" | sort -u)
fi

instruction_files=()
for f in AGENTS.md CLAUDE.md docs/02-must-have/testing-strategy.md docs/02-must-have/directory-structure.md; do
  if [ -f "$f" ]; then
    instruction_files+=("$f")
  fi
done

playwright_mentions=()
for f in "${instruction_files[@]}"; do
  if rg -n -i "playwright|e2e" "$f" >/dev/null 2>&1; then
    playwright_mentions+=("$f")
  fi
done

printf 'repo_root: %s\n' "$(pwd)"
printf '\n'
list_or_none "playwright_configs:" "${playwright_configs[@]}"
printf '\n'
list_or_none "frontend_roots:" "${frontend_roots[@]}"
printf '\n'
list_or_none "candidate_e2e_dirs:" "${e2e_dirs[@]}"
printf '\n'
list_or_none "instruction_files:" "${instruction_files[@]}"
printf '\n'
list_or_none "instruction_files_with_playwright_mentions:" "${playwright_mentions[@]}"
printf '\n'

if [ "${#playwright_configs[@]}" -eq 0 ]; then
  echo "gap_signal: missing_playwright_config"
fi
if [ "${#frontend_roots[@]}" -gt 0 ] && [ "${#e2e_dirs[@]}" -eq 0 ]; then
  echo "gap_signal: missing_e2e_directory_convention"
fi
if [ "${#playwright_mentions[@]}" -eq 0 ]; then
  echo "gap_signal: missing_instruction_file_awareness"
fi
