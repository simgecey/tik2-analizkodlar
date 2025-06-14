install.packages("GDINA")  # sadece yüklü değilse
library(GDINA)

# Yanıt verisi (ilk sütun öğrenci ID ise onu çıkar)
responses <- read.csv2("responses_5.csv")
response_data <- responses[, -1]

# Başlangıç Q-matrisi
q_matrix_init <- as.matrix(read.csv2("qmatrix_5ma.csv"))
q_matrix_init <- apply(q_matrix_init, 2, as.numeric)  # sayıya çevir

model_step1 <- GDINA(dat = response_data, Q = q_matrix_init, model = "GDINA")

# Gerekli paket
library(GDINA)

# Veriler hazırlandığında
responses <- read.csv2("responses_5.csv")
response_data <- responses[, -1]
q_matrix_init <- as.matrix(read.csv2("qmatrix_5ma.csv"))

# 1. CDM modeli oluşturma
model_step1 <- GDINA(dat = response_data, Q = q_matrix_init, model = "GDINA", verbose = 0)

# 2. Q-matris validasyonu
qval_result <- Qval(model_step1, method = "PVAF", eps = 0.95, digits = 4)

# 3. Çıktıları inceleme
print(qval_result)  # Önerilen Q-matris ve özet
extract(qval_result, "sug.Q")   # Yeni Q-matrisi
extract(qval_result, "PVAF")    # PVAF değerleri
extract(qval_result, "varsigma")# Varsigma indeksi

# 4. Gözlemleme: Belirli bir madde için PVAF plot
plot(qval_result, item = 5)  # 5. maddede öneri varsa detaylı görsel

# 5. Yeni modeli tekrar tahmin etme (isteğe bağlı):
sugQ <- extract(qval_result, "sug.Q")
model_step2 <- GDINA(dat = response_data, Q = sugQ, model = "GDINA", verbose = 0)


# Her attribute için bireysel olasılıklar
attribute_posteriors <- personparm(model_step1, what = "mp")
head(attribute_posteriors)

