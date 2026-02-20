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
- `_extensions/unair/` — UNAIR revealjs theme (installed via `quarto add`)
- `index.qmd` — landing page (cosmo HTML)
- `slides/bagian-[1-6].qmd` — 6 revealjs slide decks (each overrides format to `unair-revealjs`)
- `slides/libs/` — static image assets referenced by slides as `libs/filename.png`
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

### Datasets (root, copied to docs/ on render)

`corr.jasp`, `latihancorr.csv`, `contoh-cfa.jasp`, `contoh-cfa.csv`, `data-contoh-mg-sem.csv`, `dataset-wave1.csv`, `codebook-kamusdata.xlsx`, `cho2016.pdf`
