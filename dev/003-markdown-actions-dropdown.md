# 003 - Markdown Actions Dropdown

## What Shall Be Done

- Add a page-level dropdown button labeled `Markdown` in the site header (or equivalent stable page action area).
- On primary click, execute `Copy Markdown` directly.
- On dropdown expand, show exactly these actions:
  - `Copy Markdown`
  - `Open Raw Markdown`
  - `Open on GitHub`
- `Copy Markdown` must copy the source markdown for the current page with YAML front matter removed.
- `Open Raw Markdown` must open the raw markdown URL for the current page in a new browser tab.
- `Open on GitHub` must open the normal GitHub file page for the current markdown file in a new browser tab.

## Behavior Requirements

- Source path resolution must use the current page source path (for example via Jekyll `page.path`).
- Front matter removal must only strip a leading YAML block starting at file top and wrapped in `---` delimiters.
- If no front matter exists, copy full file content unchanged.
- If source fetch fails, show a clear user-visible error state (for example: `Unable to load markdown source`).
- Action labels and behavior must be identical on desktop and mobile.
- All actions must work on any documentation page backed by a repository markdown file.

## URL Requirements

- `Open Raw Markdown` URL format: GitHub raw content URL for the active branch and `page.path`.
- `Open on GitHub` URL format: standard GitHub blob page URL for the active branch and `page.path`.
- URL construction must not hardcode individual page paths.
- Repository and branch identifiers must be derived from site configuration/runtime metadata, not duplicated literals where avoidable.

## Accessibility Requirements

- Dropdown control must be keyboard accessible (`Tab`, `Enter`/`Space`, `Escape`).
- Menu must expose proper semantics (`button`, expanded state, and menu items or equivalent accessible pattern).
- Focus must move predictably when menu opens and closes.
- Copy success/failure must be communicated accessibly (visible text and screen-reader-friendly status).

## Non-Goals

- No markdown transformation beyond removing YAML front matter.
- No additional export formats in this change.
- No per-page custom action list.

## Acceptance Criteria

- Clicking `Markdown` copies markdown without front matter for the current page.
- Expanding dropdown reveals all three actions with exact labels.
- `Open Raw Markdown` opens the raw file content in a new tab.
- `Open on GitHub` opens the corresponding GitHub file page in a new tab.
- Copy output for a page with front matter begins with first markdown heading/content, not YAML keys.
- Copy output for a page without front matter matches file content exactly.
- Behavior is verified on local Jekyll serve and GitHub Pages deployment.
