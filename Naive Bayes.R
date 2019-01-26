library(tm)
library(RTextTools)
library(e1071)
library(dplyr)
library(caret)
library(quanteda)
# Library for parallel processing
#library(doMC)
#registerDoMC(cores=detectCores())  # Use all available cores

# Cargamos los tados
datos_train <- read.table("datos/datos_train_preprocesado.csv", sep=",", comment.char="",quote = "\"", header=TRUE)
datos_test <- read.table("datos/datos_test_preprocesado.csv", sep=",", comment.char="",quote = "\"", header=TRUE)
# Establecemos la semilla
set.seed(3)

algoritmo.naiveBayes <- function(texto_train,texto_test,label_train,label_test){
  
  #Calculamos los corpus de los comentarios pasados
  corpus_train = tm::VCorpus(tm::VectorSource(texto_train))
  corpus_test = tm::VCorpus(tm::VectorSource(texto_test))
  
  #Obtenemos la matriz de términos de esos comentarios
  dtm_train <- DocumentTermMatrix(corpus_train)
  dtm_test <- DocumentTermMatrix(corpus_test)
  
  #Obtenemos los términos más frecuentes (Aquellos en los que se repiten en más de 5 textos)
  freq.words <- findFreqTerms(dtm_train, 5)
  
  #Recalculamos la matcatriz de términos en función de este concepto(Sparsity)
  dtm_freq_train <- DocumentTermMatrix(corpus_train, control=list(dictionary = freq.words))
  dtm_freq_test <- DocumentTermMatrix(corpus_test, control=list(dictionary = freq.words))
  
  #Función para convertir el peso de los términos en valores vinarios: yes=presente, no=ausente
  convert_counts <- function(x) {
    x <- ifelse(x > 0, "Yes", "No")
  }
  
  #Obtenemos matriz de términos con valores binarios en lugar de pesos(continuos)
  trainNB <- apply(dtm_freq_train, MARGIN = 2, convert_counts)
  testNB <- apply(dtm_freq_test, MARGIN = 2, convert_counts)
  
  #Entrenamos el clasificador con el conjunto de entrenamiento
  classifier <- naiveBayes(trainNB, as.factor(label_train), laplace = 1)
  
  #Hacemos la predicciones sobre el conjunto de test y calculamos los errores que tienen
  pred_test <- predict(classifier, newdata=testNB)
  pred_train <- predict(classifier, newdata=trainNB)
  Etest <- mean(pred_test!=label_test)
  Etrain <- mean(pred_train!=label_train)
  
  cat("-------------------------------\n")
  cat("**MATRIZ DE CONFUSIÓN TEST**\n")
  
  print(table(pred=pred_test,real=label_test))
  
  cat(paste("Error de Test: ",Etest*100," %\n\n"))
  
  cat("------------------------------------\n")
  cat("**MATRIZ DE CONFUSIÓN TRAIN**\n")
  
  print(table(pred=pred_train,real=label_train))
  
  cat(paste("Error de Train: ",Etrain*100," %\n"))
  cat("------------------------------------")
  
}

algoritmo.naiveBayes(datos_train$benefits_preprocesado,datos_test$benefits_preprocesado,datos_train$effectivenessNumber,datos_test$effectivenessNumber)