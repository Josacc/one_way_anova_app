library(tidyverse)
library(shiny)
library(readxl)
library(plotly)


shinyUI(fluidPage(

    titlePanel("One-way ANOVA"),

    sidebarLayout(
        sidebarPanel(width = 3 ,
            radioButtons(
                "tipo archivo" ,
                "Select type file" ,
                choices = c("xlsx", "csv") ,
                inline = T
            ) ,
            fileInput("archivo" ,
                      "select file" ,
                      accept = c(".xlsx" , ".csv")) , #aceptar csv
            tabsetPanel(
                id = "excel" ,
                type = "hidden" ,
                tabPanel(
                    "xlsx" ,
                    numericInput("n_hoja" ,
                                 "sheet" ,
                                 width = '80px' ,
                                 value = 1 ,
                                 min = 1 ,
                                 max = 2) ,
                    numericInput("n_col" ,
                                 "col" ,
                                 width = '80px' ,
                                 value = 2 ,
                                 min = 2 ,
                                 max = 7) ,
                )
            ) ,
            actionButton(
                inputId = "go" ,
                "Go"
            ),
            hr() ,
            tabsetPanel(id = "tabset" ,
                        tabPanel("Plot" ,
                                 br() ,
                                 radioButtons(
                                     "id_fun_orden" ,
                                     "ordered by" ,
                                     choices = c("NULL" , "mean" , "median" , "sd") ,
                                     inline = T
                                 ) ,
                                 radioButtons(
                                     "id_orden" ,
                                     "order" ,
                                     choices = c("ascending" , "descending") ,
                                     inline = T
                                 ) ,
                                 br() ,
                                 textInput("nombre" ,
                                           label = "graphic title ") ,
                                 textInput("eje_y" ,
                                           "Y axis title")
                        ) ,
                        tabPanel("Inference" ,
                                 br() ,
                                 radioButtons(
                                     inputId = "selccion" ,
                                     "select" ,
                                     inline = T ,
                                     choices = c("Normality" , "Homoscedasticity" , "ANOVA" , "all")
                                 )
                        )
            )
        ) ,
        mainPanel(
            verbatimTextOutput("t_anova") ,
            plotlyOutput("plot")
        )
    )
))





