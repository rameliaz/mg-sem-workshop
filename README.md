
## Deskripsi
Berikut adalah repositori yang digunakan untuk menyimpan semua materi untuk **Workshop Multigroup Structural Equation Modeling (MG-SEM)** yang diselenggarakan oleh Departemen Psikologi Kepribadian dan Sosial, Fakultas Psikologi Universitas Airlangga dalam rangka memperingati Dies Natalis Pendidikan Psikologi Universitas Airlangga yang ke-36. 

Materi berlisensi [*Creative Commons* BY 4.0](https://creativecommons.org/licenses/by/4.0/). **Materi bebas digunakan kembali namun wajib menyebutkan sumber aslinya**.


## Waktu dan tempat
*Workshop* diselenggarakan pada hari **Jumat-Sabtu, 22-23 November 2019**, pukul 09.00-16.00 WIB di Ruang Sidang I, Fakultas Psikologi Universitas Airlangga.


## *Outline* materi

Berikut adalah *outline* materi *workshop*: 


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
* Peserta sangat disarankan untuk [menonton video tutorial JASP](https://www.youtube.com/embed/HxqB7CUA-XI) sebelum *workshop* untuk belajar menavigasikan menu dan fitur yang ada dalam JASP (total durasi kurang lebih hanya 5 menit).


## Video rekaman

### Hari 1

**Mohon maaf sebesar-besarnya. Saya gagal menyimpan video rekaman untuk seluruh sesi di hari pertama dengan baik karena khilaf tidak menyalakan opsi merekam suara, sehingga yang terekam hanya layar laptop saya saja tanpa ada suara sama sekali**


### Hari 2

#### Sesi 1 (09.00-12.00)

[Klik untuk melihat video](https://www.youtube.com/watch?v=FB-e48e_UtQ&t=1s)


#### Sesi 2 (13.00-16.00)

[Klik untuk melihat video](https://www.youtube.com/watch?v=ibgXwu3S8m8)

## Pembaruan dan koreksi

* Di dalam video, saya menyebutkan bahwa variabel endogen dan eksogen hanya ada masing-masing 1 variabel dalam model, padahal yang betul adalah variabel endogen dan eksogen bisa lebih dari satu dalam model yang sama. Sesuai definisinya, variabel endogen adalah variabel yang **hanya menerima** *direct effect* dari variabel lainnya di dalam model, sedangkan variabel eksogen adalah variabel yang **hanya memberi** *direct effect* kepada variabel lainnya di dalam model yang sama.
* Saya merevisi gambar *part correlation* di [Bagian 2](https://rameliaz.github.io/mg-sem-workshop/slides/materi-mgsem-2.html) dimana versi sebelumnya (yang ada di dalam video) sangat membingungkan.
* Saya menambahkan keterangan bahwa di beberapa literatur yang lain *weak invariance* juga disebut *metric invariance*, *strong invariance* disebut *scalar invariance*, sedangkan *strict invariance* juga disebut sebagai *residual invariance*.
* Saya menyebutkan bahwa formula *composite reliability* adalah Cronbach's α. Padahal *composite reliability* (yang dikeluarkan oleh AMOS) mengikuti model pengukuran *congeneric*. Saya menjelaskan di bagian video yang lain (di sesi terakhir) apa perbedaan *composite reliability* dengan Cronbach's α, serta teknik reliabilitas apa yang cocok untuk digunakan pada model pengukuran tertentu.

Referensi untuk poin terakhir: Cho, E. (2016). [Making Reliability Reliable: A Systematic approach to reliability coefficients](https://rameliaz.github.io/mg-sem-workshop/cho2016.pdf). Organizational Research Methods, 19(4), 651-682.


## Poster kegiatan

<center><img src="slides/libs/poster.jpg" style="width:70%;" class="fancyimage"/></center><br>


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