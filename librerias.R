# Cargar todas las librerías antes de ejecutar

library(magrittr)
library(plyr)
library(RColorBrewer)
library(ggplot2) 


# Paquete para minería de datos, permite procesar datos de tipo texto
# El paquete tm, necesita el paquete NLP
library(NLP)
library(tm)

# Paquete para minería de datos, agrupa aquellos términos que contienen la misma raíz
library(SnowballC)

library(wesanderson)

library(devtools)                   # hace falta esta librería para que funcione
# install_github("mukul13/rword2vec") # nos instalamos la libreria desde Github
library(rword2vec)

library(rlist)

library(quanteda) 

library(tseries)
library(wordcloud)

library(dplyr)

library(ROCR)