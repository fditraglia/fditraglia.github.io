# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Personal/academic website for Francis DiTraglia, hosted on GitHub Pages at ditraglia.com. It's a straightforward Jekyll site with no plugins or complex build pipeline — just Markdown pages, a few layouts, and SCSS.

## Local Development

```bash
rake setup   # one-time: brew install ruby@3.3, then bundle install
rake check   # validate _data/papers.yml
rake serve   # validate, then build and serve at http://localhost:4000
rake build   # validate, then build into _site
rake hooks   # one-time per machine: run `rake check` before every commit (hook lives in hooks/pre-commit)
```

The rake tasks set `PATH="/opt/homebrew/opt/ruby@3.3/bin:$PATH"` and `BUNDLE_PATH="$HOME/.bundle-github-pages"` before calling `bundle exec jekyll`; set the same two variables to run Jekyll directly.

The `github-pages` gem ensures parity with the GitHub Pages build environment. It needs Ruby 3.3 (Homebrew `ruby@3.3`): the system Ruby 2.6 is too old, and under Ruby 4 Bundler resolves to an old Jekyll that fails to load. Gems are installed outside the repo, in `~/.bundle-github-pages`. `Gemfile.lock` is gitignored.

## Deployment

Push to `master` — GitHub Pages builds and deploys automatically. The custom domain is configured via the `CNAME` file.

## Architecture

**Layouts** chain as: `home.html` / `page.html` / `post.html` → `default.html`. The default layout pulls in three includes: `head.html` (meta, CSS, MathJax), `header.html` (nav), `footer.html` (contact/social).

**Pages** are Markdown files at the repo root (`index.md`, `teaching.md`, `misc.md`) with YAML front matter setting layout, title, and permalink. The research page is the exception, described next.

**Papers data file**: Francis hand-edited `research.md` for over a decade, until September 2026, so expect him to look for it and remind him that papers now live in the data file. `research.html` has the `.html` extension on purpose, so that Jekyll skips the Markdown converter, which could mangle the HTML the template writes; the address is still `/research/`. Do not recreate `research.md`: a second page with the same permalink would conflict, and `rake check` refuses to pass if that file exists. `_data/papers.yml` is the single record of publications, working papers, and work in progress, including verbatim abstracts. Its header comment documents the fields. Two pages are generated from it, so edit the data file and never the output: `research.html` (each entry is rendered by `_includes/paper.html`, with the abstract hidden behind an inline "Abstract" button that a short script at the end of `research.html` toggles; styles are at the end of `_sass/_layout.scss`) and `llms.txt` (its Publications and Working Papers sections; the rest of that file is ordinary text). The CV in `../fditraglia-cv` is still maintained by hand and must be kept consistent with the data file. After rebuilding the CV, copy its PDF to `pdf/DiTraglia-CV.pdf`. The style conventions for paper entries (published titles, registered journal names, coauthors joined by "and", en dashes in page ranges) are recorded in `../fditraglia-cv/CLAUDE.md`.

**Nav** is hardcoded in `_includes/header.html` (CV PDF link, Research, Teaching, Misc) — not auto-generated from pages.

**Styling** lives in `css/main.scss` (variables + imports) pulling from `_sass/` partials. Key breakpoints: `$on-palm: 600px`, `$on-laptop: 800px`.

**Static assets**: PDFs in `pdf/`, datasets in `data/`, images in `img/`. Never delete or rename a file in `pdf/`: other sites, lecture notes, and outside pages link to these addresses even when no page in this repo does. To retire an old version, overwrite it in place. `pdf/treatment-effects.pdf` is a copy of the lecture notes served at treatment-effects.com; refresh it when those notes change.

**llms.txt**: Served at `ditraglia.com/llms.txt` per the [llmstxt.org](https://llmstxt.org/) standard. The paper lists come from `_data/papers.yml`; keep the teaching and project sections in sync by hand.

## Creating Blog Posts

```bash
rake post TITLE="Post Title"
```

This creates a dated Markdown file in `_posts/` with front matter scaffolding.
