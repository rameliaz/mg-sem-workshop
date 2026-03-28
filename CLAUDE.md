# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Quarto website for a **Multigroup Structural Equation Modeling (MG-SEM)** workshop held at Universitas Airlangga (November 2019). Author: Rizqy Amelia Zein. License: CC BY 4.0.

Published at: https://rameliaz.github.io/mg-sem-workshop/ (GitHub Pages from `docs/`)

## Build Commands

```bash
# Build everything (website + all 6 slides) into docs/
quarto render

# Preview with live reload
quarto preview

# Render a single slide deck
quarto render slides/bagian-1.qmd

# Install/update the UNAIR theme extension
quarto add rameliaz/quarto-unair-theme
```

## Architecture

### Project structure

- `_quarto.yml` — project config: website type, output-dir docs, cosmo HTML theme, navbar
- `_extensions/rameliaz/unair/` — UNAIR revealjs theme (installed via `quarto add`)
- `_extensions/quarto-ext/fontawesome/` — FA shortcode filter; loads FA 6.7.2 via CDN (no local font files)
- `_extensions/mcanouil/iconify/` — Iconify shortcode filter (used in page-footer)
- `index.qmd` — landing page (cosmo HTML theme)
- `slides/bagian-[1-6].qmd` — 6 revealjs slide decks (each overrides format to `unair-revealjs`)
- `slides/libs/` — static image assets referenced by slides as `libs/filename.png`
- `materials/` — workshop datasets; copied to `docs/materials/` on render (listed in `resources:`)
- `articles/` — reference PDFs (cho2016.pdf); copied to `docs/articles/` on render (listed in `resources:`)
- `img/` — logo assets used by UNAIR theme (`logo.png`, `logo_white.png`); copied to `docs/img/`
- `rmarkdown/` — archived old files (dies natalis .qmd); excluded from render via `.quartoignore`
- `docs/` — built output only; do not edit directly

### Slide format override

Each slide file specifies its own format in front matter, overriding the project default (`html`):
```yaml
format:
  unair-revealjs:
    slide-number: true
    progress: true
    transition: slide
    center: false
```

### Slide content map

| File | Topic |
|---|---|
| `slides/bagian-1.qmd` | Introduction to SEM |
| `slides/bagian-2.qmd` | Correlation |
| `slides/bagian-3.qmd` | Path models & lavaan syntax |
| `slides/bagian-4.qmd` | Confirmatory Factor Analysis (CFA) |
| `slides/bagian-5.qmd` | SEM fundamentals & model fit |
| `slides/bagian-6.qmd` | MG-SEM & measurement invariance |

### Datasets and materials

Datasets live in `materials/` (not the project root). The navbar Dataset menu links to `materials/*.jasp` / `materials/*.csv`. Six files are linked in the navbar:

`corr.jasp`, `latihancorr.csv`, `contoh-cfa.jasp`, `contoh-cfa.csv`, `data-contoh-mg-sem.csv`, `dataset-wave1.csv`

`cho2016.pdf` lives in `articles/` and is served at `docs/articles/cho2016.pdf`.

### Font Awesome

FA icons are used in slides via `{{< fa icon >}}` shortcodes (provided by `_extensions/quarto-ext/fontawesome/`). The extension loads FA **6.7.2 from cdnjs CDN** — there are no local font or CSS files in the repo. The only local asset kept is `assets/css/latex-fontsize.css` (custom size utility classes).

### Gotchas

- `_quarto.yml` has an explicit `render:` list — only 7 files. Without it, Quarto picks up CLAUDE.md, README.md, etc.
- `.quartoignore` excludes `docs/`, `CLAUDE.md`, `README.md`, `materials/`, `articles/`, `img/`, `rmarkdown/` from rendering; `resources:` in `_quarto.yml` ensures `materials/`, `articles/`, and `img/` are still copied to `docs/` despite being ignored.
- `quarto render` clears `docs/` before rebuild — don't store anything important there directly.
- The UNAIR theme (`theme.html`) injects logos via JS, referencing `../img/logo.png` and `../img/logo_white.png` relative to each slide deck.
- `slides/libs/` contains some unreferenced legacy images from the original xaringan slides — harmless, not cleaned up.
