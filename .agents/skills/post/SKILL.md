---
name: post
description: "Process and publish blog posts for the guide-LLiMes site. Finds drafts, improves content, manages frontmatter, and previews locally. Use when: creating blog posts, editing articles, managing _posts directory. Triggers: /post, blog post, article, write post"
allowed-tools:
  - Bash(lsof* :4000*, .agents/skills/post/scripts/* *)
  - Bash(chmod +x .agents/skills/post/scripts/*)
  - Read(_posts/*.md)
  - Write(_posts/*.md)
  - Edit(_posts/*.md)
  - Glob(_posts/*.md)
  - Write(_diff/*)
  - TaskCreate
  - TaskUpdate
  - TaskList
  - AskUserQuestion
---

# Blog Post Processing

Process draft posts into polished, publishable articles.

**Important**: Use only the scripts at `.agents/skills/post/scripts/` for file operations. Do not run ad-hoc `ls`, `cat`, or `grep` commands - the scripts handle all checks.

## Workflow

### 0. Create Task List

First, create a task list to track progress:

```
1. [ ] Discover drafts in _posts/
2. [ ] Read and understand content (first 15 lines)
3. [ ] Rename file to YYYY-MM-DD-slug.md format
4. [ ] Create .bak backup
5. [ ] Confirm tone with user
6. [ ] Process and improve content (respect chosen tone)
7. [ ] Generate HTML diff
8. [ ] Validate frontmatter
9. [ ] Ensure Jekyll running
10. [ ] Verify post built successfully
11. [ ] Provide preview and diff links
```

Use TaskCreate to create these tasks, then update each to "completed" as you progress.

### 1. Discover Drafts

Run the discovery script:

```bash
.agents/skills/post/scripts/discover-drafts.sh
```

**CRITICAL**: Only process files from the "Files without date prefix" section. Ignore:
- Files already matching `YYYY-MM-DD-*.md` format
- Uncommitted changes to existing posts
- Untracked files that already have dates

If no undated files found, report and exit. **Do not skip or make decisions about content type.**

### 2. Read and Understand

Read **first 15 lines only of THE DRAFT FILE** (the one without date prefix):
- Topic and intent
- Target audience level
- Post type (tutorial, deep-dive, announcement, etc.)

Generate appropriate filename: `{YYYY-MM-DD}-{slug}.md`

### 3. Rename and Backup

```bash
.agents/skills/post/scripts/rename-and-backup.sh _posts/draft.md my-slug
```

The script:
- Prepends today's date if not provided
- Adds `.md` extension if missing
- Creates `.bak` backup automatically

Output shows the new file path for use in subsequent steps.

### 4. Confirm Tone

Before transforming content, confirm the desired tone with the user.

**Check for inline tone hint first**: User may invoke skill with tone hint like `/post polish only` or `/post deep dive`. If recognized, skip this step.

If no hint, analyze the draft's existing tone and ask user:

**Tone Detection Signals**:
- **Polish only**: User choice - minimal restructuring, just format and complete
- **Reference/List**: Bullet lists, collections, "here is a list", no recommendations
- **Tutorial**: "How to", prerequisites, numbered steps, "follow along"
- **Deep Dive**: "Why", "how it works", concept explanations
- **Announcement**: "Announcing", "new", "release", "update"
- **Opinion**: "I think", "in my view", "should", recommendations
- **Benchmark**: Numbers, tables, "vs", comparisons

Use AskUserQuestion to present options:
1. Detected tone (with reasoning)
2. Polish only (Recommended if source is already well-structured)
3. 2-3 alternative suitable tones

### 5. Process Content

Load the [Writing Guide](references/writing-guide.md) for structure and style guidance.

Then:
1. **Analyze** the content structure and intent
2. **Identify** gaps, weak sections, or misalignments
3. **Improve** the content following the guide
4. **Add/fix** frontmatter (see required fields below)

**Do not skip files.** Process whatever draft is found. If uncertain about content type, pick the closest match and proceed.

### 6. Generate Diff

**ALWAYS use the script** - do not manually write HTML:

```bash
.agents/skills/post/scripts/diff-to-html.sh \
  _posts/2026-02-24-my-slug.md.bak \
  _posts/2026-02-24-my-slug.md \
  _diff/my-slug.html
```

Note: Diff files go in `_diff/` (not `_site/diff/`) because Jekyll regenerates `_site/` on each build.

Provide:
- Terminal diff summary (from script output)
- HTML diff link: `file://$PWD/_diff/{slug}.html` (open in browser directly)

### 7. Validate

Run validation to check frontmatter:

```bash
.agents/skills/post/scripts/validate-post.sh _posts/2026-02-24-my-slug.md
```

Fix any errors before proceeding. Warnings are optional but recommended.

### 8. Rebuild and Preview

Ensure Jekyll is running:

```bash
.agents/skills/post/scripts/ensure-jekyll.sh ./start.sh
```

Jekyll with `--incremental` auto-rebuilds on file changes. Wait 3-5 seconds for rebuild.

Provide links:
- **Post**: `http://localhost:4000/posts/{year}/{month}/{day}/{slug}/`
- **Diff**: `file://{project-root}/_diff/{slug}.html` (open directly in browser)

## Frontmatter Reference

Required fields for every post:

```yaml
---
title: "Post Title Here"
layout: post
date: 2026-02-24
author: kirby
tags: [tag1, tag2]
---
```

| Field | Required | Notes |
|-------|----------|-------|
| `title` | Yes | In quotes, contains primary keyword |
| `layout` | Yes | Always `post` |
| `date` | Yes | ISO format: YYYY-MM-DD |
| `author` | Recommended | Author name |
| `tags` | Optional | Array of relevant tags |

## File Naming Convention

```
_posts/
  2026-02-24-announcing-llimes.md
  2026-03-01-why-guidelines-fail.md
  2026-03-15-token-budget-myths.md
```

Format: `{YYYY-MM-DD}-{kebab-case-slug}.md`

- Date: Use frontmatter date if present, else today
- Slug: 3-5 words describing the topic

## Post Types

Quick reference (see [Writing Guide](references/writing-guide.md) for details):

| Type | Purpose | Word Count |
|------|---------|------------|
| Tutorial | Step-by-step instruction | 1,500-3,000 |
| Deep Dive | Explains concept in depth | 2,000-4,000 |
| Postmortem | Incident analysis | 1,500-2,500 |
| Benchmark | Data-driven comparison | 1,500-2,500 |
| Announcement | News/updates | 500-1,000 |
| Opinion | Perspective/take | 800-1,500 |

## Quick Start

### Option A: Create New Post from Scratch

```bash
# Create a new post with auto-generated slug
.agents/skills/post/scripts/create-post.sh "My Post Title"

# Create with options
.agents/skills/post/scripts/create-post.sh "Announcing v2.0" \
  -a alice \
  -t announcement,release \
  -o  # opens for editing
```

The script:
- Generates URL-safe slug from title
- Creates properly dated filename (YYYY-MM-DD-slug.md)
- Adds complete frontmatter
- Optionally opens for editing

### Option B: Process Existing Draft

```
1. Create draft: _posts/my-idea.md
2. Run: /post
3. Review terminal diff + HTML diff page
4. Open preview link to verify
5. Commit when satisfied
```

## Scripts

| Script | Purpose |
|--------|---------|
| `.agents/skills/post/scripts/create-post.sh` | Create new post with frontmatter from title |
| `.agents/skills/post/scripts/discover-drafts.sh` | Find undated/uncommitted drafts |
| `.agents/skills/post/scripts/rename-and-backup.sh` | Rename draft to dated format, create .bak |
| `.agents/skills/post/scripts/diff-to-html.sh` | Convert diff output to styled HTML page |
| `.agents/skills/post/scripts/validate-post.sh` | Check frontmatter has required fields |
| `.agents/skills/post/scripts/ensure-jekyll.sh` | Start Jekyll if not running |

## Related

- [Writing Guide](references/writing-guide.md) - Full style, structure, and content guidance
