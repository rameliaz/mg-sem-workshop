# Quarto Conversion Implementation Plan

> **For Claude:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Convert the rmarkdown/xaringan workshop site to a single Quarto website project with cosmo theme (landing page) and unair-revealjs theme (6 slide decks).

**Architecture:** Single `_quarto.yml` at root; `index.qmd` for landing page; `slides/bagian-[1-6].qmd` for presentations. Each slide file overrides the project-level `format: html` with `format: unair-revealjs` in its own front matter. Output goes to `docs/` for GitHub Pages.

**Tech Stack:** Quarto ≥1.4, R/knitr (for code chunks), `rameliaz/quarto-unair-theme` extension, cosmo Bootstrap theme.

---

## Conversion Reference

Apply these rules consistently across ALL slide files:

| xaringan | Quarto revealjs |
|---|---|
| `---` slide break | `---` or new `##` heading |
| `class: inverse` | `## Title {background-color="#14497F"}` |
| `class: center, middle` | `## Title {.center}` |
| `class: inverse, center, middle` | `## Title {background-color="#14497F" .center}` |
| `class: inverse, middle` | `## Title {background-color="#14497F"}` |
| `class: middle` | remove class, keep content |
| `.pull-left[...]` `.pull-right[...]` | `::: {.columns}` `::: {.column width="50%"}` `:::` blocks |
| `--` incremental | `. . .` |
| `` `r fa("arrow-circle-right")` `` | `{{< fa circle-arrow-right >}}` |
| `` `r fa("universal-access")` `` | `{{< fa universal-access >}}` |
| `` `r fa("paper-plane")` `` | `{{< fa paper-plane >}}` |
| `` `r fa("twitter")` `` | `{{< fa brands twitter >}}` |
| `` `r fa("github")` `` | `{{< fa brands github >}}` |
| `` `r fa("desktop")` `` | `{{< fa desktop >}}` |
| `` `r fa("r-project")` `` | `{{< fa brands r-project >}}` |
| `` `r emo::ji("wink")` `` | 😉 |
| `` `r emo::ji("exclamation")` `` | ❗ |
| `` `r emo::ji("loud")` `` | 📢 |
| `` `r emo::ji("smile")` `` | 😄 |
| `` `r emo::ji("sad")` `` | 😢 |
| `` `r emo::ji("medal")` `` | 🥇 |
| `` `r emo::ji("school")` `` | 🏫 |
| `` `r emo::ji("ok")` `` | ✅ |
| `` `r emo::ji("love")` `` | ❤️ |
| `` `r emo::ji("folded")` `` | 🙏 |
| `<center><img src="libs/x.png" style="width:N%;"></center>` | `![](libs/x.png){fig-align="center" width="N%"}` |
| `.footnote[text]` | `::: {.aside}` `text` `:::` |
| `{r eval=FALSE}` chunk option | `#| eval: false` inside chunk |
| `library(fontawesome)`, `library(emo)` in setup | remove |
| `options(htmltools.dir.version = FALSE, width=120)` | remove |
| Manual title slide block | remove — UNAIR theme auto-generates from YAML |
| `vignette:` YAML block | remove |

---

## Task 1: Bootstrap project — extension, `_quarto.yml`, `.gitignore`

**Files:**
- Run: `quarto add rameliaz/quarto-unair-theme` (creates `_extensions/unair/`)
- Create: `_quarto.yml`
- Create: `.gitignore`

**Step 1: Install UNAIR Quarto extension**

Run from the project root:
```bash
quarto add rameliaz/quarto-unair-theme
```
Expected: creates `_extensions/unair/` with `_extension.yml`, `airlangga.scss`, `theme.html`.
Answer `Y` to any prompts.

**Step 2: Create `_quarto.yml`**

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
          - text: "Bagian 1"
            href: slides/bagian-1.html
          - text: "Bagian 2"
            href: slides/bagian-2.html
          - text: "Bagian 3"
            href: slides/bagian-3.html
          - text: "Bagian 4"
            href: slides/bagian-4.html
          - text: "Bagian 5"
            href: slides/bagian-5.html
          - text: "Bagian 6"
            href: slides/bagian-6.html
      - text: "Salindia (PDF)"
        menu:
          - text: "Bagian 1"
            href: "slides/bagian-1.html?print-pdf"
          - text: "Bagian 2"
            href: "slides/bagian-2.html?print-pdf"
          - text: "Bagian 3"
            href: "slides/bagian-3.html?print-pdf"
          - text: "Bagian 4"
            href: "slides/bagian-4.html?print-pdf"
          - text: "Bagian 5"
            href: "slides/bagian-5.html?print-pdf"
          - text: "Bagian 6"
            href: "slides/bagian-6.html?print-pdf"
      - text: "Dataset"
        menu:
          - text: "Dataset Contoh Korelasi"
            href: corr.jasp
          - text: "Dataset Latihan Korelasi"
            href: latihancorr.csv
          - text: "Dataset Contoh CFA (*.jasp)"
            href: contoh-cfa.jasp
          - text: "Dataset Contoh CFA (*.csv)"
            href: contoh-cfa.csv
          - text: "Dataset Contoh Multigroup SEM"
            href: data-contoh-mg-sem.csv
          - text: "Dataset Latihan SEM"
            href: dataset-wave1.csv
      - text: "Survei"
        menu:
          - text: "Evaluasi Workshop"
            href: "https://www.soscisurvey.de/invited-talk-feedback/"

format:
  html:
    theme: cosmo
    toc: true
    toc-float: true
    toc-depth: 3
    df-print: paged
```

**Step 3: Create `.gitignore`**

```
.Rhistory
.RData
.Rproj.user
/.quarto/
```

**Step 4: Commit**

```bash
git add _extensions/ _quarto.yml .gitignore
git commit -m "feat: bootstrap Quarto project with UNAIR extension"
```

---

## Task 2: Create `index.qmd`

**Files:**
- Create: `index.qmd`

**Step 1: Create `index.qmd`**

```markdown
---
title: "Workshop Multigroup SEM"
---

## Deskripsi

Berikut adalah repositori yang digunakan untuk menyimpan semua materi untuk **Workshop Multigroup Structural Equation Modeling (MG-SEM)** yang diselenggarakan oleh Departemen Psikologi Kepribadian dan Sosial, Fakultas Psikologi Universitas Airlangga dalam rangka memperingati Dies Natalis Pendidikan Psikologi Universitas Airlangga yang ke-36.

