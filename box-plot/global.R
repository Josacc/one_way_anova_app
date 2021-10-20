library(tidyverse)
library(shiny)
library(readxl)
library(plotly)



hoja <- function(documento , n_hoja){
  (documento %>%
     excel_sheets())[n_hoja]
}

grafica <- function(documento , n_hoja , n_col , nombre , eje_y){

  d <- documento %>%
    read_excel(sheet = hoja(documento , n_hoja))

  g <- ggplot(d , aes(d %>% .[[1]] , d %>% .[[n_col]])) +
    geom_boxplot(aes(color = d %>% .[[1]])) +
    ggtitle(nombre) +
    labs(x = "" , y = eje_y)

  g %>%
    ggplotly() %>%
    layout(legend = list(orientation = 'h' , y = -0.1 , title=list(text='<b> treatments </b>')))
}

analisis <- function(documento , n_hoja , n_col){

  d <- documento %>%
    read_excel(sheet = n_hoja)

  shapiro <- d[[1]] %>%
    unique() %>%
    sapply(function(x)(d %>% filter(d[[1]] == x))[[n_col]] %>% shapiro.test())

  an <- aov(d[[n_col]] ~ d[[1]]) %>%
    summary()

  print(shapiro) ; print(an)

}
