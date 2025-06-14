# Gerekli paket
library(GDINA)

# Paket yüklü değilse önce yükle
install.packages("GDINA")

# Paketi yükle
library(GDINA)

# Paket başarıyla yüklendiyse şu komut boş dönmemeli:
ls("package:GDINA")


responses <- read.csv("responses_5.csv", sep = ";", stringsAsFactors = FALSE)
response_data <- responses[, -1]

q_matrix <- as.matrix(read.csv("qmatrix_5ma.csv", sep = ";", header = TRUE))
q_matrix <- apply(q_matrix, 2, as.numeric)

# GDINA modelini çalıştır
model <- GDINA(dat = response_data, Q = q_matrix, model = "GDINA")

# Özet bilgi
summary(model)

# Gerekirse kur
install.packages("Qval")
library(Qval)

library(GDINA)
model <- GDINA(dat = response_data, Q = q_matrix, model = "GDINA")

library(randomForest)

# Attribute profilleri
attr_profiles <- personparm(model, what = "MAP")  # en yüksek olasılıklı profil

# Her bir madde için attribute etkisini tahmin etmek
for (i in 1:ncol(response_data)) {
  rf <- randomForest(x = attr_profiles, y = as.factor(response_data[,i]))
  print(paste("Item", i))
  print(importance(rf))
}

