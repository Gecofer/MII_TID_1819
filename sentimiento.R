library(syuzhet)
library(ggplot2)

datos_train <- read.table("datos/drugLibTrain_raw.tsv", sep="\t", comment.char="",
                          quote = "\"", header=TRUE)
# Eliminar columnas  para el ID en el train
datos_train = datos_train[-c(1,3)]

datos_train$sideEffectsNumber[datos_train$sideEffects == "Extremely Severe Side Effects"] <- 5
datos_train$sideEffectsNumber[datos_train$sideEffects == "Severe Side Effects"] <- 4
datos_train$sideEffectsNumber[datos_train$sideEffects == "Moderate Side Effects"] <- 3
datos_train$sideEffectsNumber[datos_train$sideEffects == "Mild Side Effects"] <- 2
datos_train$sideEffectsNumber[datos_train$sideEffects == "No Side Effects"] <- 1


head(datos_train$sideEffectsNumber, 10)

#corpus_train <- corpus(datos_train)

#benefits_review_data = as.vector(datos_train$benefitsReview)


#https://stackoverflow.com/questions/1686569/filter-data-frame-rows-by-a-logical-condition
condiciones = c("depression","acne","anxiety","insomnia","birth control","high blood pressure")
drogas = c ("lexapro","prozac","retin-a","zoloft","paxil","propecia")


analisis_sentimientos <- function(datos,titulo){
  
  benefits_corpus = Corpus(VectorSource(datos$benefitsReview))
  benefits_corpus <- tm_map(benefits_corpus, content_transformer(tolower))
  benefits_corpus <- tm_map(benefits_corpus, content_transformer(removePunctuation))
  benefits_corpus <- tm_map(benefits_corpus, content_transformer(removeWords), stopwords("english"))
  benefits_corpus <- tm_map(benefits_corpus, stripWhitespace)
  
  d <- get_nrc_sentiment(benefits_corpus$content)
  
  #https://medium.com/swlh/exploring-sentiment-analysis-a6b53b026131
  dt <- data.frame(t(d))
  
  sentimientos <- data.frame(rowSums(dt))
  
  names(sentimientos)[1] <- "count"
  sentimientos <- cbind("sentiment" = rownames(sentimientos), sentimientos)
  rownames(sentimientos) <- NULL
 
  qplot(sentiment, data=sentimientos[1:8,], weight=count, geom="bar",fill=sentiment)+ggtitle(titulo)
  ggsave(paste(titulo,".png"))
  
  
  qplot(sentiment, data=sentimientos[9:10,], weight=count, geom="bar",fill=sentiment)+ggtitle(titulo)
  ggsave(paste(titulo,"_positivismo.png"))

}

for(cadena in condiciones){
  datos <- datos_train[datos_train$condition==cadena ,]
  analisis_sentimientos(datos,cadena)
  
}

for(cadena in drogas){
  datos <- datos_train[datos_train$urlDrugName==cadena ,]
  analisis_sentimientos(datos,cadena)
  
}

