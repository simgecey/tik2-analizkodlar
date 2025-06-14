# Eğer paket yüklü değilse önce yükleyin
install.packages("CDM")
install.packages("GDINA")

# Paketi yükleyin
library(CDM) 
library(GDINA)


# Öğrenci yanıt verilerini yükleyin
responses <- read.csv2("/Users/macbookair/5ma/responses_5.csv", header = TRUE)

# Belirli sütunları seç
selected_items <- responses[, c("q1", "q2", "q3", "q4", "q5", "q6", "q7", "q8", "q9", "q10"
                                , "q11", "q12", "q13", "q14", "q15","q16")]

# Q-matrix verisini yükleyin
q_matrix <- read.csv2("/Users/macbookair/5ma/qmatrix_5ma.csv", header = TRUE)

model_dina <- din(data = selected_items, q.matrix = q_matrix)



# Slip (s) parametreleri
slip_parameters <- model_dina$slip
print("Slip parametreleri:")
print(slip_parameters)

# Guess (g) parametreleri
guess_parameters <- model_dina$guess
print("Guess parametreleri:")
print(guess_parameters)

# Model sonucunda elde edilen posterior olasılık matrisi
# Her satır bir öğrenci, her sütun bir örtük sınıfı temsil eder
posterior_probs <- model_dina$posterior  # gdina_model$posterior da olabilir

# Öğrenci numaraları ekle
posterior_df <- as.data.frame(posterior_probs)
posterior_df$Student_ID <- 1:nrow(posterior_df)

# Sütun adlarını düzenle (örnek: Class_1, Class_2, ...)
colnames(posterior_df)[1:(ncol(posterior_df)-1)] <- paste0("Class_", 1:(ncol(posterior_df)-1))

# Sıralı hale getirelim: Student_ID en başta olsun
posterior_df <- posterior_df[, c(ncol(posterior_df), 1:(ncol(posterior_df)-1))]

# Tabloyu dışa aktarmak istersen:
write.csv(posterior_df, "ogrenci_posterior_olasiliklari.csv", row.names = FALSE)



