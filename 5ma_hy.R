install.packages("GDINA")
install.packages("readxl")
library(GDINA)
library(readxl)

# Yanıt verisi (öğrenci cevapları, .csv)
response_data <- read.csv2("responses_5.csv")  # ; ile ayrılmış olduğu için csv2

# Q-matrix (madde-özellik ilişkisi, .xlsx)
q_matrix <- as.matrix(read_excel("qmatrix_5ma.xlsx"))

# Yanıtlardan ID sütununu çıkar
Y <- as.matrix(response_data[, -1])

model <- GDINA(dat = Y, Q = q_matrix, model = "GDINA")

# 1. EAP çıktısını doğrudan al
skills <- personparm(model, what = "EAP")

# 2. Korelasyon matrisini hesapla
cor_matrix <- cor(skills)
print(cor_matrix)

install.packages("GDINA")
install.packages("cluster")  # Hamming mesafesi için
library(GDINA)

# Daha önce oluşturduğun model objesi:
# model <- GDINA(dat = Y, Q = q_matrix, model = "GDINA")

# MAP tahmini ile öğrencilerin beceri desenlerini al (ikili çıktı)
skills_binary <- personparm(model, what = "MAP")
head(skills_binary)

# Benzersiz beceri desenlerini al
unique_patterns <- unique(skills_binary)

# Hamming uzaklığı hesapla
hamming_dist <- dist(unique_patterns, method = "manhattan")

# Hiyerarşik kümeleme (average linkage)
hc <- hclust(hamming_dist, method = "average")

# Dendrogram çizimi
plot(hc, labels = apply(unique_patterns, 1, paste, collapse = ""),
     main = "Sequential Clustering ile Özellik Deseni Sıralaması",
     xlab = "Beceri Deseni", ylab = "Hamming Uzaklığı")
unique_df <- as.data.frame(unique_patterns)
colnames(unique_df) <- c("A1", "A2", "A3")
print(unique_df)

Q <- q_matrix[, 1:3]  # İlk 3 attribute ile sınırla
library(GDINA)
model <- GDINA(dat = Y, Q = Q, model = "GDINA")

skills_binary <- skills_binary[, 1:3]  # 3 attribute ile sınırla

labels <- apply(skills_binary, 1, paste, collapse = "")
unique_patterns <- unique(skills_binary)
labels <- apply(unique_patterns, 1, paste, collapse = "")

# 1. Öğrencilerin beceri desenlerini MAP ile al
skills_binary <- personparm(model, what = "MAP")[, 1:3]  # Sadece 3 attribute olsun

# 2. Benzersiz beceri desenlerini belirle
unique_patterns <- unique(skills_binary)

# 3. Hamming uzaklığını hesapla (manhattan = Hamming)
hamming_dist <- dist(unique_patterns, method = "manhattan")

# 4. Hiyerarşik kümeleme (average linkage önerilir)
hc <- hclust(hamming_dist, method = "average")

# 5. Etiketleri oluştur (örneğin: "010", "111", ...)
labels <- apply(unique_patterns, 1, paste, collapse = "")

# 6. Dendrogramı çiz
plot(hc,
     labels = labels,
     main = "Sequential Clustering ile Özellik Deseni Sıralaması",
     xlab = "Beceri Deseni",
     ylab = "Hamming Uzaklığı")
