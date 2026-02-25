---
name: post
description: "Process and publish blog posts for the guide-LLiMes site. Finds drafts, manages frontmatter, and previews locally. Delegates content writing to writer skill. Use when: publishing blog posts, managing _posts directory. Triggers: /post, blog post, publish post"
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
  - Skill(writer)
---

# Blog Post Publishing

Process draft posts into published articles. Handles operations; delegates content work to writer skill.

**Important**: Use only the scripts at `.agents/skills/post/scripts/` for file operations. Do not run ad-hoc `ls`, `cat`, or `grep` commands - the scripts handle all checks.

## Workflow

### 0. Create Task List

First, create a task list to track progress:

```
1. [ ] Discover drafts in _posts/
2. [ ] Read and understand content (first 15 lines)
3. [ ] Rename file to YYYY-MM-DD-slug.md format
4. [ ] Create .bak backup
5. [ ] Call writer skill for content processing
6. [ ] Generate HTML diff
7. [ ] Validate frontmatter
8. [ ] Ensure Jekyll running
9. [ ] Verify post built successfully
10. [ ] Provide preview and diff links
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

### 4. Call Writer Skill

Invoke the writer skill to handle content transformation:

```
Use the Skill tool to invoke: skill: "writer"
```

The writer skill will:
- Confirm tone with user
- Process and improve content
- Apply writing guide rules

Pass any tone hints from the user (e.g., `/post polish only` → tell writer "polish only").

### 5. Generate Diff

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

### 6. Validate

Run validation to check frontmatter:

```bash
.agents/skills/post/scripts/validate-post.sh _posts/2026-02-24-my-slug.md
```

Fix any errors before proceeding. Warnings are optional but recommended.

### 7. Rebuild and Preview

Ensure Jekyll is running:

```bash
.agents/skills/post/scripts/ensure-jekyll.sh ./start.sh
```

Jekyll with `--incremental` auto-rebuilds on file changes. Wait 3-5 seconds for rebuild.

Provide links:
- **Post**: `http://localhost:4000/posts/{slug}/`
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
   → Discovers draft, renames, backs up
   → Calls writer skill for content work
   → Generates diff, validates, previews
3. Review terminal diff + HTML diff page
4. Open preview link to verify
5. Commit when satisfied
```

### Option C: Content Only (skip operations)

```
/writer _posts/2026-02-24-my-post.md
```

Use writer directly when you only want to improve content without the operational workflow.

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

- **writer skill** - Content writing and tone management (called internally)
- [Writing Guide](.agents/skills/writer/references/writing-guide.md) - Full style and structure guidance
