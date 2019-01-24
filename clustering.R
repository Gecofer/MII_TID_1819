library(tm)
#library(factoextra)
library(proxy)
library(dbscan)
library(ggplot2)
library(factoextra)

# Cargamos los tados
datos_train <- read.table("datos_train_preprocesado.csv", sep=",", comment.char="",quote = "\"", header=TRUE)
# Establecemos la semilla
set.seed(3)

corpus = tm::Corpus(tm::VectorSource(datos_train$benefits_preprocesad))

# Creamos matriz de términos con las palabras de los comentarios. Entonces cada fila, va a estar formada por los comentarios, donde cada palabra es una columna
tdm <- tm::DocumentTermMatrix(corpus)

# Utilizamos TF-DF para representar los comentarios de forma numerica
# Y asi podemos calcular la distancia que hay entre ellos

tdm.tfidf <- tm::weightTfIdf(tdm)
tfidf.matrix <- as.matrix(tdm.tfidf)

# Para pintar una gráfica más adelante queremos quedarnos con las columnas ("terminos") que más peso tienen.
# Es decir, aquellos terminos que aparecen más en la totalidad de comentarios (documentos).
# Por ello, nos quedamos con los terminos
#terminos <- colnames(tfidf.matrix)

#Hacemos la sumatoria de columnas para averiguar el peso total de cada término.
v <- c()
for(i in 1:length(d)){
  v[i] <- sum(tfidf.matrix[,i])
}

# Creamos una matriz de solo dos filas: etiquetas y total de peso.
#resumido.tfidf <- cbind(as.matrix(terminos),as.matrix(v))

# Averiguamos el orden de indices de los pesos de mayor a menor y nos quedamos con los 100 mas grandes.
indices <- order(v,decreasing = TRUE)[1:100]

# Nos creamos una submatriz de la original con los términos mas relevantes.
tfidf.matrix100 <- tfidf.matrix[,indices]
tfidf.matrix100 <- t(tfidf.matrix100)
#clustering.kmeans <- kmeans(tfidf.matrix, centers=5)

# Calculamos la distancia de cada término en cada documento
dist.matrix = proxy::dist(tfidf.matrix, method = "cosine")
dist.matrix100 = proxy::dist(tfidf.matrix100, method = "cosine")

#------------------------------------------------------------------------------------------------#

### FUNCIONES: QUEREMOS HACER CLUSTERING EN FUNCIÓN DEL NÚMERO DE CLUSTERS QUE DESEEMOS.

#------------------------------------------------------------------------------------------------#

clustering.kmeans <- function(centers=5){
  # Calulamos el cluster
  cluster <- kmeans(tfidf.matrix, centers) 
  
  # Para el de 100 terminos más frecuentes
  cluster100 <- kmeans(tfidf.matrix100, centers) 
  
  # Pintamos la nube de puntos perteneciente a cada uno de los cluster (cada color es un cluster)
  points <- cmdscale(t(dist.matrix), k = 2) 
  palette <- colorspace::diverge_hcl(centers) # Creating a color palette 
  
  plot(points, main = 'K-Means clustering', col = as.factor(cluster$cluster), 
       mai = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), 
       xaxt = 'n', yaxt = 'n', xlab = '', ylab = '') 
  
}

#------------------------------------------------------------------------------------------------#

clustering.hierarchial <- function(centers=5){
  # Calulamos el cluster
  cluster <- hclust(dist.matrix, method = "ward.D2") 
  
  # Para el de 100
  cluster100 <- hclust(dist.matrix100, method = "ward.D2")
  
  # Pintamos la nube de puntos de cada uno de ellos (Cada color representa un cluster distinto)
  points <- cmdscale(dist.matrix, k = 2) 
  palette <- colorspace::diverge_hcl(centers) # Creating a color palette 
  previous.par <- par(mfrow=c(1,2), mar = rep(1.5, 4))
  
  plot(points, main = 'Hierarchical clustering', col = as.factor(cutree(cluster, k = centers)), 
       mai = c(0, 0, 0, 0), mar = c(0, 0, 0, 0),  
       xaxt = 'n', yaxt = 'n', xlab = '', ylab = '') 
  
  # Para el de 100
  plot(cluster100, cex=0.9, hang=-1)
  rect.hclust(cluster100, centers, border=rainbow(centers))
  
}

#------------------------------------------------------------------------------------------------#

clustering.dbscan <- function(centers=5){
  # Calulamos el cluster
  cluster <- dbscan::hdbscan(dist.matrix, minPts = 10)
  
  # Pintamos la nube de puntos de cada uno de ellos (Cada color representa un cluster distinto)
  points <- cmdscale(dist.matrix, k = 2) 
  palette <- colorspace::diverge_hcl(centers) # Creating a color palette 
  
  plot(points, main = 'Density-based clustering', col = as.factor(cluster$cluster), 
       mai = c(0, 0, 0, 0), mar = c(0, 0, 0, 0), 
       xaxt = 'n', yaxt = 'n', xlab = '', ylab = '') 
}
#------------------------------------------------------------------------------------------------#



