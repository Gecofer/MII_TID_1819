library(RTextTools)
library(e1071)

# Cargamos los tados
datos_train <- read.table("datos/datos_train_preprocesado.csv", sep=",", comment.char="",quote = "\"", header=TRUE)
datos_test <- read.table("datos/datos_test_preprocesado.csv", sep=",", comment.char="",quote = "\"", header=TRUE)
# Establecemos la semilla
set.seed(3)

SVM_texto <- function(texto_train,texto_test,label_train,label_test){
  
}

#Creamos la matriz de términos
dtm_train <- create_matrix(datos_train$benefits_preprocesado)

#Creamos un contenedor a partir de la matriz de términos
contenedor <- create_container(dtm_train,datos_train$ratingLabel,trainSize=1:length(dtm_train),virgin=FALSE)

#Entrenamos el modelo SVM con los parámetros que queramos 
modelo <- train_model(contenedor,"SVM",kernel="radial")

#Creamos la matriz de términos para el conjunto de test
dtm_test <- create_matrix(as.list(datos_test$benefits_preprocesado), originalMatrix = dtm_train)
#trace("create_matrix", edit=T)

#Obtenemos el contenedor correspondiente a la matriz de términos del conjunto de Test
contenedor_test <- create_container(dtm_test,labels=as.factor(datos_test$ratingLabel),testSize=1:length(datos_test$ratingLabel),virgin=FALSE) 

resultados <- classify_model(contenedor_test,modelo)
resultados
