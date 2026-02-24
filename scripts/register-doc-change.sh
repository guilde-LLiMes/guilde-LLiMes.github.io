#!/usr/bin/env bash
set -euo pipefail

if [[ $# -lt 3 || $# -gt 5 ]]; then
  echo "Usage: $0 <doc-path> <version> <summary> [release] [date]"
  echo "Example: $0 docs/02-must-have/api-contracts.md 0.2.0 \"Clarify backward compatibility\" docs-v0.2.0 2026-03-01"
  exit 1
fi

doc_path="$1"
doc_version="$2"
summary="$3"
release="${4:-unreleased}"
entry_date="${5:-$(date +%F)}"
registry_file="_data/doc-versions.yml"

if [[ ! "$doc_version" =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: version must be SemVer (MAJOR.MINOR.PATCH), got: $doc_version"
  exit 1
fi

if [[ "$release" != "unreleased" && ! "$release" =~ ^docs-v[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Error: release must be 'unreleased' or docs-v<semver>, got: $release"
  exit 1
fi

if [[ ! -f "$doc_path" ]]; then
  echo "Error: document not found: $doc_path"
  exit 1
fi

mkdir -p "$(dirname "$registry_file")"

if [[ ! -f "$registry_file" ]]; then
  cat > "$registry_file" <<'EOF'
# Central document version registry (append-only).
# Add one entry per document update.
entries:
EOF
fi

yaml_escape() {
  printf "%s" "$1" | sed "s/'/''/g"
}

doc_path_escaped="$(yaml_escape "$doc_path")"
doc_version_escaped="$(yaml_escape "$doc_version")"
summary_escaped="$(yaml_escape "$summary")"
release_escaped="$(yaml_escape "$release")"

{
  printf "  - date: %s\n" "$entry_date"
  printf "    doc: '%s'\n" "$doc_path_escaped"
  printf "    version: '%s'\n" "$doc_version_escaped"
  printf "    release: '%s'\n" "$release_escaped"
  printf "    summary: '%s'\n" "$summary_escaped"
} >> "$registry_file"

echo "Added document version entry:"
echo "- date: $entry_date"
echo "- doc: $doc_path"
echo "- version: $doc_version"
echo "- release: $release"
echo "- summary: $summary"
echo
echo "Suggested changelog bullet:"
echo "- $doc_path (v$doc_version): $summary"
