#!/usr/bin/env ruby
# frozen_string_literal: true

require 'yaml'
require 'time'

ROOT = File.expand_path('..', __dir__)
DOC_GLOB = File.join(ROOT, 'docs', '**', '*.md')
OUTPUT_PATH = File.join(ROOT, '_data', 'framework-checklist.generated.yml')
REQUIRED_AREAS_PATH = File.join(ROOT, '_data', 'framework-checklist.required-audit-areas.yml')

STAGE_ORDER = {
  'stage-1' => 1,
  'stage-2' => 2,
  'stage-3' => 3,
  'stage-4' => 4,
  'stage-5' => 5
}.freeze

def load_frontmatter(path)
  content = File.read(path)
  match = content.match(/\A---\s*\n(.*?)\n---\s*\n/m)
  return {} unless match

  YAML.safe_load(match[1], aliases: true) || {}
end

def doc_id(path)
  path
    .sub(%r{^docs/}, '')
    .sub(/\.md$/, '')
    .tr('/', '.')
end

def default_label(title)
  "#{title} guidance is documented and current."
end

required_areas_data =
  if File.exist?(REQUIRED_AREAS_PATH)
    YAML.safe_load(File.read(REQUIRED_AREAS_PATH), aliases: true) || {}
  else
    {}
  end

required_area_keys = Array(required_areas_data['required_audit_areas']).map { |e| e['key'].to_s }.sort

items = []

Dir.glob(DOC_GLOB).sort.each do |abs_path|
  rel_path = abs_path.sub("#{ROOT}/", '')
  fm = load_frontmatter(abs_path)
  next unless fm['checklist_enabled']

  title = fm['title'] || File.basename(rel_path, '.md')
  order = fm['checklist_order'] || fm['nav_order'] || 999
  audit_areas = Array(fm['checklist_audit_areas']).map(&:to_s).uniq.sort

  items << {
    'id' => doc_id(rel_path),
    'path' => rel_path,
    'title' => title,
    'label' => fm['checklist_label'] || default_label(title),
    'stage' => fm['checklist_stage'] || 'stage-unknown',
    'section' => fm['checklist_section'] || 'Uncategorized',
    'order' => order,
    'audit_areas' => audit_areas
  }
end

section_buckets = Hash.new { |h, k| h[k] = [] }
items.each { |item| section_buckets[item['section']] << item }

sections = section_buckets.map do |section_name, section_items|
  sorted_items = section_items.sort_by { |item| [item['order'].to_i, item['title']] }
  stage = sorted_items.first['stage']

  {
    'key' => section_name.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, ''),
    'title' => section_name,
    'stage' => stage,
    'stage_order' => STAGE_ORDER.fetch(stage, 999),
    'items' => sorted_items
  }
end

sections.sort_by! { |s| [s['stage_order'], s['title']] }

covered_area_keys = items.flat_map { |i| i['audit_areas'] }.uniq.sort
missing_area_keys = required_area_keys - covered_area_keys

payload = {
  'generated_at' => Time.now.utc.iso8601,
  'item_count' => items.length,
  'sections' => sections,
  'audit_area_coverage' => covered_area_keys,
  'required_audit_areas' => required_area_keys,
  'missing_audit_areas' => missing_area_keys,
  'coverage_complete' => missing_area_keys.empty?
}

File.write(OUTPUT_PATH, payload.to_yaml(line_width: -1))

puts "Generated #{OUTPUT_PATH}"
puts "Checklist items: #{items.length}"
puts "Sections: #{sections.length}"
if missing_area_keys.empty?
  puts 'Audit-area parity: PASS'
else
  puts "Audit-area parity: FAIL (missing: #{missing_area_keys.join(', ')})"
end
