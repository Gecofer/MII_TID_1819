# MII_TID_1819

Repositorio para las prácticas de la asignatura TID.

## Tabla de contenidos

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->


- [Prácticas](#pr%C3%A1cticas)
  - [P2. Prepocesamiento de datos](#p2-prepocesamiento-de-datos)
      - [Correlación](#correlaci%C3%B3n)
  - [P3. Métodos de agrupamientos (Clustering)](#p3-m%C3%A9todos-de-agrupamientos-clustering)
  - [P4. Clasificación](#p4-clasificaci%C3%B3n)
  - [P5. Regresión](#p5-regresi%C3%B3n)
  - [P6. Reglas de asociación](#p6-reglas-de-asociaci%C3%B3n)
- [Tareas](#tareas)
- [Enlaces](#enlaces)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

---

## Prácticas

### P2. Prepocesamiento de datos

- Falta de datos, categorización, normalización, reducción de dimensionalidad, etc.
- Ver si algún atributo (columna) no nos hace falta
- Indicar que es relevante para nosotros, ver como están agrupados.
- Comprobar la columna "sideEffectsReview" ya que contiene NONE
- Comprobar la columna de ID si hace falta, ya que tenemos 8 atributos, y aparecen que tenemos 9 atributos.
- Comprobación de celdas NA

##### Correlación

- Crear patrones en los textos, para saber que documentos hacen referencia a un tipo de fármaco, y podíamos sustituir los fármacos por un número.
- Leyendo el comentario que nos diga pertenece a este fármaco con una x probabilidad.
- Técnica de agrupamiento: coger los textos y agrupar (sin hacer clasificación), haciendo un "unit" a la columna de fármacos.

- Para el análisis de sentimientos solo hace falta texto, tener en cuenta "benefitsReview" y "commentsReview". Los efectos secundarios y la efectividad que tienen las drogas, hacer un análisis de sentimientos.

- El analisis textual hacer para:
  - los comentarios en función de la droga
  - en función del rating

### P3. Métodos de agrupamientos (Clustering)

### P4. Clasificación

### P5. Regresión

### P6. Reglas de asociación


## Tareas

- [ ] Siempre tener definido el directorio de trabajo para verlo `getwd()`, para modificarlo `setwd(dir)`
- [ ] Hacer portada
- [ ] Hacer índice
- [ ] Ver qué salidas de ejecuciones queremos poner (si es muy grande foto)
- [ ] Escribir de donde hemos cogido el conjunto de datos


## Enlaces

- Tutorial RMarkdown: https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-spanish.pdf
- Crear tablas markdown: https://www.tablesgenerator.com/markdown_tables
- Crear documento PDF: https://bookdown.org/yihui/rmarkdown/pdf-document.html
- UCI Machine Learning: https://archive.ics.uci.edu/ml/index.php
- Drug Review Dataset Data Set: https://archive.ics.uci.edu/ml/datasets/Drug+Review+Dataset+%28Druglib.com%29 y http://www.druglib.com
- Crear tabla contenidos Markdown: https://github.com/thlorenz/doctoc#specifying-location-of-toc
