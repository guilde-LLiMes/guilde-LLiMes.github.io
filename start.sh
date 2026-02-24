#!/usr/bin/env bash
set -euo pipefail

scripts/build-framework-checklist.rb
bundle exec jekyll serve --livereload --incremental
