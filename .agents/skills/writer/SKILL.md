---
name: writer
description: "Write and refine blog post content. Handles tone detection, content transformation, and style guidance. Use when: improving drafts, setting tone, rewriting content. Triggers: /writer, write content, improve post, tone"
allowed-tools:
  - Read(_posts/*.md)
  - Write(_posts/*.md)
  - Edit(_posts/*.md)
  - Glob(_posts/*.md)
  - AskUserQuestion
---

# Content Writer

Write, improve, and refine blog post content with user-controlled tone decisions.

## Workflow

### 1. Read and Understand

Read the post file to understand:
- Topic and intent
- Target audience level
- Current structure and tone

### 2. Confirm Tone

Before transforming content, confirm the desired tone with the user.

**Check for inline tone hint**: User may invoke skill with tone hint like `/writer polish only` or `/writer deep dive`. If recognized, skip asking.

**Tone Detection Signals**:
- **Polish only**: Minimal restructuring, just format and complete
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

### 3. Process Content

Load the [Writing Guide](references/writing-guide.md) for structure and style guidance.

Then:
1. **Analyze** the content structure and intent
2. **Identify** gaps, weak sections, or misalignments
3. **Improve** the content following the guide and chosen tone
4. **Add/fix** frontmatter if needed

**Polish Only Rules**:
- Add frontmatter if missing
- Fix broken markdown
- Fix typos and obvious errors
- DO NOT add: TL;DR, "Why This Matters", conclusion sections
- DO NOT restructure: keep original heading hierarchy
- DO NOT expand: keep original scope

## Usage

### From post skill

The post skill calls writer internally after renaming/backing up:

```
/post my-draft.md
  → post: discover, rename, backup
  → writer: tone, content processing
  → post: diff, validate, preview
```

### Standalone

Use directly to improve existing content:

```
/writer _posts/2026-02-24-my-post.md
/writer polish only _posts/2026-02-24-my-post.md
```

## Related

- [Writing Guide](references/writing-guide.md) - Full style, structure, and content guidance
- post skill - Operational workflow (discovery, validation, preview)
