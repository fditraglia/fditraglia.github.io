# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal/academic website for Francis DiTraglia, hosted on GitHub Pages at ditraglia.com. It's a straightforward Jekyll site with no plugins or complex build pipeline — just Markdown pages, a few layouts, and SCSS.

## Local Development

```bash
bundle install          # one-time setup
bundle exec jekyll serve  # builds and serves at http://localhost:4000
```

The `github-pages` gem (sole dependency) ensures parity with the GitHub Pages build environment.

## Deployment

Push to `master` — GitHub Pages builds and deploys automatically. The custom domain is configured via the `CNAME` file.

## Architecture

**Layouts** chain as: `home.html` / `page.html` / `post.html` → `default.html`. The default layout pulls in three includes: `head.html` (meta, CSS, MathJax), `header.html` (nav), `footer.html` (contact/social).

**Pages** are Markdown files at the repo root (`index.md`, `research.md`, `teaching.md`, `misc.md`) with YAML front matter setting layout, title, and permalink.

**Nav** is hardcoded in `_includes/header.html` (CV PDF link, Research, Teaching, Misc) — not auto-generated from pages.

**Styling** lives in `css/main.scss` (variables + imports) pulling from `_sass/` partials. Key breakpoints: `$on-palm: 600px`, `$on-laptop: 800px`.

**Static assets**: PDFs in `pdf/`, datasets in `data/`, images in `img/`.

## Creating Blog Posts

```bash
rake post TITLE="Post Title"
```

This creates a dated Markdown file in `_posts/` with front matter scaffolding.