Materi berlisensi [Creative Commons BY-SA 4.0](https://creativecommons.org/licenses/by/4.0/). **Materi bebas digunakan kembali namun wajib menyebutkan sumber aslinya**.


## Waktu dan tempat

*Workshop* diselenggarakan pada hari **Jumat-Sabtu, 22-23 November 2019**, pukul 09.00-16.00 WIB di Ruang Sidang I, Fakultas Psikologi Universitas Airlangga.


## *Outline* materi

### **Hari 1**: Jumat, 22 November 2019

##### **Pengantar**
* Apa itu *structural equation modeling* (SEM)?
* Mengapa dan pada kondisi seperti apa SEM diperlukan?
* Beberapa pilihan perangkat lunak untuk mengeksekusi SEM
* Yang tidak dicakup dalam *workshop* serta keterbatasan JASP

##### **Korelasi**
* Jenis-jenis koefisien korelasi
* Faktor-faktor yang membuat koefisien korelasi bervariasi
* [Koreksi atenuasi](https://methods.sagepub.com/reference/encyc-of-research-design/n81.xml) dan *measurement error*
* *Variance-covariance* dan *correlation matrix*
* *WARNING! Covariance/correlation matrix is not positive definite*
* [*Heywood* dan *ultra-Heywood case*](https://journals.sagepub.com/doi/10.1177/0049124112442138)
* Bivariat, *part*, dan *partial correlation*
* Metrik variabel (*standardised* vs *unstandardised*)

##### **Model Jalur** (*Path Model*) dan Model Regresi
* Definisi *path model*
* Nama variabel dan koefisien jalur (*path coefficients*)
  * δ (delta), ε (epsilon), ξ (ksi), η (eta), λ (lambda), γ (gamma), β (beta), φ (phi), ζ (zeta)
* Representasi visual model jalur menggunakan diagram jalur (*path diagram*)
* Menggambarkan hubungan antar-variabel dengan menggunakan diagram jalur
* *Syntax* `lavaan` untuk spesifikasi model jalur
* Asumsi kausalitas (?) dan limitasi


### **Hari 2**: Sabtu, 23 November 2019

##### **Confirmatory Factor Analysis (CFA)**
* Definisi *factor analysis*
* *Exploratory* vs *confirmatory factor analysis*
* Kapan menggunakan CFA?
* [*Constraining parameter* model](https://psycnet.apa.org/record/2008-06808-005)
* Model pengukuran (paralel, *tau equivalence*, dan *congeneric*)
* Variabel indikator (reflektif vs formatif)
* *Correlated error variances*
* Metode estimasi
* Menuliskan hasil analisis CFA dalam laporan penelitian


##### **Dasar-dasar Structural Equation Modeling (SEM)**
* Dasar-Dasar SEM: Model struktural & pengukuran
* Tahapan *modeling* dengan menggunakan SEM
  * Spesifikasi model
  * Identifikasi model
  * Estimasi model
  * Menguji model
  * Memodifikasi model
* *Degree of freedom*
* *Underidentified*, *just-identified*, dan *overidentified model*
* Jenis-jenis kriteria untuk menilai ketepatan model (*model fit*)
  * [*Model fit*](http://www.ejbrm.com/issue/download.html?idArticle=183)
  * *Model comparison*/*Incremental fit indices*
  * *Model parsimony*
  * *Parameter fit*
* Menguji hipotesis
  * *Statistical power*
  * Ukuran sampel
* Membedakan antara pendekatan dua-langkah dengan empat-langkah *modeling* dengan SEM
* Menuliskan hasil analisis SEM dalam laporan penelitian


##### **Multiple-group SEM (MG-SEM)**
* Kapan perlu menggunakan MG-SEM?
* *Measurement invariance*
  * *Configural invariance*
  * *Weak/metric invariance*
  * *Strong/scalar invariance*
  * *Strict/residual invariance*
  * *Homogeneity of latent variable variances*
  * *Homogeneity of factor means*
* Mengevaluasi *measurement invariance*
* Menuliskan hasil analisis MG-SEM dalam laporan penelitian


## Referensi

* Baujean, A.A. (2014). *Latent Variable Modeling Using R: A step-by-step guide*. New York: Routledge.
* Schumacker, R.E. & Lomax, R.G. (2016). *A Beginner's Guide to Structural Equation Modeling (4th edition)*. New York: Routledge.
* Van De Schoot, R., Schmidt, P., De Beuckelaer, A., Lek, K., & Zondervan-Zwijnenburg, M. (2015). [Measurement invariance](https://www.frontiersin.org/articles/10.3389/fpsyg.2015.01064/full). Frontiers in psychology, 6, 1064.
* Putnick, D. L., & Bornstein, M. H. (2016). [Measurement invariance conventions and reporting: The state of the art and future directions for psychological research](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5145197/). Developmental review, 41, 71-90.


## Contoh penelitian dengan `MG-SEM`

* Rodriguez, V. J., Radusky, P. D., Kumar, M., Nemeroff, C. B., & Jones, D. (2018). [Measurement invariance of the Childhood Trauma Questionnaire by gender, poverty level, and HIV status](https://www.sciencedirect.com/science/article/abs/pii/S2468171718300085). Personalized Medicine in Psychiatry, 11, 16-22.
* Liu, Y., Millsap, R. E., West, S. G., Tein, J. Y., Tanaka, R., & Grimm, K. J. (2017). [Testing measurement invariance in longitudinal data with ordered-categorical measures](https://psycnet.apa.org/record/2016-25480-001). Psychological methods, 22(3), 486.
* Bowden, S. C., Saklofske, D. H., Van de Vijver, F. J. R., Sudarshan, N. J., & Eysenck, S. B. G. (2016). [Cross-cultural measurement invariance of the Eysenck Personality Questionnaire across 33 countries](https://www.sciencedirect.com/science/article/abs/pii/S0191886916302835). Personality and Individual Differences, 103, 53-60.
* Bieda, A., Hirschfeld, G., Schönfeld, P., Brailovskaia, J., Zhang, X. C., & Margraf, J. (2017). [Universal happiness? Cross-cultural measurement invariance of scales assessing positive mental health](http://www.kli.psy.ruhr-uni-bochum.de/klipsy/public/margraf%20Journals%20with%20Peer-Review/Bieda%20et%20al%202016%20Universal%20happiness.pdf). Psychological assessment, 29(4), 408.


## Sumber belajar lainnya

* [Learning Statistics with JASP](https://learnstatswithjasp.com/)
* [Undergraduate Statistics with JASP](https://osf.io/t56kg/)
* [Materi workshop SEM: Sacha Epskamp](http://sachaepskamp.com/SEM2019)


## Sebelum mulai workshop

* Sebaiknya semua peserta sudah memasang [JASP versi 0.11.1](https://jasp-stats.org/download/) pada perangkatnya masing-masing, untuk menghindari terlalu banyaknya waktu untuk menyelesaikan *troubleshooting* instalasi ketika *workshop*.
* Peserta sangat disarankan untuk menonton video tutorial JASP di bawah ini sebelum *workshop* untuk belajar menavigasikan menu dan fitur yang ada dalam JASP (total durasi kurang lebih hanya 5 menit).

{{< video https://www.youtube.com/embed/HxqB7CUA-XI >}}


## Video rekaman

### Hari 1

**Mohon maaf sebesar-besarnya. Saya gagal menyimpan video rekaman untuk seluruh sesi di hari pertama dengan baik karena khilaf tidak menyalakan opsi merekam suara, sehingga yang terekam hanya layar laptop saya saja tanpa ada suara sama sekali**

**Saya menyampaikan materi yang sama pada kesempatan yang lain. [Silakan mengakses videonya disini](https://rameliaz.github.io/lvm-cfa/).**

### Hari 2

#### Sesi 1 (09.00-12.00)

{{< video https://www.youtube.com/embed/FB-e48e_UtQ >}}

#### Sesi 2 (13.00-16.00)

{{< video https://www.youtube.com/embed/ibgXwu3S8m8 >}}


## Pembaruan dan koreksi

* Di dalam video, saya menyebutkan bahwa variabel endogen dan eksogen hanya ada masing-masing 1 variabel dalam model, padahal yang betul adalah variabel endogen dan eksogen bisa lebih dari satu dalam model yang sama. Sesuai definisinya, variabel endogen adalah variabel yang **hanya menerima** *direct effect* dari variabel lainnya di dalam model, sedangkan variabel eksogen adalah variabel yang **hanya memberi** *direct effect* kepada variabel lainnya di dalam model yang sama.
* Saya merevisi gambar *part correlation* di [Bagian 2](slides/bagian-2.html) dimana versi sebelumnya (yang ada di dalam video) sangat membingungkan.
* Saya menambahkan keterangan bahwa di beberapa literatur yang lain *weak invariance* juga disebut *metric invariance*, *strong invariance* disebut *scalar invariance*, sedangkan *strict invariance* juga disebut sebagai *residual invariance*.
* Saya menyebutkan bahwa formula *composite reliability* adalah Cronbach's α. Padahal *composite reliability* (yang dikeluarkan oleh AMOS) mengikuti model pengukuran *congeneric*. Saya menjelaskan di bagian video yang lain (di sesi terakhir) apa perbedaan *composite reliability* dengan Cronbach's α, serta teknik reliabilitas apa yang cocok untuk digunakan pada model pengukuran tertentu.

Referensi untuk poin terakhir: Cho, E. (2016). [Making Reliability Reliable: A Systematic approach to reliability coefficients](cho2016.pdf). Organizational Research Methods, 19(4), 651-682.


## Poster kegiatan

![](slides/libs/poster.jpg){fig-align="center" width="70%"}


## Jawaban Latihan

### Latihan Mandiri (1):

[Klik disini untuk melihat jawaban]() saya atas latihan mandiri (1).

### Latihan Mandiri (2):

[Klik disini untuk melihat jawaban]() saya atas latihan mandiri (2).

### Latihan Mandiri (3):

[Klik disini untuk melihat jawaban]() saya atas latihan mandiri (3).

### Latihan Mandiri (4):

[Klik disini untuk melihat jawaban]() saya atas latihan mandiri (4).

### Latihan Mandiri (5):

[Klik disini untuk melihat jawaban]() saya atas latihan mandiri (5).

### Latihan Mandiri (6):

[Klik disini untuk melihat jawaban]() saya atas latihan mandiri (6).
```

**Step 2: Commit**

```bash
git add index.qmd
git commit -m "feat: add index.qmd landing page"
```

---

## Task 3: Create `slides/bagian-1.qmd` (Pengantar SEM)

**Files:**
- Create: `slides/bagian-1.qmd`

**Step 1: Create the file**

```markdown
---
title: "Workshop MG-SEM Bagian 1"
subtitle: "Dies Natalis 36th — Pengantar"
author: "Rizqy Amelia Zein"
institute: "Universitas Airlangga"
date: today
format:
  unair-revealjs:
    slide-number: true
    progress: true
    transition: slide
    center: false
execute:
  eval: false
  echo: true
---

## Menghubungi saya? {.center}

{{< fa paper-plane >}} <amelia.zein@psikologi.unair.ac.id>

{{< fa brands twitter >}} [\@ameliazein](https://twitter.com/ameliazein)

{{< fa brands github >}} [\@rameliaz](https://github.com/rameliaz)

{{< fa desktop >}} <https://rameliaz.github.io>

Materi dalam paparan ini berlisensi CC 4.0 dan tersedia di <https://rameliaz.github.io/mg-sem-workshop/>.

---

## *Outline* Hari 1: Jumat, 22 November 2019 {background-color="#14497F"}

::: {.columns}
::: {.column width="50%"}

## Sebelum istirahat (09.00-11.30)

**Pengantar**

* Apa itu *structural equation modeling* (SEM)?
* Mengapa dan pada kondisi seperti apa SEM diperlukan?
* Beberapa pilihan perangkat lunak untuk mengeksekusi SEM
* Yang tidak dicakup dalam *workshop* serta keterbatasan JASP

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/31lPv5L3aIvTi/giphy.gif)

:::
:::

---

## *Outline* Hari 1: Jumat, 22 November 2019

::: {.columns}
::: {.column width="50%"}

## Sebelum istirahat (09.00-11.30)

* Jenis-jenis koefisien korelasi
* Faktor-faktor yang membuat koefisien korelasi bervariasi
* [Koreksi atenuasi](https://methods.sagepub.com/reference/encyc-of-research-design/n81.xml) dan *measurement error*
* *Variance-covariance* dan *correlation matrix*
* *WARNING! Covariance/correlation matrix is not positive definite*
* [*Heywood* dan *ultra-Heywood case*](https://journals.sagepub.com/doi/10.1177/0049124112442138)
* Bivariat, *part*, dan *partial correlation*
* Metrik variabel (*standardised* vs *unstandardised*)

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/3ornjXIIShZ2MgyyHu/giphy.gif)

:::
:::

---

## *Outline* Hari 1: Jumat, 22 November 2019

::: {.columns}
::: {.column width="50%"}

## Setelah istirahat (13.00-16.00)

* Definisi *path model*
* Nama variabel dan koefisien jalur (*path coefficients*)
  * δ (delta), ε (epsilon), ξ (ksi), η (eta), λ (lambda), γ (gamma), β (beta), φ (phi), ζ (zeta)
* Representasi visual model jalur menggunakan diagram jalur (*path diagram*)
* Menggambarkan hubungan antar-variabel dengan menggunakan diagram jalur
* *Syntax* `lavaan` untuk spesifikasi model jalur
* Asumsi kausalitas (?) dan limitasi

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/rVbAzUUSUC6dO/giphy.gif)

:::
:::

---

## *Outline* Hari 2: Sabtu, 23 November 2019 {background-color="#14497F"}

::: {.columns}
::: {.column width="50%"}

## Sebelum istirahat (09.00-12.00)

* Definisi *factor analysis*
* *Exploratory* vs *confirmatory factor analysis*
* Kapan menggunakan CFA?
* [*Constraining parameter* model](https://psycnet.apa.org/record/2008-06808-005)
* Model pengukuran (paralel, *tau equivalence*, dan *congeneric*)
* Variabel indikator (reflektif vs formatif)
* *Correlated error variances*
* Metode estimasi
* Menuliskan hasil analisis CFA dalam laporan penelitian

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/WUq1cg9K7uzHa/giphy.gif)

:::
:::

---

## *Outline* Hari 2: Sabtu, 23 November 2019

::: {.columns}
::: {.column width="50%"}

## Setelah istirahat (13.00-16.00)

##### **Dasar-dasar Structural Equation Modeling (SEM)**
* Dasar-Dasar SEM: Model struktural & pengukuran
* Tahapan *modeling* dengan menggunakan SEM
* *Degree of freedom*
* *Underidentified*, *just-identified*, dan *overidentified model*

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/11sBLVxNs7v6WA/giphy.gif)

:::
:::

---

## *Outline* Hari 2: Sabtu, 23 November 2019

::: {.columns}
::: {.column width="50%"}

## Setelah istirahat (13.00-16.00)

##### **Dasar-dasar Structural Equation Modeling (SEM)**
* Jenis-jenis kriteria untuk menilai ketepatan model (*model fit*)
* Menguji hipotesis (*statistical power*, ukuran sampel)
* Membandingkan pendekatan dua-langkah vs empat-langkah
* Menuliskan hasil analisis SEM dalam laporan penelitian

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/LNE01Z89j9gis/giphy.gif)

:::
:::

---

## *Outline* Hari 2: Sabtu, 23 November 2019

::: {.columns}
::: {.column width="50%"}

## Setelah istirahat (13.00-16.00)

##### **Multiple-group SEM (MG-SEM)**
* Kapan perlu menggunakan MG-SEM?
* *Measurement invariance*
  * *Configural invariance*
  * *Weak/metric invariance*
  * *Strong/scalar invariance*
  * *Strict/residual invariance*
  * *Homogeneity of latent variable variances*
  * *Homogeneity of factor means*
* Mengevaluasi *measurement invariance*
* Menuliskan hasil analisis MG-SEM dalam laporan penelitian

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/PBM14uaJCbp72/giphy.gif)

:::
:::

---

## Apa itu *structural equation modeling*? {background-color="#14497F" .center}

::: {.columns}
::: {.column width="50%"}

## Pernahkah bapak/ibu menggunakan SEM sebelumnya?
## Untuk apa SEM digunakan?

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/fvwXjE0Hf70690czE5/giphy.gif)

:::
:::

---

## SEM adalah...

* Memuat **hubungan** antara **observed** dan **latent variables** dalam berbagai bentuk model teoritis. SEM memungkinkan peneliti untuk melakukan **pengujian hipotesis** yang berkaitan dengan model tersebut.

* Model SEM mengasumsikan (hipotesis) bahwa seperangkat variabel (*observed*) mendefinisikan sebuah konstruk **laten**, dan menggambarkan bagaimana hubungan antara konstruk-konstruk laten ini.

* Tujuan SEM adalah untuk mengetahui apakah model teoritik yang diuji peneliti **didukung oleh data**
  - Apabila data memberikan **bukti yang mendukung** bahwa hubungan antar konstruk/variabel terjadi, maka **mungkin** hubungan tersebut memang benar-benar ada di populasi.
  - Apabila data **tidak memberikan bukti yang mendukung** korelasi yang dihipotesiskan, maka peneliti dapat melakukan **re-spesifikasi model** dan menguji kembali model yang sudah dire-spesifikasi tersebut, atau **menyusun ulang model yang baru** untuk kemudian diuji kembali.

---

## Jenis-jenis variabel

::: {.columns}
::: {.column width="50%"}

* Variabel *observed*
  - Variabel yang dapat diukur langsung dengan berbagai cara/strategi.
  - Dalam pengukuran Psikologi, *item* pernyataan (dalam skala Psikologi) adalah variabel *observed*.
  - Variabel *observed* dapat merefleksikan variabel *latent* atau bisa menjadi **kombinasi linear** atas variabel *observed* yang lain (*index*).

* Variabel *latent*
  - Konstruk/variabel yang **tidak dapat diukur secara langsung**.
  - Oleh karena itu, membutuhkan variabel *observed* untuk mengukurnya.
  - Variabel *latent* dapat berperan sebagai variabel *independent* atau *dependent*.

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/irClCpuJAWgRqtP73t/giphy.gif)

:::
:::

---

## Jenis-jenis variabel

::: {.columns}
::: {.column width="50%"}

* Variabel Eksogen dan Endogen
  - Variabel eksogen {{< fa circle-arrow-right >}} variabel yang **hanya memberi** *direct effect* pada variabel lain di dalam model yang sama
  - Variabel endogen {{< fa circle-arrow-right >}} variabel yang **hanya menerima** *direct effect* pada variabel lain di dalam model yang sama

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/yBFOH8Ux7nHQA/giphy.gif)

:::
:::

---

## Contohnya...

::: {.columns}
::: {.column width="50%"}

* Seorang peneliti ingin **mengukur kepribadian** seorang responden dengan menggunakan pendekatan *Five-Factor Model* (Big 5), maka aitem dalam skala tersebut adalah *observed variable*, sedangkan dimensi dari Big 5 adalah *latent variable*.

* Seorang peneliti Psikologi Pendidikan ingin tahu apakah **kepercayaan orang tua bahwa anaknya dapat berkembang secara natural** (*trust in organismic development* — *independent latent variable*) berkorelasi dengan **tingkat kemandirian anak** (*dependent latent variable*).

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/d5fW0J4klfwnm/giphy.gif)

:::
:::

---

## Contohnya...

::: {.columns}
::: {.column width="50%"}

* Dalam konteks Psikologi Klinis, seorang pakar *public mental health* ingin tahu apakah **status sosio-ekonomi** (*observed independent variable*) dapat berdampak pada **kondisi kesehatan mental** individu (*latent dependent variable*).

* Dalam sebuah penelitian Psikologi Sosial, peneliti ingin tahu apakah **kepribadian seseorang** (*independent latent variable*) dapat menjelaskan mengapa orang **merespon pelanggaran moral** secara berbeda (*dependent latent variable*).

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/DxneCO38aK4Fi/giphy.gif)

:::
:::

---

## Model SEM

::: {.columns}
::: {.column width="50%"}

* Model regresi (linear/OLS)
  - Menguji hubungan antar variabel *observed*

* Model jalur (*path model*)
  - Menguji hubungan antara variabel *observed* dan *latent*

* Model pengukuran (*measurement model*/*confirmatory factor analysis*)
  - Menguji apakah aitem-aitem dari skala Psikologi memang mengukur konstruk tersebut {{< fa circle-arrow-right >}} validitas konstruk.

* SEM biasanya mengandung setidaknya dua model, yaitu model pengukuran dan model struktural (regresi/jalur).

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/SRNbNpKgJ03mOiYceA/giphy.gif)

:::
:::

---

## Mengapa SEM dilakukan?

* Peneliti sudah memiliki kesadaran bahwa ia harus menyelidiki **beberapa variabel penelitian** secara bersamaan untuk menjawab pertanyaan penelitiannya.

* Ada kesadaran bahwa peneliti selama ini mengabaikan faktor *error* pengukuran. SEM membantu peneliti untuk **mengurangi efek *measurement error*** terhadap hasil analisis data.

* Selama beberapa dekade kebelakang, SEM termasuk teknik analisis data yang sudah cukup **matang pengembangannya**, dan dapat mudah dilakukan dengan bantuan perangkat lunak.

* Perangkat lunak SEM sudah cukup *user-friendly*
  - `JASP` adalah perangkat lunak SEM yang hanya memerlukan *coding* yang sangat minimal.
  - Namun `JASP` fungsinya agak terbatas, karena tidak menyediakan opsi *power analysis* dan simulasi.
  - Selain itu, peneliti dapat menggunakan `Onyx`, `LISREL`, `AMOS`, `EQX`, `Mplus`, `STATA`, dsb.

* SEM adalah teknik yang lebih *sophisticated* untuk menggambarkan **hubungan antar-variabel** karena membuang **error pengukuran** dari estimasi korelasi.

---

## Yang tidak dicakup oleh *workshop* ini...

::: {.columns}
::: {.column width="50%"}

* *Exploratory factor analysis* (EFA)
* *A priori power analysis*, Monte Carlo *simulation*, dan *accuracy in parameter estimation* (AIPE)
* *Mixture model* (SEM untuk desain penelitian longitudinal) {{< fa circle-arrow-right >}} *latent growth curve*
* Model SEM dengan *missing data*
* Model SEM dengan variabel moderator/mediator
* Model SEM ketika variabel indikatornya *dichotomous*
* *Hierarchical latent variable model* (*second-order CFA*)
* SEM dengan model pengukuran formatif dan MIMIC

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/LpQuxhwDhzLCEKVYFh/giphy.gif)

:::
:::

---

## Ketika menggunakan SEM, maka asumsinya... {background-color="#14497F"}

::: {.columns}
::: {.column width="50%"}

### 🔊 Data berdistribusi normal (*multivariate*)
### 🔊 Korelasi antar variabel sifatnya linear

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/l4pTfqyI6TCjUW4Yo/giphy.gif)

:::
:::

---

## Normalitas data

* Mengapa data **tidak berdistribusi normal?**
  - Bisa jadi **bentuk datanya ordinal/nominal**, sehingga kalau menggunakan skala *Likert*, maka kemungkinan besar distribusi data menjadi tidak normal.
  - Jumlah sampel **terlalu sedikit**.
  - Distribusi data yang tidak normal akan berdampak pada *variance-covariance matrix*.

* Apa yang harus dilakukan?
  - Untuk **mengkoreksi distribusi data** yang juling (*skewness*), [***probit transformation***](http://methods.sagepub.com/Reference/the-sage-encyclopedia-of-educational-research-measurement-and-evaluation/i16518.xml) merupakan strategi yang terbaik.
  - Untuk mengkoreksi *kurtosis* yang tidak sesuai, membutuhkan prosedur yang agak lebih rumit. Beberapa diantaranya adalah dengan menambah jumlah responden, melakukan estimasi *standard error* dengan metode *bootstrapping*, atau bisa juga dengan menggunakan **metode estimasi** yang khusus untuk data yang tidak berdistribusi normal (*weighted least squares*).

---

## Terima kasih banyak! 😉 {.center}

![](https://media.giphy.com/media/hrBSJ2So6iTo4/giphy.gif)

Paparan disusun dengan menggunakan {{< fa brands r-project >}} dan [**Quarto**](https://quarto.org) dengan template dari [UNAIR Theme](https://github.com/rameliaz/quarto-unair-theme).
```

**Step 2: Commit**

```bash
git add slides/bagian-1.qmd
git commit -m "feat: add bagian-1 slide (Pengantar SEM)"
```

---

## Task 4: Create `slides/bagian-2.qmd` (Korelasi)

**Files:**
- Create: `slides/bagian-2.qmd`

**Step 1: Create the file**

```markdown
---
title: "Workshop MG-SEM Bagian 2"
subtitle: "Dies Natalis 36th — Korelasi"
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

## Mengapa memulai dari korelasi? {background-color="#14497F"}

. . .

#### SEM merupakan teknik yang digunakan untuk **mengestimasi korelasi** antar-variabel

. . .

#### Untuk melakukan SEM, peneliti tidak harus meng*input* data kasar (*raw data*), tetapi ada pilihan untuk meng*input* *correlation* atau *variance-covariance matrix*.

![](https://media.giphy.com/media/ChzfTLSi47FYc/giphy.gif)

---

## Jenis-jenis korelasi

| Koefisien Korelasi | Level Pengukuran |
| ------------------ | ---------------- |
| *Pearson's product moment* | Kedua variabel setidaknya interval |
| *Spearman's rank* dan *Kendall's tau* | Kedua variabel ordinal |
| *Phi*, *contingency table* | Kedua variabel nominal |
| *Point biserial* | Variabel interval dengan nominal |
| *Gamma*, *rank biserial* | Variabel ordinal dengan nominal |
| *Biserial* | Variabel interval dengan *dummy* |
| [*Polyserial*](https://link.springer.com/article/10.1007/BF02294164) | Variabel interval dengan variabel *underlying continuity* |
| *Tetrachoric* | Kedua variabel *dummy* (dikotomis) |
| *Polychoric* | Kedua variabel ordinal (dengan kontinuitas implisit) |

---

## Faktor-faktor yang mempengaruhi korelasi

* **Level pengukuran** (apakah variabel tersebut nominal, ordinal, interval, atau rasio)
  - Sehingga berdampak pada **variabilitas** (*restriction range*) dan **normalitas data**
* **Linearitas**
  - Semua teknik korelasi mengasumsikan korelasi antar-variabel linear, sehingga korelasi yang tidak linear akan memberikan informasi **tidak adanya korelasi** (padahal tidak selalu).
* **Adanya data *outlier***
* **Koreksi atenuasi**
* **Jumlah sampel**
  - Jumlah sampel yang terlalu sedikit akan memberikan estimasi yang kurang akurat (karena *standard error*nya besar)
* ***Sampling variance***
  - Yang kemudian bereffek pada *confidence interval*, *effect size*, dan *statistical power*
* ***Missing data***
  - Kalau data tidak lengkap, estimasi koefisien korelasi akan langsung terdampak.
  - Ada beberapa pilihan: {{< fa circle-arrow-right >}} *listwise deletion*, *pairwise deletion*, dan *data imputation*.
  - *Listwise deletion* tidak disarankan karena membuat jumlah sampel turun drastis {{< fa circle-arrow-right >}} mengurangi *statistical power*.

#### Silahkan unduh dan buka [**Dataset Korelasi**](https://rameliaz.github.io/mg-sem-workshop/corr.jasp), untuk melihat contoh.

---

## {.center}

![](https://i2.wp.com/peterjamesthomas.com/wp-content/uploads/2019/09/xkcd-extrapolating.png)

---

## *Variance-covariance* dan *correlation matrix* (1)

* Untuk melakukan SEM, maka perangkat lunak membutuhkan *variance-covariance matrix* untuk mengestimasi parameter model
* Pada bagian diagonal *variance-covariance matrix* menunjukkan varians, sedangkan sisanya adalah *covariance*

![](libs/varcovarmatrix.png){fig-align="center" width="50%"}

* Jumlah nilai unik (*non-redundant information*) dalam *variance-covariance matrix* adalah ***p*(*p*+1)/2**
  - dimana *p* adalah jumlah *observed variable*
  - Sehingga dengan contoh di atas maka jumlah nilai unik adalah 3(3+1)/2=6, yaitu **3 varians (diagonal)** dan **3 *covariance* (sisanya)**

---

## *Variance-covariance* dan *correlation matrix* (2)

::: {.columns}
::: {.column width="50%"}

* Sebagian besar perangkat lunak SEM menggunakan ***variance-covariance matrix*** bukan *correlation matrix*
  - Ingat ❗ korelasi adalah *standardised covariance*.

* Menggunakan *correlation matrix* biasanya lebih sering menghasilkan **parameter yang *statistically significant* tapi *standard error* yang tidak akurat**.

* Oleh karena itu, meskipun *user* meng*input* *correlation matrix*, maka perangkat lunak akan mengubahnya dulu menjadi *variance-covariance matrix*, baru parameter model dapat diestimasi.

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/l2Je34w7WkZ84f3os/giphy.gif)

:::
:::

---

## Koreksi Atenuasi

* Asumsi dasar dalam Psikometri adalah skor kasar (*observed score*) mengandung skor murni (*true score*) dan *measurement error*, sehingga dalam mengestimasi korelasi, *measurement error* perlu dibuang agar estimasi lebih akurat.

* Dengan teknik *koreksi atenuasi*, kita dapat 'membuang' *measurement error*, sehingga kita dapat mengestimasi korelasi antar-variabel menggunakan *true score*-nya.

* Tetapi apabila reliabilitas skala kita kurang baik, maka setelah dikoreksi **koefisien korelasi bisa lebih dari 1** ❗

* Misalnya diketahui bahwa korelasi *observed scores* antar dua variabel (*r*~ab~) adalah 0.9 dan reliabilitas skala *a* (Cronbach's α) adalah 0.6 dan skala *b* adalah 0.7, maka:

![](libs/cor-an.png){fig-align="center" width="20%"}

---

## WARNING! Covariance/correlation matrix is not positive definite {background-color="#14497F" .center}

![](libs/gosling-corr.jpg){fig-align="center"}

---

## Apa yang terjadi? {background-color="#14497F" .center}

#### Perangkat lunak akan menghentikan proses estimasi

#### ...dan memberikan pesan *non-positive definite*

![](https://media.giphy.com/media/SDogLD4FOZMM8/giphy.gif)

---

## Matrik korelasi dengan *non-positive definite*

* Koefisien korelasi yang nilainya ≥1 menyebabkan matriks korelasi menjadi *non-positive definite*
  - Artinya, parameter model tidak mungkin diestimasi

* Mengapa terjadi?
  - Data didapatkan dari observasi yang **tidak independen** (*linear dependency*)
  - Terjadi **multikolinearitas**
  - **Jumlah sampel** lebih **sedikit** dari jumlah variabel yang diuji dalam model
  - Sepasang variabel berbagi **varians negatif** atau **tidak sama sekali** (0) {{< fa circle-arrow-right >}} *Heywood case*
  - Varians, kovarians, dan korelasi nilainya diluar batas kewajaran
  - Kesalahan mengatur pembatasan (*constraint*) pada parameter tertentu

---

## *Heywood* dan *ultra-Heywood case*

* Terjadi ketika *communalities* = 1 (*Heywood*) atau ≥1 (*ultra-Heywood*), atau terjadi ketika varians *measurement error* bernilai negatif
  - *Communalities* adalah kuadrat dari koefisien korelasi (*R*^2^)
  - Apabila terjadi, maka ada yang salah dengan spesifikasi model (hipotesis)

* Terjadi karena
  - *Common factor* terlalu banyak/terlalu sedikit
  - Ukuran sampel tidak memadai
  - Model SEM bukan model yang cocok untuk menguji hipotesis (alternatifnya [*Principal Component Analysis*](https://medium.com/@aptrishu/understanding-principle-component-analysis-e32be0253ef0))

* Yang bisa dilakukan
  - Tinjau kembali hipotesis modelnya
  - Kurangi jumlah faktor laten dengan 'membuang' jalur/korelasi yang bermasalah
  - Identifikasi variabel yang terlibat multikolinearitas

---

## Korelasi Bivariat: *Part* dan *partial correlation*

![](libs/partial-cor.png){fig-align="center" width="50%"}

---

## Metrik variabel (*standardised* vs *unstandardised*)

* *Unstandardised solution/estimates*
  - Dapat **dibandingkan** antar kelompok sampel
  - Merupakan parameter yang digunakan oleh perangkat lunak untuk menghitung *standard error* dan *taraf signifikansi (p-value)*
  - Membandingkan *unstandardised factor loading* **harus melihat *standard error*nya juga**

* *Standardised solution/estimates*
  - Hanya *interpretable* untuk kelompok sampel yang diuji — tidak bisa dibandingkan dengan kelompok sampel yang lain.
  - Berguna untuk membandingkan *factor loading* antar-variabel di dalam model
  - Apabila variabel dalam model memiliki unit pengukuran yang berbeda, maka *standardised estimates* akan sangat membantu

* Ada banyak perbedaan pendapat mengenai metrik mana yang harus dilaporkan, tetapi...
  - **Selalu laporkan *unstandardised solution/estimates* dan *standard error*nya**

---

## TUGAS 1: Membuat *correlation matrix* dan melakukan *koreksi atenuasi*

### Demonstrasi

Menggunakan [Dataset Contoh Korelasi](https://rameliaz.github.io/mg-sem-workshop/corr.jasp)

[[Dataset]](https://rameliaz.github.io/mg-sem-workshop/corr.jasp) [[Matriks di Excel]](https://rameliaz.github.io/mg-sem-workshop/contoh-atenuasi.xlsx)

### TUGAS

* Apabila diketahui **reliabilitas skala** masing-masing dimensi Big 5 (neu=0.78, con=0.76, agr=0.34, ext=0.45, op=0.67), buatkan matriks korelasi antar-dimensi
* Lakukan koreksi atenuasi
* Apakah matriksnya *non-positive definite*? Variabel apa saja yang terlibat?
* Apa kira-kira yang menyebabkan kedua variabel tsb korelasinya *non-positive definite*?

[[Unduh Dataset]](https://rameliaz.github.io/mg-sem-workshop/latihancorr.csv) [[Kumpulkan Tugasnya Disini]](https://forms.gle/rS5HjhTAFBJnRYRA6)

---

## Terima kasih banyak! 😉 {.center}

![](https://media.giphy.com/media/hrBSJ2So6iTo4/giphy.gif)

Paparan disusun dengan menggunakan {{< fa brands r-project >}} dan [**Quarto**](https://quarto.org) dengan template dari [UNAIR Theme](https://github.com/rameliaz/quarto-unair-theme).
```

**Step 2: Commit**

```bash
git add slides/bagian-2.qmd
git commit -m "feat: add bagian-2 slide (Korelasi)"
```

---

## Task 5: Create `slides/bagian-3.qmd` (Model Jalur)

**Files:**
- Create: `slides/bagian-3.qmd`

**Step 1: Create the file**

```markdown
---
title: "Workshop MG-SEM Bagian 3"
subtitle: "Dies Natalis 36th — Model Jalur & lavaan"
author: "Rizqy Amelia Zein"
institute: "Universitas Airlangga"
date: today
format:
  unair-revealjs:
    slide-number: true
    progress: true
    transition: slide
    center: false
execute:
  eval: false
  echo: true
---

## {background-color="#14497F" .center}

![](https://media.giphy.com/media/MFCkrYZoqatqlJcQyh/giphy.gif)

### [Klik disini dan cari tahu apa yang terjadi..](https://kahoot.it/) ❤️

---

## Analisis jalur {background-color="#14497F"}

* *Path model* merupakan kelanjutan dari model regresi karena terdiri dari **beberapa model regresi** sekaligus dapat digunakan untuk menguji *direct*, *indirect*, dan *correlated effects*.

* *Path model* disusun secara visual dengan aturan tertentu (konsensus)
  - Garis satu arah menggambarkan *direct effects*, yang merefleksikan *keterkaitan langsung* antara satu variabel dengan variabel lainnya. Asumsinya, **tidak ada variabel lain diluar model** yang berkorelasi dengan variabel tersebut.
  - Garis dua arah menggambarkan *covariance*/korelasi, yang mengimplikasikan bahwa keterkaitan antar-variabel masih mungkin ditentukan oleh **variabel lain yang tidak ada di dalam model**.
  - Garis *error terms* yang menunjukkan varians *observed variable* yang menjelaskan **variabel lain yang tidak dapat dijelaskan/di luar model**, yang juga mewakili **measurement error**.

---

## Korelasi = kausalitas?

::: {.columns}
::: {.column width="50%"}

* Analisis jalur sebenarnya adalah **bentuk yang lebih *sophisticated*** dari korelasi, dan

### **Correlation does not imply causation**

Yang harus dipenuhi sebagai bukti kausalitas:
* Ada **urutan waktu** (*temporal order*) {{< fa circle-arrow-right >}} desain penelitian *panel*/*longitudinal*/*time series*
* Adanya **korelasi** antara kedua variabel
* Peneliti harus melakukan **kontrol** atas variabel lain
* Peneliti melakukan **manipulasi** pada variabel X

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/QWvcBw9qXs9wiVypPm/giphy.gif)

:::
:::

---

## Diagram jalur

![](libs/path-diagram.png){fig-align="center" width="40%"}

---

## Contoh {background-color="#14497F"}

::: {.columns}
::: {.column width="50%"}

Marimar adalah seorang wali murid di sebuah PAUD di Kota Surabaya. Pada suatu hari, ia mengamati seorang anak (dan orangtua) yang perilakunya menarik perhatiannya.

Ibu anak tersebut *ngotot* untuk menunggui anaknya di sekolah, padahal guru kelas meminta agar Ibu pulang saja, mempercayakan anak pada guru, dengan tujuan melatih kemandirian anaknya.

Melihat ibunya yang menggerutu karena diminta bu Guru pulang, si anak menangis meraung-raung tidak mau ditinggalkan. Akhirnya, terpaksa bu Guru membiarkan si Ibu menunggu di sekolah.

Marimar heran sekaligus penasaran, mengapa tiap anak **memberikan respon yang berbeda** ketika ditinggal orangtuanya di sekolah. Apakah ada kaitan antara kemandirian anak dengan karakteristik orangtuanya?

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/13xb3GPki9Kqdi/giphy.gif)

:::
:::

---

## Variabel yang diukur Marimar

* **trust** (variabel independen) = Kepercayaan ibu bahwa perkembangan anak dapat berlangsung secara natural ([**trust in organismic development**](https://link.springer.com/article/10.1007/s11031-008-9092-2)). Diukur dengan skala *likert* yang terdiri dari 5 aitem dengan 7 pilihan respon {{< fa circle-arrow-right >}} dari **sangat tidak setuju** sampai **sangat setuju**.

* **mandiri** (variabel dependen) = Tingkat kemandirian anak. Anak dengan skor yang tinggi semakin menunjukkan independensi dan lebih santai ketika ditinggal orangtuanya di sekolah. Diantaranya adalah:
  - Menangis ketika ditinggal orangtuanya
  - Merengek atau merajuk ketika ditinggal
  - Masuk ke dalam kelas tanpa ditemani
  - Menaruh tas dalam loker yang disediakan tanpa bantuan pengantar

### Bagaimana bentuk diagram jalurnya?

---

## {.center}

![](libs/contoh-path.png){fig-align="center" width="100%"}

---

## Nama variabel dan koefisien jalur

| Nama Variabel/Koefisien | Huruf Yunani | Huruf Latin |
| --------- | :------------: | :----------: |
| *Error* pengukuran dari variabel X | δ | Delta |
| *Error* pengukuran dari variabel Y | ε | Epsilon |
| Variabel eksogen | ξ | Ksi |
| Variabel endogen | η | Eta |
| *Direct effect* antara variabel laten dan indikatornya (*loading factor*) | λ | Lambda |
| *Direct effect* antara variabel endogen dan eksogen | γ | Gamma |
| *Direct effect* antara dua variabel laten | β | Beta |
| Korelasi (*covariance*) antara dua variabel laten | φ | Phi |
| Varians *error* pengukuran dari sebuah variabel laten | ζ | Zeta |

---

## Contoh model dengan koefisien jalur

![](libs/contoh-model.png){fig-align="center" width="100%"}

---

## TUGAS 2: Membuat diagram jalur

::: {.columns}
::: {.column width="50%"}

Fernando Jose sebal sekali karena ia kembali kehilangan pengokotnya dan ini kali ketiga ia kehilangan pengokot yang baru dibelinya seminggu yang lalu.

Teman-teman kerjanya memang punya kebiasaan buruk meminjam barang tanpa seijinnya. Ia akhirnya bertanya, apa yang menyebabkan teman-temannya berperilaku seperti itu?

Akhirnya ia menduga, mungkin ada kaitannya dengan faktor kepribadian (*conscientiousness*) rekan kerjanya dan usia karyawan.

Ia menduga temannya yang lebih *conscientious* dan lebih tua akan lebih kecil kemungkinannya melakukan perilaku tidak beradab. Ia juga mengamati bahwa semakin tua usia rekan kerjanya, biasanya mereka lebih *conscientious*.

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/OLdblIEmgpTb2/giphy.gif)

:::
:::

---

## Yang diukur...

* **con** = Kecenderungan *conscientiousness* karyawan. Makin tinggi skornya, karyawan lebih mungkin menunjukkan kehati-hatian dan keteraturan dalam bekerja. Diukur dengan skala *Likert* berisi 6 aitem dengan 10 pilihan jawaban.

* **incivil** = Intensitas perilaku tidak beradab. Makin besar skornya, karyawan akan lebih mungkin *emotionally abusive*, suka mengambil barang teman tanpa ijin, dan perilaku tidak pantas yang lain. Diukur dengan skala *Likert* berisi 4 aitem dengan 10 pilihan jawaban.

* **usia** = Usia partisipan

### Buatlah diagram jalur beserta koefisien jalurnya. Bisa dengan PowerPoint atau *software* yang lain.

[[Unggah file diagram jalur disini]](https://forms.gle/VpBzNxT26zXsBBAJ6)

---

## `lavaan` *Syntax*

* `JASP` mengadopsi *syntax* dari *package* [`lavaan`](http://lavaan.ugent.be/tutorial/index.html), sehingga untuk menjalankan programnya, kita harus memasukkan serangkaian perintah.

* Meskipun begitu, *syntax* `lavaan` sangat sederhana dan familiar dengan *syntax* `lavaan` memberikan banyak keuntungan.

* Menjalankan perintah dengan *syntax* juga membantu peneliti untuk mereka-ulang hasil analisis datanya, serta mempermudah kolaborasi dengan peneliti yang terbiasa menggunakan perangkat lunak yang berbeda dengan kita.

---

## Dasar *syntax* `lavaan`

![](libs/lavaan.png){fig-align="center" width="55%"}

::: {.aside}
Baujean, A.A. (2014). Latent Variable Modeling Using R: A step-by-step guide. New York: Routledge.
:::

---

## Contoh CFA (1)

![](libs/path-1.png){fig-align="center" width="80%"}

---

## {.center}

```{r}
#| eval: false

# CFA
trust =~ trust1 + trust2 + trust3 + trust4 + trust5

# Measurement error (residual)
trust1 ~~ trust1
trust2 ~~ trust2
trust3 ~~ trust3
trust4 ~~ trust4
trust5 ~~ trust5
trust ~~ trust
```

---

## Contoh CFA (2)

![](libs/path-2.png){fig-align="center" width="80%"}

---

## {.center}

```{r}
#| eval: false

# CFA
mandiri =~ mandiri1 + mandiri2 + mandiri3 + mandiri4

# Measurement error (residual)
mandiri1 ~~ mandiri1
mandiri2 ~~ mandiri2
mandiri3 ~~ trust3
mandiri4 ~~ mandiri4
mandiri ~~ mandiri
```

---

## Contoh *path analysis* (3)

![](libs/path-3.png){fig-align="center" width="80%"}

---

## {.center}

```{r}
#| eval: false

# Model Struktural
mandiri ~ trust

# Measurement error (residual)
mandiri ~~ mandiri
trust ~~ trust
```

---

## Contoh *full model* (4)

![](libs/contoh-path.png){fig-align="center" width="80%"}

---

## {.center}

```{r}
#| eval: false

# CFA
mandiri =~ mandiri1 + mandiri2 + mandiri3 + mandiri4
trust =~ trust1 + trust2 + trust3 + trust4 + trust5

# Measurement error (residual)
mandiri1 ~~ mandiri1
mandiri2 ~~ mandiri2
mandiri3 ~~ trust3
mandiri4 ~~ mandiri4

trust1 ~~ trust1
trust2 ~~ trust2
trust3 ~~ trust3
trust4 ~~ trust4
trust5 ~~ trust5

trust ~~ trust
mandiri ~~ mandiri

# Model Struktural
mandiri ~ trust
```

---

## TUGAS 3: Menulis *syntax* `lavaan`

### Tulislah *syntax* `lavaan` dari diagram jalur yang sudah dibuat di TUGAS 2

#### [Klik disini untuk mengisi lembar kerja](https://forms.gle/ARMzU4trUgqRv8hj9)

---

## Terima kasih banyak! 😉 {.center}

![](https://media.giphy.com/media/hrBSJ2So6iTo4/giphy.gif)

Paparan disusun dengan menggunakan {{< fa brands r-project >}} dan [**Quarto**](https://quarto.org) dengan template dari [UNAIR Theme](https://github.com/rameliaz/quarto-unair-theme).
```

**Step 2: Commit**

```bash
git add slides/bagian-3.qmd
git commit -m "feat: add bagian-3 slide (Model Jalur)"
```

---

## Task 6: Create `slides/bagian-4.qmd` (CFA)

**Files:**
- Create: `slides/bagian-4.qmd`

**Step 1: Create the file**

```markdown
---
title: "Workshop MG-SEM Bagian 4"
subtitle: "Dies Natalis 36th — Confirmatory Factor Analysis"
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

## Analisis faktor

::: {.columns}
::: {.column width="50%"}

* Awalnya dikembangkan oleh Charles Spearman (1904) untuk menyelidiki [*g factor theory of intelligence*](https://en.wikipedia.org/wiki/G_factor_(psychometrics))

* Terdiri dari:
  - *Exploratory factor analysis* (EFA)
  - *Confirmatory factor analysis* (CFA)

* Analisis faktor digunakan untuk menguji model *common variance*

* Mengasumsikan bahwa dua atau lebih *observed variable* memiliki *shared/common variance* (*commonality* atau *common factor*) {{< fa circle-arrow-right >}} ditunjukkan dengan ***factor loading***

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/l0IyjeA5mmMZjhyPm/giphy.gif)

:::
:::

---

## EFA vs CFA

| EFA | CFA |
| --- | --- |
| Mencari model yang cocok menggambarkan data, sehingga peneliti **mengeksplorasi berbagai pilihan model** yang cocok kemudian mencari rasionalisasi teoritisnya | Menguji hipotesis yang **sudah ditentukan sebelumnya**, sehingga peneliti ingin tahu apakah hipotesisnya didukung oleh data |
| Jumlah faktor belum diketahui sampai peneliti melakukan analisisnya | Jumlah faktor sudah ditentukan sebelum mengambil data |
| Peneliti **tidak memiliki** model yang dihipotesiskan *a priori* | Peneliti **sudah memiliki** model hipotesis yang ditentukan *a priori* |

---

## *Confirmatory factor analysis*

* Menyediakan solusi untuk mengkoreksi bias karena *measurement error* ketika mengestimasi korelasi antar-variabel

* Cara kerjanya adalah dengan membandingkan *variance-covariance matrix* yang dihipotesiskan dengan *variance-covariance matrix* pada data (sampel)

* **Perhatian** 📢
  - **Sangat tidak disarankan** untuk melakukan EFA kemudian CFA pada **sampel yang sama**
  - Karena *generating hypothesis* dengan *testing hypothesis* adalah dua proses yang berbeda yang **tidak seharusnya** dilakukan pada sampel yang sama
  - Kalau hal tsb dilakukan, maka tentu saja peneliti akan mendapatkan hasil yang 'sesuai prediksinya'
  - Ingat [Texas Sharpshooter Fallacy](https://en.wikipedia.org/wiki/Texas_sharpshooter_fallacy)

---

## {.center}

![](https://i0.wp.com/www.bayesianspectacles.org/wp-content/uploads/2018/01/TexasSharpShooter.png?fit=357%2C300&ssl=1)

---

## [*Constraining parameter* model](https://psycnet.apa.org/record/2008-06808-005)

* **Membatasi/menentukan varians** untuk setiap **variabel/faktor laten**
  - Dilakukan untuk mengeluarkan ***standardised estimates***
  - *Factor loading* di *z-score*kan
  - Sehingga *default*nya, *mean* variabel laten = 0, *variance* = 1

* Membatasi/menentukan ***error covariance*** untuk setiap variabel/faktor laten
  - Dilakukan untuk **menentukan *error variance***

---

## Jenis-jenis model pengukuran

* *Congeneric*
  - Model yang paling moderat dan *default* di berbagai perangkat lunak SEM
  - Asumsinya, **skala, *error variance*, dan *factor loading* boleh berbeda (dibebaskan)**
  - **Teknik reliabilitas skala** yang mengasumsikan model pengukuran *congeneric* {{< fa circle-arrow-right >}} ω, McDonald's ω, ω total (ω~*t*~), Revelle's ω, *composite reliability*.

* *Tau equivalence*
  - Model yang sedikit lebih rigid daripada *congeneric*
  - Asumsinya, **skala dan *error variance* boleh berbeda (dibebaskan)**, namun ***factor loading* harus sama (dibatasi)**
  - Ketika asumsi *tau equivalence* dipenuhi, maka [Cronbach's α dapat digunakan](https://www.ncbi.nlm.nih.gov/pubmed/28557467)
  - **Teknik reliabilitas**: Formula Rulon, KR-20, Flanagan-Rulon, Guttman's λ~3~, λ~4~, Hoyt *method*.

* Paralel
  - Model yang paling rigid
  - Asumsinya, **skala, *error variance*, dan *factor loading* harus sama (dibatasi)**
  - **Teknik reliabilitas**: Spearman-Brown's Formula, Standardised α.

---

## {.center}

![](libs/congeneric.png){fig-align="center"}

---

## {.center}

![](libs/tau.png){fig-align="center"}

---

## {.center}

![](libs/paralel.png){fig-align="center"}

---

## Reflektif vs Formatif

* Reflektif
  - **Variabel laten menjelaskan** mengapa **variabel indikator bervariasi**
  - Misalnya {{< fa circle-arrow-right >}} individu dengan intelegensi yang tinggi akan mendapatkan nilai yang berbeda dalam tes matematika
  - Biasanya mengasumsikan bahwa **korelasi antar-variabel indikator = 0**

* Formatif
  - **Variabel *observed* menjelaskan** mengapa **variabel laten bervariasi**
  - Misalnya {{< fa circle-arrow-right >}} gengsi sebuah mobil ditentukan oleh usia mobil, kondisi, harga, dan intensitas pemakaian
  - Korelasi antara variabel *observed* tidak diketahui
  - Biasanya digunakan untuk menentukan indeks pada konstruk yang *orthogonal* (contoh {{< fa circle-arrow-right >}} kepribadian pada *Five Factor model*)

---

## {.center}

![](libs/reflektif.png){fig-align="center"}

---

## {.center}

![](libs/formatif.png){fig-align="center" width="60%"}

---

## Apa yang terjadi ketika *error variance* berkorelasi?

![](libs/correlated-error.png){fig-align="center"}

* Kedua variabel indikator tersebut mengukur variabel laten lain di luar model (*unique factor*)
* Bisa jadi karena ada aitem *unfavourable* dalam skala
* Kemungkinan konstruk laten **bukan konstruk tunggal** (multidimensi)
* Perhatikan justifikasi teori ketika menambah *error covariance*

---

## Skor faktor (*factor scores*)

* Apabila kita memiliki informasi tentang *factor loading*, maka kita bisa menghitung *factor scores* {{< fa circle-arrow-right >}} **estimasi** (*fitted*) skor variabel laten

* Caranya dengan mengali *factor loading* dengan skor kasar {{< fa circle-arrow-right >}} metode regresi

* Namun ingat, mengalikan *factor loading* dengan skor kasar **masih berisiko mendapatkan estimasi yang bias**. Itulah yang menyebabkan *factor scores* akan berubah ketika model diujikan pada kelompok sampel yang berbeda.

* Ada tiga cara yang bisa digunakan untuk menghitung *factor scores*:
  - **Metode Regresi** {{< fa circle-arrow-right >}} dengan mengoptimalisasi validitas konstruk (*variance explained*)
  - **Metode Bartlett** {{< fa circle-arrow-right >}} mengasumsikan variabel indikator **tidak saling berkorelasi**
  - **Metode Anderson-Rubin** {{< fa circle-arrow-right >}} mengasumsikan variabel indikator **saling berkorelasi**

---

## Memilih metode estimasi

* *Maximum Likelihood* {{< fa circle-arrow-right >}} distribusi data (*multivariate*) normal, level pengukuran harus interval, tidak ada data *missing*

* *Generalized least squares* {{< fa circle-arrow-right >}} menggunakan asumsi yang sama dengan `ML` namun performanya kurang baik apabila dibandingkan dengan `ML`

* *Weighted least squares* {{< fa circle-arrow-right >}} dapat digunakan pada data kategorikal (nominal dan ordinal), estimasi menggunakan *polychoric correlation matrix*

* *Diagonally weighted least squares* {{< fa circle-arrow-right >}} dapat digunakan pada data kategorikal, bekerja dengan baik pada sampel yang relatif kecil dan data yang tidak berdistribusi normal

---

## Demonstrasi CFA {background-color="#14497F" .center}

![](https://media.giphy.com/media/3oEjHZPivwdJ0syhKE/giphy.gif)

### [Unduh Dataset Contoh CFA](https://rameliaz.github.io/mg-sem-workshop/contoh-cfa.jasp)

---

## TUGAS 4: Mencoba *confirmatory factor analysis*

* Unduh [Dataset Latihan SEM](https://rameliaz.github.io/mg-sem-workshop/dataset-wave1.csv)

* Unduh [Kamus Data disini](https://rameliaz.github.io/mg-sem-workshop/codebook-kamusdata.xlsx)

* Lakukan CFA pada skala *right-wing authoritarianism*
  - Diukur dengan skala *Likert*, 15 aitem dengan 9 pilihan jawaban

* Laporkan *model fit*, *factor loading*, dan *multivariate normality*

* Lakukan penyesuaian apabila perlu

* *Export* datasetnya menjadi `.htm` kemudian

### [Kumpulkan tugasnya disini](https://forms.gle/eNGD2LSzqaZc2nXM7)

---

## Terima kasih banyak! 😉 {.center}

![](https://media.giphy.com/media/hrBSJ2So6iTo4/giphy.gif)

Paparan disusun dengan menggunakan {{< fa brands r-project >}} dan [**Quarto**](https://quarto.org) dengan template dari [UNAIR Theme](https://github.com/rameliaz/quarto-unair-theme).
```

**Step 2: Commit**

```bash
git add slides/bagian-4.qmd
git commit -m "feat: add bagian-4 slide (CFA)"
```

---

## Task 7: Create `slides/bagian-5.qmd` (Dasar SEM)

**Files:**
- Create: `slides/bagian-5.qmd`

**Step 1: Create the file**

```markdown
---
title: "Workshop MG-SEM Bagian 5"
subtitle: "Dies Natalis 36th — Dasar-Dasar SEM"
author: "Rizqy Amelia Zein"
institute: "Universitas Airlangga"
date: today
format:
  unair-revealjs:
    slide-number: true
    progress: true
    transition: slide
    center: false
execute:
  eval: false
  echo: true
---

## Pengantar SEM

* SEM adalah *full model* {{< fa circle-arrow-right >}} menggabungkan **model pengukuran** dengan **model jalur/struktural**

* Ada beberapa pendekatan dalam SEM
  - ***Strictly confirmatory*** {{< fa circle-arrow-right >}} untuk menguji apakah ***variance-covariance matrix*** yang dihipotesiskan (*implied*) sama dengan/didukung oleh data (***observed variance-covariance matrix***)

  - ***Alternative model*** {{< fa circle-arrow-right >}} membuat model alternatif dari dataset yang sama, sehingga kemungkinan struktur datanya berjenjang (*nested*) {{< fa circle-arrow-right >}} ***multigroup CFA/SEM***

  - ***Model generating*** {{< fa circle-arrow-right >}} dilakukan ketika peneliti sudah punya hipotesis model, namun melakukan modifikasi untuk meningkatkan *fit statistics* {{< fa circle-arrow-right >}} *specification search*

---

## Langkah-langkah melakukan analisis SEM {background-color="#14497F"}

::: {.columns}
::: {.column width="50%"}

* Spesifikasi model

* Identifikasi model

* Estimasi model

* Menguji model

* Memodifikasi model

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/3o752ogcifnC3MECt2/giphy.gif)

:::
:::

---

## Spesifikasi model

::: {.columns}
::: {.column width="50%"}

* Peneliti menyusun model pengukuran dan model jalur dengan menggambar diagram jalur *path diagram*

* Dalam SEM, justifikasi teori adalah suatu yang **tidak bisa ditawar-tawar** karena tanpa basis teori yang kuat, *model testing* akan selalu memberikan hasil yang mengecewakan (*poor fit*)

* Sebelum melakukan SEM, peneliti sangat disarankan melakukan *preliminary study*, atau setidaknya *systematic review* yang dapat membantu peneliti menyusun hipotesis model yang baik

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/bp5U3nfEYnl9S/giphy.gif)

:::
:::

---

## Identifikasi model

* Model dapat diidentifikasi apabila ***degree of freedom* (*df*) ≥ 0**

* Apabila *df* = 0, maka model tsb adalah *saturated model* atau *just-identified model*
  - Jumlah **'informasi yang diketahui'** dan **'tidak diketahui'** sama persis
  - Tidak bisa difalsifikasi, hampir 'selalu tepat', tetapi 'selalu salah'

* Apabila *df* bernilai negatif, maka model tsb *under-identified* karena jumlah parameter jalur yang harus diestimasi lebih banyak daripada jumlah parameter di *variance-covariance matrix*
  - Lebih banyak **'informasi yang tidak diketahui'** daripada yang **'diketahui'**
  - Model 'misterius' 😄

* Model yang dapat diidentifikasi adalah *over-identified model* dimana **jumlah parameter *variance-covariance matrix* lebih banyak daripada jumlah parameter jalur yang diestimasi** (sehingga *df* ≥ 1)
  - Lebih banyak **'informasi yang diketahui'** daripada yang **'tidak diketahui'**

* *Degree of freedom* {{< fa circle-arrow-right >}} dihitung dengan mengurangi jumlah nilai unik (*non-redundant information*) dalam *variance-covariance matrix* dengan jumlah parameter jalur yang hendak diestimasi

---

## Over-identified model

::: {.columns}
::: {.column width="50%"}

![](libs/over.png){fig-align="center"}

:::
::: {.column width="50%"}

* Pada model ini **jumlah nilai unik (*non-redundant information*)** dalam *variance-covariance matrix* = 5(5+1)/2 = 15

* Sedangkan **jumlah parameter jalur** yang akan diestimasi adalah 11 (5 *factor loading*, 6 *error variance*), sehingga

* *df* = 15-11 = 4 🥇

* Model **dapat diidentifikasi** karena memenuhi syarat (*over-identified*)

:::
:::

---

## Under-identified model

::: {.columns}
::: {.column width="50%"}

![](libs/under.png){fig-align="center"}

:::
::: {.column width="50%"}

* Pada model ini **jumlah nilai unik (*non-redundant information*)** dalam *variance-covariance matrix* = 3(3+1)/2 = 6

* Sedangkan **jumlah parameter jalur** yang akan diestimasi adalah 7 (3 *factor loading*, 4 *error variance*), sehingga

* *df* = 6-7 = -1 😢

* Model **tidak dapat diidentifikasi** karena tidak memenuhi syarat (*under-identified*)

:::
:::

---

## Just-identified model

::: {.columns}
::: {.column width="50%"}

![](libs/just.png){fig-align="center"}

:::
::: {.column width="50%"}

* Pada model ini **jumlah nilai unik (*non-redundant information*)** dalam *variance-covariance matrix* = 2(2+1)/2 = 3

* Sedangkan **jumlah parameter jalur** yang akan diestimasi adalah 3 (3 *factor loading*, 3 *error variance*), sehingga

* *df* = 6-6 = 0 😢

* Model **tidak dapat diidentifikasi** karena tidak ada ruang tersisa untuk melakukan estimasi (*just-identified*/*saturated model*)

:::
:::

---

## Kesimpulan 🏫

* Untuk satu faktor/variabel laten, kita perlu **sedikitnya 4 variabel indikator** karena apabila ≤3, maka model akan *just-identified* atau *under-identified*

* Tapi meskipun kita punya 4 variabel indikator untuk 1 variabel laten, kita masih mungkin memiliki model yang *just-identified*, ketika *error*nya berkorelasi

* Apakah bisa 1 variabel laten diukur oleh 1 *observed variable*?

---

## Variabel laten dengan 1 indikator

::: {.columns}
::: {.column width="50%"}

* Masih bisa diestimasi dengan asumsi

  - Aitem diasumsikan memiliki [reliabilitas](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3475500/) sempurna, sehingga varians *error* di*constraint* = 0
  - Reliabilitas diukur dengan *test-retest*, kemudian varians *error* di*constraint* dengan mempertimbangkan reliabilitas dan standar deviasi

:::
::: {.column width="50%"}

![](libs/single-item.png){fig-align="center"}

:::
:::

---

## Mengestimasi & Menguji model

* Pilih **metode estimasi** yang paling cocok dengan karakteristik data (`ML`, `ULS`, `GLS`, `WLS`, `DWLS` atau *robust* `DWLS`)

* Metode estimasi ini yang akan menghitung *standard error*, apabila metode estimasi yang dipilih tidak tepat dan tidak sesuai dengan kompatibilitas datanya, maka estimasi *standard error* menjadi bias {{< fa circle-arrow-right >}} model memberikan informasi yang menyesatkan

---

## Menguji ketepatan model

* Umumnya peneliti ingin mendapatkan 3 informasi
  - ***Chi-square* sebagai *global fit measure***. *Chi-square* menguji perbedaan antara *model-implied* dengan *sample covariance matrix*. Apabila *p-value* dari *Chi-square* ≥ α (dengan α=0.05), maka **tidak ada perbedaan** antara keduanya {{< fa circle-arrow-right >}} data mendukung model

  - ***p-value* dari *factor loading*** untuk setiap variabel dalam model.

  - **Besar dan arah *factor loading***. Besar *factor loading* memberikan informasi mengenai *magnitude* dan kontribusi variabel tersebut dalam menjelaskan variabel lainnya. Sedangkan arah *factor loading* (positif/negatif) memberikan informasi mengenai arah hubungan

---

## Menguji ketepatan model: *Chi-square* (*X*^2^)

::: {.columns}
::: {.column width="50%"}

* Dihitung dengan cara membandingkan ***saturated model* dengan model tanpa jalur sama sekali** (*baseline*, *null*, atau *independent model*)

* Selain *X*^2^, kita bisa menggunakan *alternative fit indices* yang terdiri dari
  - *Incremental index*
  - *Parsimony index*
  - *Absolute (standalone) index*

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/xT0xeuOy2Fcl9vDGiA/giphy.gif)

:::
:::

---

## *Incremental (comparative/relative) index*

* Didapatkan dengan membandingkan *implied model* dengan *baseline model*, meliputi
  - ***Comparative Fit Index*** {{< fa circle-arrow-right >}} mendekati 1 = *closer fit*

  - ***Normed Fit Index*** {{< fa circle-arrow-right >}} mendekati 1 = *better fit*

  - ***Parsimonious Normed Fit Index*** {{< fa circle-arrow-right >}} NFI yang mempertimbangkan *parsimony* model, mendekati 1 = *better fit*

  - ***Incremental Fit Index*/*Bollen's Nonnormed Fit Index*** {{< fa circle-arrow-right >}} mendekati 1 = *better fit*

  - ***Tucker Lewis Index*/*Bentler-Bonnet Non-Normed Fit Index*** {{< fa circle-arrow-right >}} mendekati 1 = *better fit*

---

## *Parsimony index*

* Indeks ini secara khusus memberikan pinalti pada kompleksitas model

* Indeks-indeksnya meliputi
  - ***Expected Cross Validation Index*** {{< fa circle-arrow-right >}} digunakan untuk membandingkan dua model atau lebih. Nilai yang lebih kecil menunjukkan model yang lebih baik
  - ***Information-Theoretic Criterion*** {{< fa circle-arrow-right >}} meliputi AIC, BIC, dan SABIC. Nilai yang kecil menunjukkan model yang lebih baik
  - ***Noncentrality Parameter-based Index*** {{< fa circle-arrow-right >}} mendekati 1 = *better fit*
  - ***McDonald's Noncentrality Index*** {{< fa circle-arrow-right >}} mendekati 1 = *better fit*

* **Yang paling sering digunakan adalah**...

* ***Root Mean Square Error of Approximation* (RMSEA)** {{< fa circle-arrow-right >}} Model ***close fit*** ketika nilainya **0.05 - 0.08**
  - *P-value* dapat digunakan untuk menolak *H*~0~: RMSEA = 0.05
  - Oleh karena itu, **menolak *H*~0~** menunjukkan bahwa model "*close-fitting*"

---

## *Absolute index*

* Indeks ini dihitung tanpa melakukan perbandingan dengan *baseline*

* Meliputi
  - ***Chi-square*** (*X*^2^)/*df* ratio
  - ***Goodness of Fit Index*** {{< fa circle-arrow-right >}} mendekati 1 = *better fit*
  - ***Adjusted Goodness of Fit Index*** {{< fa circle-arrow-right >}} merupakan *parsimony adjustment* dari GFI, mendekati 1 = *better fit*
  - ***Parsimony Goodness of Fit Index*** {{< fa circle-arrow-right >}} mendekati 1 = *better fit*
  - ***Hoelter's Critical n*** {{< fa circle-arrow-right >}} nilainya sebaiknya > 200
  - ***Standardized Root Mean Square Residual*** (SRMR/RMR) {{< fa circle-arrow-right >}} nilai < 0.05 menunjukkan *good fit*

---

## *Parameter fit*

* Parameter jalur bisa ditolak meskipun hasil *omnibus test* memuaskan, sehingga menginterpretasi koefisien jalur adalah proses yang juga harus dilakukan.

* Berikut ini adalah beberapa prosedur yang direkomendasikan:
  - Lihat tanda *factor loading*, apakah **arahnya sudah benar** (negatif/positif)

  - Lihat *standardised parameter estimates* untuk tahu apakah ada *factor loading* yang **nilainya diatas kewajaran**

  - Lihat *p-value* untuk mempertimbangkan **menolak *H*~0~**

  - Lakukan pengujian *measurement invariance* dengan mengasumsikan beberapa *factor loading* sama di berbagai kelompok yang berbeda

  - Apabila *error variance* mendekati nol, hal tsb lebih mungkin disebabkan oleh adanya *outlier*, kurangnya jumlah sampel, atau kurangnya jumlah indikator

---

## *Statistical power*

* *Statistical power* dalam pengujian hipotesis dalam SEM {{< fa circle-arrow-right >}} peluang mempertahankan *H*~0~ apabila *H*~0~ benar
  - Peluang peneliti secara tepat menyimpulkan bahwa **tidak ada perbedaan antara *implied model* dengan *observed model*** ketika memang **benar-benar tidak ada perbedaan** diantara keduanya

* *Statistical power* ditentukan oleh
  - **true population model** (yang kita tidak mungkin tahu)
  - **probabilitas melakukan kesalahan tipe 1** (α)
  - ***degree of freedom*** model
  - **jumlah sampel**

---

## Mengestimasi jumlah sampel dengan `semTools`

::: {.columns}
::: {.column width="50%"}

![](libs/over.png){fig-align="center"}

:::
::: {.column width="50%"}

```{r}
#| eval: false

semTools::findRMSEAsamplesize(
  rmsea0 = 0.05,
  rmseaA = 0.08,
  df = 4,
  power = 0.90,
  alpha = 0.05
)
```

:::
:::

---

## Dua vs empat langkah

* Dua langkah menyusun model [(Anderson & Gerbing, 1988)](https://psycnet.apa.org/record/1989-14190-001)
  - *Measurement* model
  - *Structural* model

* Empat langkah menyusun model [(Mulaik & Millsap, 2000)](https://www.tandfonline.com/doi/abs/10.1207/S15328007SEM0701_02)
  - Menspesifikasikan **model pengukuran** yang *unrestricted* dengan **melakukan EFA** untuk **mengidentifikasi jumlah faktor**
  - Spesifikasikan **model CFA yang menguji model pengukuran** sebuah konstruk laten pada **kelompok sampel yang berbeda**
  - Spesifikasikan **hubungan antar-variabel laten** di dalam model (model struktural)
  - Tentukan **parameter *acceptable fit*** untuk model struktural, misalnya CFI > .95 dan RMSEA < 0.05

---

## [JARS APA](http://doi.apa.org/getdoi.cfm?doi=10.1037/amp0000191): Apa saja yang harus dilaporkan?

* **Abstrak**
  - Laporkan setidaknya **2 *global fit statistics*** (X^2^ [df, *p-value*], RMSEA/GFI/AGFI/TLI, BIC, AIC, dll)

* **Metode**
  - Deskripsikan **variabel endogen dan eksogennya**
  - Berikan penjelasan, untuk setiap instrumen/variabel, apakah **indikator atau total skor** diperoleh dari **aitem yang homogen (*item parceling*)**
  - Berikan penjelasan **bagaimana skala/instrumen disusun**, laporkan **properti psikometriknya**, serta penjelasan mengenai **level pengukuran**
  - Laporkan bagaimana cara peneliti **menentukan jumlah sampel** (*rule of thumb*, *a priori power analysis* atau simulasi Monte Carlo)

---

## [JARS APA](http://doi.apa.org/getdoi.cfm?doi=10.1037/amp0000191)

* **Hasil penelitian**

  - ***Data diagnostics*** {{< fa circle-arrow-right >}} % data *missing*, distribusi data *missing* di semua variabel

  - ***Missingness*** {{< fa circle-arrow-right >}} apabila ada data *missing*, maka peneliti harus menganalisis apakah data *missing*nya MCAR, MAR atau MNAR, kemudian bagaimana cara peneliti menangani data *missing*

  - **Distribusi data** {{< fa circle-arrow-right >}} data normal/non-normal? Laporkan *multivariate normality*

  - ***Data summary*** {{< fa circle-arrow-right >}} *summary statistics* yang bisa digunakan orang lain untuk melakukan replikasi, bisa ***variance-covariance*** atau ***correlation matrix***

---

## [JARS APA](http://doi.apa.org/getdoi.cfm?doi=10.1037/amp0000191)

* **Spesifikasi model**

  - Jelaskan apakah model ***strictly confirmatory***, ***comparison***, atau ***model generation***

  - Buat diagram jalur. Bedakan antara variabel ***constrained***, ***fixed/free***, ***observed*** dan ***latent variables***

  - Kalau model yang diuji adalah bagian dari model yang lebih besar, jelaskan rasionalisasinya

  - Kalau ada ***residual correlation pada error***, ***interaction effect*** atau ***nonindependence***, jelaskan rasionalisasinya

  - Kalau membandingkan model, jelaskan parameter yang akan digunakan untuk membandingkan

---

## [JARS APA](http://doi.apa.org/getdoi.cfm?doi=10.1037/amp0000191)

* **Estimasi**
  - Jelaskan *software* dan versi yang digunakan, dan jelaskan **metode estimasi** yang digunakan

  - Jelaskan ***default criteria*** di *software* yang digunakan

* ***Model fit***
  - Laporkan ***omnibus (global) fit statistics***nya dan diinterpretasikan artinya.

  - Laporkan ***local fit*** dan *indicator estimates* (*factor loading*)
  - Kalau membandingkan antara dua model, jelaskan parameter yang digunakan

* **Respesifikasi**
  - Jelaskan prosedur modifikasi model
  - Jelaskan rasionalisasi teorinya ketika peneliti melakukan modifikasi dan bandingkan dengan model yang sebelumnya

---

## Demonstrasi SEM

::: {.columns}
::: {.column width="50%"}

* Buka `JASP` dan buka dataset **Political Democracy**

* `Data Library` {{< fa circle-arrow-right >}} SEM {{< fa circle-arrow-right >}} pilih **Political Democracy**

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/PlQ5TTRt1IhsA/giphy.gif)

:::
:::

---

## TUGAS 5: Membuat dan melaporkan SEM

* Unduh [Dataset Latihan SEM](https://rameliaz.github.io/mg-sem-workshop/dataset-wave1.csv)

* Unduh [Kamus Data disini](https://rameliaz.github.io/mg-sem-workshop/codebook-kamusdata.xlsx)

* Silahkan spesifikasi model SEM dari variabel yang tersedia di dataset. Satu model sedikitnya mengandung 2 variabel laten.

* *Export* datasetnya menjadi `.htm` kemudian

### [**Unggah tugasnya di sini**](https://forms.gle/4cMP9s3HPPvGPwg47)

---

## Terima kasih banyak! 😉 {.center}

![](https://media.giphy.com/media/hrBSJ2So6iTo4/giphy.gif)

Paparan disusun dengan menggunakan {{< fa brands r-project >}} dan [**Quarto**](https://quarto.org) dengan template dari [UNAIR Theme](https://github.com/rameliaz/quarto-unair-theme).
```

**Step 2: Commit**

```bash
git add slides/bagian-5.qmd
git commit -m "feat: add bagian-5 slide (Dasar SEM)"
```

---

## Task 8: Create `slides/bagian-6.qmd` (MG-SEM)

**Files:**
- Create: `slides/bagian-6.qmd`

**Step 1: Create the file**

```markdown
---
title: "Workshop MG-SEM Bagian 6"
subtitle: "Dies Natalis 36th — Multigroup SEM"
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

## *Multigroup* SEM: untuk apa?

* *Invariance* {{< fa circle-arrow-right >}} apakah dalam kondisi yang beragam ketika melakukan pengukuran, alat ukur selalu mengukur atribut ukur yang sama

* *Measurement invariance* {{< fa circle-arrow-right >}} dua atau lebih kelompok memiliki model pengukuran yang sama, yaitu variabel laten dalam model pengukuran adalah konstruk yang sama

* Ketika membandingkan model pengukuran di dua atau lebih kelompok yang berbeda, untuk menyimpulkan terjadinya *invariance*, maka peneliti akan menginginkan *chi-square* (*X*^2^) yang *p-value*nya ≤ α

* Kalau kita berniat melakukan perbandingan performa alat ukur di dua kelompok sampel yang berbeda, maka kita lebih baik menggunakan ***means-covariance matrix*** bukan *variance-covariance matrix* {{< fa circle-arrow-right >}} ingat *t-test* dan *anova*

---

## *Means* dan *intercept*

::: {.columns}
::: {.column width="50%"}

* Kalau kita masukkan *mean* variabel laten ke dalam model, maka ***intercept*nya juga harus dimasukkan dalam model**

* *Mean* dan *intercept* adalah ukuran *lokasi variabel*, dimana...
  - ***Mean*** adalah komponen ***common factor***
  - ***Intercept*** adalah komponen ***unique factor***

* *Intercept* disimbolkan dengan segitiga dan
  - **Hanya boleh "ketemu"** dengan panah *uni-directional* dan sifatnya *backwards*

:::
::: {.column width="50%"}

![](libs/meansintercept.png){fig-align="center"}

:::
:::

---

## Jenis-jenis *measurement invariance*

* *Configural*
  - Jenis ini adalah yang paling dasar, yang mengasumsikan bahwa **model memiliki struktur yang sama** di **semua kelompok**
  - Oleh karena itu, semua kelompok **harus** memiliki **jumlah faktor/variabel laten** dan **jumlah variabel indikator/*observed* yang sama**
  - **Tidak ada ketentuan** bahwa parameter di dalam model harus setara di semua kelompok {{< fa circle-arrow-right >}} tidak ada *between-group comparison*
  - Untuk mengeksekusi *configural invariance* tinggal menambahkan `grouping variable` di `JASP` pada bagian **options**

* *Weak*/*metric*
  - ***Factor loading* harus sama** pada setiap kelompok, tetapi **varians variabel laten boleh bervariasi**
  - Dinamai *weak* karena asumsinya masih lemah untuk menyimpulkan bahwa faktor laten **ekuivalen** di semua kelompok
  - Untuk mengeksekusinya tambahkan `grouping variable` di `JASP` dan tik pilihan `loadings` pada `equality constraints`

---

## Jenis-jenis *measurement invariance*

* *Strong*/*scalar*
  - **Selain *factor loading* harus sama**, *strong invariance* mensyaratkan ***intercept* harus sama juga**
  - Ketika membatasi/*constraining* *intercept*, maka *means* boleh bervariasi di berbagai kelompok
  - Dengan asumsi *strong invariance* ekuivalensi variabel laten lebih didukung bukti yang kuat
  - Untuk mengeksekusinya tambahkan `grouping variable` di `JASP` dan tik pilihan `loadings` dan `intercept` pada `equality constraints`

* *Strict*/*residuals*
  - **Selain *factor loading* dan *intercept* harus sama**, *strict invariance* mensyaratkan ***varians error*/*residual* sama juga**
  - Biasanya asumsi ini **tidak terlalu diperlukan** untuk membandingkan variabel laten di masing-masing kelompok
  - Untuk mengeksekusinya tambahkan `grouping variable` di `JASP` dan tik pilihan `loadings`, `intercept`, dan `residuals` pada `equality constraints`

---

## Jenis-jenis *measurement invariance*

* Homogenitas varians variabel laten
  - Untuk melihat apakah **varians variabel laten setara** di masing-masing kelompok
  - Kalau tidak terpenuhi berarti kelompok dengan varians variabel laten yang **lebih kecil** menggunakan **rentang konstruk yang lebih sempit**
  - Untuk mengeksekusinya pada `grouping variable` di `JASP` tik pilihan `latent variances`

* Homogenitas *factor means*
  - Untuk melihat **apakah ada perbedaan *mean* variabel laten** di masing-masing kelompok
  - Prosedur yang sama dengan `anova` atau `t-test`
  - Untuk mengeksekusinya pada `grouping variable` di `JASP` tik pilihan `means`

---

## Evaluasi *measurement invariance*

#### Umumnya ada dua cara yaitu

* **Pendekatan statistik**
  - Karena struktur data yang hirarkis, maka untuk mengevaluasi *invariance* perlu beberapa langkah
  - Dalam pendekatan statistik, peneliti dapat mengevaluasi **perubahan *X*^2^** (Δ*X*^2^) ketika membandingkan model antar kelompok
  - Seharusnya ketika pembatasan model ditambah, maka Δ*X*^2^ tidak signifikan, sehingga seharusnya *p-value* dari Δ*X*^2^ > α (misalnya 0.05)

* **Pendekatan *modeling***
  - Pendekatan *modeling* menggunakan *approximate fit indices* (AFI) untuk menyimpulkan *invariance*
  - Yang bisa digunakan adalah *comparative fit index* (CFI) dan *McDonald's noncentrality fit index* (MFI), sehingga ketika **keduanya mendekati 1**, kita dapat simpulkan *invariance* ✅

---

## {.center}

![](libs/invariance.png){fig-align="center" width="80%"}

::: {.aside}
Baujean, A.A. (2014). Latent Variable Modeling Using R: A step-by-step guide. New York: Routledge.
:::

---

## Demonstrasi *multigroup SEM* {background-color="#14497F"}

::: {.columns}
::: {.column width="50%"}

### [Klik untuk unduh datasetnya disini](https://rameliaz.github.io/mg-sem-workshop/dataset-mg.csv)

### Atau pada repositori, unduh [**Dataset Contoh Multigroup SEM**](https://rameliaz.github.io/mg-sem-workshop/dataset-mg.csv)

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/l4pLXMFYQmTM2se7m/giphy.gif)

:::
:::

---

## TUGAS 6 (terakhir 🙏): Mencoba *multigroup* SEM

::: {.columns}
::: {.column width="50%"}

* Unduh [Dataset Latihan SEM](https://rameliaz.github.io/mg-sem-workshop/dataset-wave1.csv)

* Unduh [Kamus Data disini](https://rameliaz.github.io/mg-sem-workshop/codebook-kamusdata.xlsx)

* Cek *measurement invariance* pada skala *right-wing authoritarianism* antara laki-laki dan perempuan

* *Export* datasetnya menjadi `.htm` kemudian

### [**Unggah tugasnya di sini**](https://forms.gle/6tdDH7Fin4xp7aL96)

:::
::: {.column width="50%"}

![](https://media.giphy.com/media/l1KVaj5UcbHwrBMqI/giphy.gif)

:::
:::

---

## Terima kasih banyak! 😉 {.center}

![](https://media.giphy.com/media/hrBSJ2So6iTo4/giphy.gif)

Paparan disusun dengan menggunakan {{< fa brands r-project >}} dan [**Quarto**](https://quarto.org) dengan template dari [UNAIR Theme](https://github.com/rameliaz/quarto-unair-theme).
```

**Step 2: Commit**

```bash
git add slides/bagian-6.qmd
git commit -m "feat: add bagian-6 slide (MG-SEM)"
```

---

## Task 9: Restore image assets, delete old source files, update CLAUDE.md

**Files:**
- Restore to git: `slides/libs/` (images needed by slides)
- Delete from disk: `slides/materi-mgsem-[1-6].Rmd`, `_site.yml`, `index.Rmd`
- Delete from disk: `slides/libs/remark-css/`, `slides/libs/remark-latest.min.js`, `slides/libs/slides.css`, `slides/libs/slides.js`
- Modify: `CLAUDE.md`

**Step 1: Re-add image assets to git and remove old source files**

```bash
# Re-add the libs images (still on disk but untracked after previous deletions)
git add slides/libs/

# Remove the old .Rmd source files from disk (they are untracked but still exist)
rm slides/materi-mgsem-1.Rmd slides/materi-mgsem-2.Rmd slides/materi-mgsem-3.Rmd
rm slides/materi-mgsem-4.Rmd slides/materi-mgsem-5.Rmd slides/materi-mgsem-6.Rmd

# Remove old rmarkdown site files from disk (untracked but still exist)
rm _site.yml index.Rmd

# Remove xaringan-specific files no longer needed
rm slides/libs/remark-latest.min.js
rm slides/libs/remark-css/default.css slides/libs/remark-css/rladies.css slides/libs/remark-css/rladies-fonts.css
rm slides/libs/slides.css slides/libs/slides.js
rm slides/libs/animate.css

# Also remove other untracked files at root that are no longer needed
# (keep datasets: *.csv, *.jasp, *.xlsx, cho2016.pdf, dataset-simulasi.R, README.md, .gitignore)
rm mg-sem-workshop.Rproj gambar.pptx
```

Note: Check with `ls slides/` and `ls slides/libs/` to confirm what's present before deleting. Only delete files that are confirmed to be the xaringan-specific ones. Keep all image `.png`/`.jpg` files in `slides/libs/`.

**Step 2: Update CLAUDE.md**

Replace the content of `CLAUDE.md` with:

```markdown
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
```

**Step 3: Commit**

```bash
git add slides/libs/ CLAUDE.md
git commit -m "feat: restore image assets, remove old source files, update CLAUDE.md"
```

---

## Task 10: Verify build

**Step 1: Run `quarto render` from project root**

```bash
quarto render
```

Expected: exits 0, `docs/` directory populated with:
- `docs/index.html`
- `docs/slides/bagian-1.html` through `docs/slides/bagian-6.html`
- `docs/site_libs/` (Quarto JS/CSS assets)
- Dataset files copied: `docs/corr.jasp`, `docs/latihancorr.csv`, etc.

**Step 2: Spot-check output**

Open `docs/index.html` in a browser. Verify:
- Cosmo theme applied (navbar visible, toc present)
- Navbar links render correctly (HTML slides dropdown, Dataset dropdown)
- YouTube embeds appear in correct sections

Open `docs/slides/bagian-1.html`. Verify:
- UNAIR branding (blue/yellow)
- Slide navigation works
- Two-column layouts render
- FontAwesome icons visible

**Step 3: Commit the built output**

```bash
git add docs/
git commit -m "feat: add initial Quarto build output"
```

---

## Notes

- **PDF links** in navbar use `?print-pdf` query string (revealjs standard). Open the HTML slide in Chrome and append `?print-pdf` to URL, then use browser print-to-PDF.
- **Image width syntax**: `style="width=N%"` (with `=` instead of `:`) in several original slides was a CSS bug — corrected to `width="N%"` in Quarto `![](path){width="N%"}` syntax.
- **`slides/libs/` subtree**: Some subdirectories (crosstalk, datatables, leaflet, etc.) were xaringan widget dependencies. These can be removed from `slides/libs/` after confirming the new slides don't use those widgets.
