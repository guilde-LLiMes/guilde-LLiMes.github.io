#!/usr/bin/env ruby
# frozen_string_literal: true

require 'yaml'

ROOT = File.expand_path('..', __dir__)
GENERATED_PATH = File.join(ROOT, '_data', 'framework-checklist.generated.yml')
REQUIRED_AREAS_PATH = File.join(ROOT, '_data', 'framework-checklist.required-audit-areas.yml')

unless File.exist?(GENERATED_PATH)
  warn "Missing generated checklist file: #{GENERATED_PATH}"
  warn 'Run scripts/build-framework-checklist.rb first.'
  exit 1
end

unless File.exist?(REQUIRED_AREAS_PATH)
  warn "Missing required audit-area file: #{REQUIRED_AREAS_PATH}"
  exit 1
end

generated = YAML.safe_load(File.read(GENERATED_PATH), aliases: true) || {}
required = YAML.safe_load(File.read(REQUIRED_AREAS_PATH), aliases: true) || {}

required_keys = Array(required['required_audit_areas']).map { |e| e['key'].to_s }.uniq.sort
covered_keys = Array(generated['audit_area_coverage']).map(&:to_s).uniq.sort
missing = required_keys - covered_keys

sections = Array(generated['sections'])
empty_sections = sections.select { |s| Array(s['items']).empty? }.map { |s| s['title'] }

puts "Generated file: #{GENERATED_PATH}"
puts "Required audit areas: #{required_keys.join(', ')}"
puts "Covered audit areas: #{covered_keys.join(', ')}"

if missing.empty?
  puts 'Coverage parity: PASS'
else
  puts "Coverage parity: FAIL (missing: #{missing.join(', ')})"
end

if empty_sections.empty?
  puts 'Section integrity: PASS'
else
  puts "Section integrity: FAIL (empty sections: #{empty_sections.join(', ')})"
end

exit 1 unless missing.empty? && empty_sections.empty?
