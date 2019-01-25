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

corpus = tm::Corpus(tm::VectorSource(datos_train$benefits_preprocesado))
corpus_test = tm::Corpus(tm::VectorSource(datos_test$benefits_preprocesado))

dtm <- DocumentTermMatrix(corpus)
dtm_test <- DocumentTermMatrix(corpus_test)

# De todo nuestro dtm no todo va a ser útil para realizar nuestra clasificación, por ello creemos que es conveniente 
# reducir el tamaño ignorando las palabras que a aparecen en menos de 5 textos.

fivefreq <- findFreqTerms(dtm, 5)

dim(dtm)
dtm.nb <- DocumentTermMatrix(corpus, control=list(dictionary = fivefreq))
dim(dtm.nb)

dim(dtm_test)
dtm_test.nb <- DocumentTermMatrix(corpus_test, control=list(dictionary = fivefreq))
dim(dtm_test.nb)

msg.dfm <- dfm(dtm, tolower = TRUE)  #generating document freq matrix
msg.dfm <- dfm_trim(msg.dfm, min_count = 5, min_docfreq = 3)  
msg.dfm <- dfm_weight(msg.dfm, type = "tfidf")

# Ahora vamos a reemplazar las frecuencias de los distintos términos en los distintos textos por valores Booleanos que 
# representan la presencia/ausencia de los datos. Esto se hace para calcular una clasificación por sentimientos.

# Function to convert the word frequencies to yes (presence) and no (absence) labels
convert_count <- function(x) {
  y <- ifelse(x > 0, 1,0)
  y <- factor(y, levels=c(0,1), labels=c("No", "Yes"))
  y
}

# Apply the convert_count function to get final training and testing DTMs
trainNB <- apply(dtm.nb, 2, convert_count)
testNB <- apply(dtm_test.nb, 2, convert_count)

# Train the classifier
classifier <- naiveBayes(trainNB, datos_train$effectivenessNumber, laplace = 1)

# Use the NB classifier we built to make predictions on the test set.
pred <- predict(classifier, newdata=testNB)

table("Predictions"= pred,  "Actual" = datos_test$effectivenessNumber )

# Prepare the confusion matrix
conf.mat <- confusionMatrix(pred, datos_test$effectivenessNumber)

conf.mat

