library("tm")
library("arules")
library("robustbase")
library("plotly")
library("arulesViz")

datos_train <- read.table("datos/drugLibTrain_raw.tsv", sep="\t", comment.char="",
                          quote = "\"", header=TRUE)
# Eliminar columnas  para el ID en el train
datos_train = datos_train[-c(1,3)]

datos_train$sideEffectsNumber[datos_train$sideEffects == "Extremely Severe Side Effects"] <- 5
datos_train$sideEffectsNumber[datos_train$sideEffects == "Severe Side Effects"] <- 4
datos_train$sideEffectsNumber[datos_train$sideEffects == "Moderate Side Effects"] <- 3
datos_train$sideEffectsNumber[datos_train$sideEffects == "Mild Side Effects"] <- 2
datos_train$sideEffectsNumber[datos_train$sideEffects == "No Side Effects"] <- 1

datos_train$effectivenessGuion[datos_train$effectiveness == "Highly Effective"] <- "Highly-Effective"
datos_train$effectivenessGuion[datos_train$effectiveness == "Considerably Effective"] <- "Considerably-Effective"
datos_train$effectivenessGuion[datos_train$effectiveness == "Moderately Effective"] <- "Moderately-Effective"
datos_train$effectivenessGuion[datos_train$effectiveness == "Marginally Effective"] <- "Marginally-Effective"
datos_train$effectivenessGuion[datos_train$effectiveness == "Ineffective"] <- "Ineffective"

# Pasamos a factor el effectivenes unido por guiones para concatenarlo con los comentarios
datos_train$effectivenessGuion = as.factor(datos_train$effectivenessGuion)

# Juntamos las cadenas
datos_train$junto <- with(datos_train, interaction(benefitsReview,effectivenessGuion), sep=" ")
datos_train$junto <- gsub("[.]", " ", datos_train$junto)

head(datos_train$sideEffectsNumber, 10)

#corpus_train <- corpus(datos_train)

#benefits_review_data = as.vector(datos_train$benefitsReview)
benefits_corpus = Corpus(VectorSource(datos_train$junto))
benefits_corpus <- tm_map(benefits_corpus, content_transformer(tolower))
benefits_corpus <- tm_map(benefits_corpus, content_transformer(removePunctuation))
benefits_corpus <- tm_map(benefits_corpus, content_transformer(removeWords), stopwords("english"))
benefits_corpus <- tm_map(benefits_corpus, stripWhitespace)

#Separamos todas las palabras entre sí
items <- strsplit(as.character(benefits_corpus$content), " ")
# Para eliminar las cadenas vacías --> https://stackoverflow.com/questions/24178854/remove-blanks-from-strsplit-in-r
items <- lapply(items, function(x){x[!x ==""]})
#items = paste(items, "hola")

transactions <- as(items,"transactions")

rules <- apriori(transactions, parameter = list(sup = 0.001, conf = 0.7, target="rules", minlen=2))


rulesInnefective <- apriori (data=transactions, 
                                 parameter=list (supp=0.0007,conf = 0.9, minlen=2), 
                                 appearance = list(default="lhs",rhs=c("ineffective")), 
                                 control = list (verbose=F))

rulesHiglyEffective <- apriori (data=transactions, 
                             parameter=list (supp=0.0007,conf = 0.9, minlen=2), 
                             appearance = list(default="lhs",rhs=c("highlyeffective")), 
                             control = list (verbose=F))

rulesConsiderablyEffective <- apriori (data=transactions, 
                                parameter=list (supp=0.0007,conf = 0.9, minlen=2), 
                                appearance = list(default="lhs",rhs=c("considerablyeffective")), 
                                control = list (verbose=F))

rulesModeratelyEffective <- apriori (data=transactions, 
                                parameter=list (supp=0.0007,conf = 0.9, minlen=2), 
                                appearance = list(default="lhs",rhs=c("moderatelyeffective")), 
                                control = list (verbose=F))

rulesMarginallyEffective <- apriori (data=transactions, 
                                     parameter=list (supp=0.0007,conf = 0.9, minlen=2), 
                                     appearance = list(default="lhs",rhs=c("marginallyeffective")), 
                                     control = list (verbose=F))


rulesInnefective <- sort(rulesInnefective, decreasing = TRUE, na.last = NA, by = "confidence")
rulesHiglyEffective <- sort(rulesHiglyEffective, decreasing = TRUE, na.last = NA, by = "confidence")
rulesConsiderablyEffective <- sort(rulesConsiderablyEffective, decreasing = TRUE, na.last = NA, by = "confidence")
rulesModeratelyEffective <- sort(rulesModeratelyEffective, decreasing = TRUE, na.last = NA, by = "confidence")
rulesMarginallyEffective <- sort(rulesMarginallyEffective, decreasing = TRUE, na.last = NA, by = "confidence")

inspect(head(rulesInnefective,100))
rules <- sort(rules, by="support")
top.rules.confidence <- sort(rules, decreasing = TRUE, na.last = NA, by = "confidence")


# Si no funciona inspect --> https://stackoverflow.com/questions/18934098/r-error-with-inspect-function
detach(package:tm, unload=TRUE)
inspect(head(rulesInnefective,100))
inspect(head(rulesHighlyEffective,100))
inspect(head(rulesConsiderablyEffective,100))
inspect(head(rulesModeratelyEffective,100))
inspect(head(rulesMarginallyEffective,100))

png("Innefective.png",width=1800,height=1700,units="px",
    pointsize=10,bg="white",res=300)
plot(rulesInnefective, method="graph")
dev.off()

png("HighlyEffective.png",width=1800,height=1700,units="px",
    pointsize=10,bg="white",res=300)
plot(rulesHiglyEffective, method="graph")
dev.off()

png("ConsiderablyEffective.png",width=1800,height=1700,units="px",
    pointsize=10,bg="white",res=300)
plot(rulesConsiderablyEffective, method="graph")
dev.off()

png("ModeratelyEffective.png",width=1800,height=1700,units="px",
    pointsize=10,bg="white",res=300)
plot(rulesModeratelyEffective, method="graph")
dev.off()


png("MarginallyEffective.png",width=1800,height=1700,units="px",
    pointsize=10,bg="white",res=300)
plot(rulesMarginallyEffective, method="graph")
dev.off()



# Cuando tenemos una regla con una única palabra en el antecedente y en el consecuente deben de ir unidas en el texto


