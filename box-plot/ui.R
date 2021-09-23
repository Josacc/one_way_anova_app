library(tidyverse)
library(shiny)
library(readxl)
library(plotly)


shinyUI(fluidPage(

    titlePanel("Box plot"),

    sidebarLayout(
        sidebarPanel(

            fileInput("archivo" ,
                      'Selecionar archivo ".xlsx"' ,
                      accept = ".xlsx") ,

            numericInput("n_hoja" ,
                         "Número de hoja" ,
                         value = 2 ,
                         min = 2 ,
                         max = 7) ,

            numericInput("n_col" ,
                         "Número de columna" ,
                         value = 2 ,
                         min = 2 ,
                         max = 7)
        ),

        mainPanel(
            plotOutput("distPlot")
        )
    )
))
