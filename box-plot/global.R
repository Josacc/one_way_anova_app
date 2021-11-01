library(tidyverse)
library(shiny)
library(readxl)
library(plotly)



hoja <- function(documento , n_hoja){
  (documento %>%
     excel_sheets())[n_hoja]
}

grafica <- function(d , n_hoja , n_col , nombre , eje_y){

  g <- ggplot(d , aes(d %>% .[[1]] , d %>% .[[n_col]])) +
    geom_boxplot(aes(color = d %>% .[[1]]) , na.rm = T) +
    ggtitle(nombre) +
    labs(x = "" , y = eje_y)

  g %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h' , y = -0.1 , title=list(text='<b> treatments </b>')))
}

shapiro <- function(d , n_col){
  d[[1]] %>%
    unique() %>%
    sapply(function(x)(d %>% filter(d[[1]] == x))[[n_col]] %>% shapiro.test())
}

bar <- function(d , n_col){
  bartlett.test(d[[n_col]] ~ d[[1]])
}

an <- function(d , n_col){
  print("ANOVA")
  aov(d[[n_col]] ~ d[[1]]) %>%
    summary()
}

analisis <- function(d , n_col){

  print(shapiro(d , n_col))
  print(bar(d , n_col))
  print(an(d , n_col))

}






