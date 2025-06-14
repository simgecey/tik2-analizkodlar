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

