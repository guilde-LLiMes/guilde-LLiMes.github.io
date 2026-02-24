#!/usr/bin/env bash
set -euo pipefail

registry_file="_data/doc-versions.yml"
entry_date="${1:-$(date +%F)}"
release="${2:-unreleased}"
summary="${3:-Bulk docs version bump (+1)}"

if [[ ! -f "$registry_file" ]]; then
  echo "Error: missing $registry_file"
  exit 1
fi

if [[ "$release" != "unreleased" && ! "$release" =~ ^[0-9]{4}\.[0-9]{2}$ ]]; then
  echo "Error: release must be 'unreleased' or YYYY.MM, got: $release"
  exit 1
fi

yaml_escape() {
  printf "%s" "$1" | sed "s/'/''/g"
}

extract_last_int() {
  local raw="$1"
  local digits
  digits="$(printf "%s" "$raw" | sed -n 's/.*\([0-9][0-9]*\)$/\1/p')"
  if [[ -z "$digits" ]]; then
    echo "0"
  else
    echo "$digits"
  fi
}

next_version_for_doc() {
  local doc="$1"
  local last_version
  local current_int

  last_version="$(awk -v d="$doc" '
    $1 == "doc:" {
      gsub(/\047/, "", $2);
      current_doc = $2;
    }
    $1 == "version:" {
      gsub(/\047/, "", $2);
      if (current_doc == d) {
        v = $2;
      } else if (current_doc == "docs/**" && d ~ /^docs\// && v == "") {
        fallback = $2;
      }
    }
    END {
      if (v != "") print v;
      else if (fallback != "") print fallback;
    }
  ' "$registry_file")"

  current_int="$(extract_last_int "$last_version")"
  echo "v$((current_int + 1))"
}

mapfile -t docs_files < <(find docs -type f -name '*.md' | sort)
docs_files+=("README.md" "CONTRIBUTING.md")

for doc in "${docs_files[@]}"; do
  if [[ ! -f "$doc" ]]; then
    echo "Skip missing file: $doc"
    continue
  fi

  next_version="$(next_version_for_doc "$doc")"
  doc_escaped="$(yaml_escape "$doc")"
  version_escaped="$(yaml_escape "$next_version")"
  release_escaped="$(yaml_escape "$release")"
  summary_escaped="$(yaml_escape "$summary")"

  {
    printf "  - date: %s\n" "$entry_date"
    printf "    doc: '%s'\n" "$doc_escaped"
    printf "    version: '%s'\n" "$version_escaped"
    printf "    release: '%s'\n" "$release_escaped"
    printf "    summary: '%s'\n" "$summary_escaped"
  } >> "$registry_file"

  echo "$doc -> $next_version"
done
