# Design: Full Quarto Conversion

**Date:** 2026-02-19
**Author:** Rizqy Amelia Zein
**Status:** Approved

## Problem

The workshop website and slides were built with `rmarkdown` (website) and `xaringan` (slides) circa 2019. Both toolchains are now superseded by Quarto. The goal is a full conversion to a single Quarto project.

## Decisions

| Decision | Choice | Rationale |
|---|---|---|
| Project type | Single Quarto website project | One `quarto render` builds everything |
| Website theme | cosmo | User-specified |
| Slide theme | `rameliaz/quarto-unair-theme` (unair-revealjs) | User-specified |
| Output directory | `docs/` | Existing GitHub Pages setup unchanged |
| Deprecated packages | Replace | `emo::ji()` → Unicode, `fa()` → `{{< fa >}}` shortcodes |
| Old source files | Delete | `_site.yml`, `index.Rmd`, `slides/materi-mgsem-*.Rmd`, xaringan libs |

## File Structure

```
mg-sem-workshop/
├── _quarto.yml              # Project + website config
├── _extensions/unair/       # UNAIR revealjs theme (quarto add)
├── index.qmd                # Landing page (converted from index.Rmd)
├── slides/
│   ├── bagian-1.qmd         # Introduction to SEM
│   ├── bagian-2.qmd         # Correlation
│   ├── bagian-3.qmd         # Path models & lavaan syntax
│   ├── bagian-4.qmd         # Confirmatory Factor Analysis (CFA)
│   ├── bagian-5.qmd         # SEM fundamentals & model fit
│   └── bagian-6.qmd         # MG-SEM & measurement invariance
├── docs/                    # Built output (GitHub Pages)
└── [datasets, .R scripts, .jasp files — unchanged]
```

Files to delete after conversion:
- `_site.yml`
- `index.Rmd`
- `slides/materi-mgsem-1.Rmd` through `slides/materi-mgsem-6.Rmd`
- `slides/libs/remark-latest.min.js`
- `slides/libs/remark-css/`
- `docs/` tree (regenerated on render)

## `_quarto.yml` Specification

```yaml
project:
  type: website
  output-dir: docs

website:
  title: "Multigroup SEM Workshop"
  navbar:
    left:
      - text: "oleh Rizqy Amelia Zein"
        href: https://rameliaz.github.io/
      - icon: github
        href: https://github.com/rameliaz/mg-sem-workshop
    right:
      - text: "Salindia (HTML)"
        menu:
          - {text: "Bagian 1", href: slides/bagian-1.html}
          - {text: "Bagian 2", href: slides/bagian-2.html}
          - {text: "Bagian 3", href: slides/bagian-3.html}
          - {text: "Bagian 4", href: slides/bagian-4.html}
          - {text: "Bagian 5", href: slides/bagian-5.html}
          - {text: "Bagian 6", href: slides/bagian-6.html}
      - text: "Salindia (PDF)"
        menu:
          - {text: "Bagian 1", href: "slides/bagian-1.html?print-pdf"}
          - {text: "Bagian 2", href: "slides/bagian-2.html?print-pdf"}
          - {text: "Bagian 3", href: "slides/bagian-3.html?print-pdf"}
          - {text: "Bagian 4", href: "slides/bagian-4.html?print-pdf"}
          - {text: "Bagian 5", href: "slides/bagian-5.html?print-pdf"}
          - {text: "Bagian 6", href: "slides/bagian-6.html?print-pdf"}
      - text: "Dataset"
        menu:
          - {text: "Dataset Contoh Korelasi", href: corr.jasp}
          - {text: "Dataset Latihan Korelasi", href: latihancorr.csv}
          - {text: "Dataset Contoh CFA (*.jasp)", href: contoh-cfa.jasp}
          - {text: "Dataset Contoh CFA (*.csv)", href: contoh-cfa.csv}
          - {text: "Dataset Contoh Multigroup SEM", href: data-contoh-mg-sem.csv}
          - {text: "Dataset Latihan SEM", href: dataset-wave1.csv}
      - text: "Survei"
        menu:
          - {text: "Evaluasi Workshop", href: "https://www.soscisurvey.de/invited-talk-feedback/"}

format:
  html:
    theme: cosmo
    toc: true
    toc-float: true
    toc-depth: 3
    df-print: paged
```

## Slide Front Matter Template

Each `slides/bagian-N.qmd` uses:

```yaml
---
title: "Workshop MG-SEM Bagian N"
subtitle: "Dies Natalis 36th"
author: "Rizqy Amelia Zein"
institute: "Universitas Airlangga"
date: today
format:
  unair-revealjs:
    slide-number: true
    progress: true
    transition: slide
    center: false
---
```

## Content Conversion Rules (xaringan → Quarto revealjs)

| xaringan | Quarto revealjs |
|---|---|
| `---` (slide break) | `---` or new `##` heading |
| `class: inverse` slide | `## Title {background-color="#14497F"}` |
| `class: center, middle` | `## Title {.center}` |
| `class: inverse, center, middle` | `## Title {background-color="#14497F" .center}` |
| `.pull-left` / `.pull-right` | `::: {.columns}` / `::: {.column width="50%"}` / `:::` |
| `--` incremental reveal | `. . .` |
| `` `r fa("icon")` `` | `{{< fa icon >}}` |
| `` `r emo::ji("emoji")` `` | Direct Unicode character |
| `` `r Sys.Date()` `` in date | `date: today` |
| `<center><img src="..." style="width:N%"></center>` | `![](path){fig-align="center" width="N%"}` |
| `class: title-slide` (manual title) | Removed — UNAIR theme generates title slide from YAML |
| R-Ladies CSS classes (`.spaced`, `.fancyimage`) | Dropped |
| `library(fontawesome)`, `library(emo)` in setup chunk | Remove |
| `options(htmltools.dir.version = FALSE, width=120)` | Remove |
| `vignette:` block in YAML | Remove |
