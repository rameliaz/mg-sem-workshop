#----
# Script ini adalah perintah yang digunakan untuk membuat dataset latihan Workshop mg-SEM 
# Script ini digunakan untuk membuat 2 dataset, yaitu kemandirian siswa PAUD dan perilaku tidak beradab

#----
# muat paketnya dulu (pasang dulu apabila perlu)
library(tidyverse)
library(lavaan)
library(simsem)

# Dataset 1: Kemandirian siswa PAUD ---------------------------------------
# Seorang peneliti mencoba untuk mengobservasi faktor-faktor yang membuat kemandirian siswa PAUD di Surabaya bervariasi
# Peneliti menduga bahwa kepribadian ibu (neuroticism), trust in organismic development (percaya bahwa anak berkembang secara natural) mungkin punya pengaruh pada kemandirian siswa
# Penelitian ini dilakukan di 12 PAUD di Surabaya, dimana ukuran sampel di masing-masing sekolah adalah 100 siswa dan orangtua


# Bikin matriks loading factor  -----------------------------------------------------

loading <- matrix(0, 9, 3)
loading[1:3, 1] <- c(1, NA, NA)
loading[4:6, 2] <- c(1, NA, NA)
loading[7:9, 3] <- c(1, NA, NA)
loadingVal <- matrix(0, 9, 3)
loadingVal[2:3, 1] <- c(0.6, 0.7)
loadingVal[5:6, 2] <- c(1.1, 0.9)
loadingVal[8:9, 3] <- c(1.2, 1.1)
LY <- bind(loading, loadingVal)



# Bikin factor covariance-nya -----------------------------------------------------

facCov <- matrix(NA, 3, 3)
facCovVal <- diag(c(0.8, 0.9, 0.4))
facCovVal[lower.tri(facCovVal)] <- c(0.4, 0.2, 0.3)
facCovVal[upper.tri(facCovVal)] <- c(0.4, 0.2, 0.3)
PS <- binds(facCov, facCovVal)


# Bikin error covariance-nya -----------------------------------------------------

errorCov <- diag(NA, 9)
errorCovVal <- diag(c(0.5, 1.1, 0.8, 0.4, 0.4, 0.8, 0.8, 0.5, 0.6))
TE <- binds(errorCov, errorCovVal)

# Simulasikan data -----------------------------------------------------

sim_model <- model(LY=LY,PS=PS,TE=TE, modelType="cfa", groupLab = "group", ngroups = 2)
simdata <- generate(sim_model, 15000)
Output <- sim(100, sim_model, n=200)
getCutoff(Output, 0.05)
plotCutoff(Output, 0.05)
summary(Output)

# Cek Model -----------------------------------------------------

modelpaud <- '

# Model pengukuran

neu =~ 0.1*neu1 + 0.2*neu2 + 0.2*neu3 + 0.1*neu4 + 0.2*neu5 + 0.2*neu6
trust =~ 0.2*trust1 +0.3*trust2 + 0.2*trust3 + 0.3*trust4 + 0.1*trust5 + 0.3*trust6

## Residuals
neu1 ~~ 0.7*neu1
neu2 ~~ 0.7*neu2
neu3 ~~ 0.7*neu3
neu4 ~~ 0.7*neu4
neu5 ~~ 0.7*neu5
neu6 ~~ 0.7*neu6

neu3 ~~ 0.7*neu1
neu2 ~~ 0.7*neu6

trust1 ~~ 0.7*trust1
trust2 ~~ 0.7*trust2
trust3 ~~ 0.7*trust3
trust4 ~~ 0.7*trust4
trust5 ~~ 0.7*trust5
trust6 ~~ 0.7*trust6

trust1 ~~ 0.7*trust2
trust3 ~~ 0.7*trust5

neu ~~ 0.6*neu
trust ~~ 0.6*trust


# Model struktural
mandiri ~ -0.1*neu + 0.2*trust

## Residual
neu ~~ -0.3*trust
mandiri ~~ 0.4*mandiri

'

modpaud <- '

mandiri ~ neu + trust

'

# Bikin simulasinya ---------------------------------------

paud_simdata <- generate(modelpaud, 1200, saveLatentVar = T)

simmod <- sim(nRep=NULL, model=modelpaud, n=1200, 
              generate=modpaud, lavaanfun="sem",
              seed=2020, multicore=FALSE)

summary(simmod)

inspectSampleCov(modelpaud, data=paud_simdata)

sim <- sem(modelpaud, data=paud_simdata)
summary(sim)
fitmeasures(sim)

#----
# Tambahkan variabel id

nwalmur=100

paud_simdata$id <- seq(1:nrow(paud_simdata)) # kasih nomor urut partisipan
paud_simdata$idsekolah <- c(rep(1, nwalmur), rep(2, nwalmur), rep(3, nwalmur),
                           rep(4, nwalmur), rep(5, nwalmur), rep(6, nwalmur),
                           rep(7, nwalmur), rep(8, nwalmur), rep(9, nwalmur),
                           rep(10, nwalmur), rep(11, nwalmur), rep(12, nwalmur)) # kasih nomor urut sekolah

readr::write_csv(paud_simdata, path = "D:/Drive/Invited Talks & Workshops/mg-sem-workshop/data.csv")