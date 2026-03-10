# Site Cleanup Plan (March 2026)

Goal: clean up accumulated kludges across ditraglia.com over the next ~6 months, ending with a migration from Jekyll to Quarto.

---

## Current State

### Main site (this repo)
- Jekyll site, `github-pages` gem, deployed via GitHub Pages on push to `master`
- Custom domain: `ditraglia.com` (CNAME)
- 5 markdown pages, 3 dormant blog posts (2014-15), static assets
- Quarto-rendered HTML files (`BEE.html`, `BEE-lecture.html`, `exercise-1-22.html`) manually committed — bypasses Jekyll entirely
- 57 datasets in `/data/` with no documentation
- 29 PDFs in `/pdf/` (preprints, slides, CV, teaching materials)
- Archived Penn teaching content in `/econ103/`
- Styling is clean but circa-2013 aesthetic

### Other repos serving under ditraglia.com
GitHub project pages pattern: any repo with Pages enabled gets `ditraglia.com/<repo-name>`.

| Repo | URL | Tech | Status |
|------|-----|------|--------|
| `erm` | `/erm` | Quarto (ad hoc, no _quarto.yml) | Active |
| `prelims-prob-stats` | `/prelims-prob-stats` | Quarto website | Active |
| `QE` | `/QE` | GitHub Pages from `docs/` | Active |
| `llms-for-fun-and-profit` | `/llms-for-fun-and-profit` | Quarto revealjs | Active |
| `metrics-thesis` | `/metrics-thesis` | GitHub Pages | Active |
| `Econ103Public` | `/Econ103Public` | Plain files, `gh-pages` branch | Archived |
| `Econ224` | `/econ224` | Jekyll (minima), `docs/` | Archived |
| `Econ722` | `/econ722` | Jekyll, `gh-pages` branch | Archived |

### Sites with their own domains
| Repo | Domain | Tech |
|------|--------|------|
| `erm-book` | `empirical-methods.com` | Bookdown |
| `leadsafefutures` | `leadsafefutures.org` | Jekyll |
| `leadprevalence.uk` | `leadprevalence.uk` | Jekyll |
| `econometrics.blog` | `econometrics.blog` | Hugo (Wowchemy) on Netlify |
| `restatr.github.io` | `restatr.com` | Static (just CNAME + SVG) |

### Known issues
- Quarto HTML manually dropped into Jekyll site (no rebuild path)
- 4 build systems in use (Jekyll, Quarto, Bookdown, Hugo/Netlify)
- Dead links in `teaching.md`: `../prelims-prob-stats`, `../QE` resolve wrong
- Possibly dead external links: `treatment-effects.com`, `economictricks.com`
- Commented-out code: old bios in `index.md`, dead auto-nav in `header.html`, research statement in `research.md`
- `/data/` has no documentation or catalog page
- Blog infrastructure intact but unused for 10+ years
- `RWorkshop.md` is 2014 archival content, not linked from nav
- Duplicate data: `ProfEvaltnsBeautyPublic.dta` in both `/data/` and `/econ103/`
- Mixed HTTP/HTTPS in older content
- `README.md` references Ubuntu 14.04, has placeholder sections
- CSS: system font stack is dated, font-weight 300 is thin, no focus states, no dark mode

---

## Phase 1: Quick wins (now)

Low-risk changes to the current Jekyll site. No architectural decisions needed.

- [x] Add `llms.txt`
- [x] Fix dead links in `teaching.md` and `research.md`
- [x] Verify `treatment-effects.com` and `economictricks.com` are live
- [x] Remove commented-out code (old bios in `index.md`, dead nav in `header.html`, commented research statement in `research.md`)
- [x] Small CSS updates: modern font stack, font-weight 400 for body
- [x] Exclude non-site files from Jekyll build
- [x] Remove baseball reference (project on hold)
- [ ] Create a `/datasets/` page cataloging the 57 files in `/data/`
- [ ] Clean up `README.md` (or replace with minimal pointer to `CLAUDE.md`)
- [ ] Add CSS focus states for accessibility

## Phase 2: Audit and decisions (next few weeks)

Research and decide on the target architecture before migrating anything.

- [x] Check which external domains are live (`treatment-effects.com`, `economictricks.com`) — both live
- [x] `RWorkshop.md` and `/econ103/` — leave as-is
- [ ] Audit all course repos: which are still actively used vs. truly archived?
- [ ] Decide: keep `econometrics.blog` on Hugo/Netlify, or migrate to Quarto?
- [ ] Decide: keep `erm-book` on Bookdown, or migrate to Quarto book?
- [ ] Decide: HTML CV page alongside the PDF, or just keep the PDF?
- [ ] Decide: what to do with dormant blog (leave, redirect to econometrics.blog, or revive?)
- [ ] Decide: target URL structure for the Quarto site (directory-based for clean URLs)
- [ ] Document the target architecture

## Phase 3: Migrate main site to Quarto

Once Phase 2 decisions are made, do the migration in one shot.

- [ ] Create `_quarto.yml` with site config, navbar, footer
- [ ] Convert pages to `.qmd` (mostly renaming + removing Jekyll front matter)
- [ ] Port styling to Quarto Bootstrap 5 theme (custom `.scss`)
- [ ] Replace manually-committed Quarto HTML with proper `.qmd` source files
- [ ] Set up GitHub Action for deployment
- [ ] Preserve all URLs (directory-index pattern for pages, static files pass through)
- [ ] Test all links, especially PDF preprints and dataset URLs
- [ ] Add CNAME to Quarto resources
- [ ] Verify RSS feed works (Quarto listing pages generate feeds natively)

## Phase 4: Broader cleanup (as time allows)

- [ ] Migrate `erm-book` to Quarto book (if decided in Phase 2)
- [ ] Give `erm` a proper `_quarto.yml` project config
- [ ] Consider consolidating or archiving old Penn course repos
- [ ] Revisit `econometrics.blog` migration
- [ ] Add per-paper `llms.txt` files (see https://paulgp.com/2026/03/10/llms-txt-for-academic-papers.html). Pilot with one paper, then expand. LLM drafts initial summary, author adds limitations/scope. Link from site-level `llms.txt`. File organization TBD.
- [ ] Add dark mode support
- [ ] Consider structured CV (JSON Resume or similar)

---

## URL Preservation Checklist

Static files (~130 URLs) — no risk, Quarto passes these through:
- `/pdf/*` (29 files including preprints and CV)
- `/data/*` (57 datasets)
- `/econ103/*` (32 files)
- `/img/*` (2 images)
- `/BEE.html`, `/BEE-lecture.html`, `/exercise-1-22.html`
- `/ethics-template.zip`

Routed pages — use directory-index pattern:
- `/` → `index.qmd`
- `/research/` → `research/index.qmd`
- `/teaching/` → `teaching/index.qmd`
- `/misc/` → `misc/index.qmd`
- `/RWorkshop/` → `RWorkshop/index.qmd`
- `/blog/` → `blog/index.qmd`
- Blog posts → use `aliases:` in front matter for old URLs
- `/feed.xml` → Quarto listing page generates RSS natively
