# MII_TID_1819

Repositorio para las prácticas de la asignatura TID.

## Tabla de contenidos

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Prácticas](#pr%C3%A1cticas)
  - [P2. Prepocesamiento de datos](#p2-prepocesamiento-de-datos)
      - [Correlación](#correlaci%C3%B3n)
      - [Información para hacer el preprocesamiento de texto](#información-para-hacer-el-preprocesamiento-de-texto)
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

##### Información para hacer el preprocesamiento de texto

* [Enlace 1](http://eio.usc.es/pub/mte/descargas/ProyectosFinMaster/Proyecto_1475.pdf): en este enlace se indica como hacer un
  preprocesamiento y luego hacer particionamiento de datos, utilizar varias técnicas de árboles de decisión, clasificar un nuevo documento...
  También usa una librería para mostrar los resultados gráficamente. Parece muy completo.

* [Enlace 2](https://analytics4all.org/2016/12/22/r-text-mining-pre-processing/): en este enlace se habla del procesamiento de los textos,
  con la misma herramienta que el enlace de arriba pero redactado y explicado de otra forma.


### P3. Métodos de agrupamientos (Clustering)

### P4. Clasificación

### P5. Regresión

### P6. Reglas de asociación


## Tareas

- [x] Portada **comprobacion por alguien**
- [x] Índices **comprobacion por alguien**
- [ ] Cambiar encabezado de página
- [ ] Añadir cada uno el correo en la portada
- [ ] Hacer la tabla del apartado 1
- [ ] ¿Queremos mostrar las ejecuciones/salidas del código? ¿Queremos poner capturas de pantalla? ¿Qué código queremos mostrar en el PDF?
- [x] Descripción del conjunto de datos **comprobacion por alguien**



## Enlaces

- Tutorial R Markdown: https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-spanish.pdf
- Tutorial R Markdown Cheat Sheet: http://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf
- Tutorial R Markdown Reference Guide: https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf
- Crear tablas markdown: https://www.tablesgenerator.com/markdown_tables
- Crear documento PDF: https://bookdown.org/yihui/rmarkdown/pdf-document.html
- Crear tabla contenidos Markdown: https://github.com/thlorenz/doctoc#specifying-location-of-toc
- Usar Markdown: https://typora.io
- Índice de contenidos, figuras y tablas: http://sae.saiblogs.inf.um.es/indice-de-contenidos-figuras-y-tablas/
- Incluir texto plano y resultados de R: https://www.maximaformacion.es/blog-dat/crea-tu-propio-codigo-y-publica-tus-resultados-con-rmarkdown/

- UCI Machine Learning: https://archive.ics.uci.edu/ml/index.php
- Drug Review Dataset Data Set: https://archive.ics.uci.edu/ml/datasets/Drug+Review+Dataset+%28Druglib.com%29 y http://www.druglib.com
