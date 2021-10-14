library(tidyverse)
library(shiny)
library(readxl)
library(plotly)


shinyUI(fluidPage(

    titlePanel("Box plot"),

    sidebarLayout(
        sidebarPanel(width = 2 ,

            fileInput("archivo" ,
                      'Selecionar archivo ".xlsx"' ,
                      accept = ".xlsx") ,

            numericInput("n_hoja" ,
                         "Número de hoja" ,
                         value = 1 ,
                         min = 1 ,
                         max = 2) ,

            numericInput("n_col" ,
                         "Número de columna" ,
                         value = 2 ,
                         min = 2 ,
                         max = 7) ,

            textInput("nombre" ,
                      label = "Nombre del gráfico") ,

            textInput("eje_y" ,
                      "Nombre del eje y")
        ),

        mainPanel(

            verbatimTextOutput("t_anova") ,

            plotlyOutput("plot")
        )
    )
))





