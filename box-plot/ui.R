library(tidyverse)
library(shiny)
library(readxl)
library(plotly)


shinyUI(fluidPage(

    titlePanel("Box plot"),

    sidebarLayout(
        sidebarPanel(width = 3 ,
            fileInput("archivo" ,
                      "file type '.xlsx'" ,
                      accept = ".xlsx") ,
            fluidRow(
                column(
                    width = 5 ,
                    numericInput("n_hoja" ,
                                 "sheet" ,
                                 width = '80px' ,
                                 value = 1 ,
                                 min = 1 ,
                                 max = 2)
                ) ,
                column(
                    width = 5 ,
                    numericInput("n_col" ,
                                 "col" ,
                                 width = '80px' ,
                                 value = 2 ,
                                 min = 2 ,
                                 max = 7) ,
                )
            ) ,
            hr() ,
            tabsetPanel(id = "tabset" ,
                        tabPanel("Inference" ,
                                 br() ,
                                 radioButtons(
                                     inputId = "selccion" ,
                                     "select" ,
                                     inline = T ,
                                     choices = c("Normality" , "Homoscedasticity" , "ANOVA" , "all")
                                 )
                        ) ,
                        tabPanel("Plot" ,
                                 br() ,
                                 textInput("nombre" ,
                                           label = "Nombre del gráfico") ,

                                 textInput("eje_y" ,
                                           "Nombre del eje y")
                        )
            ) ,
            hr() ,
            actionButton(
                inputId = "go" ,
                "Go"
            )
        ) ,
        mainPanel(
            verbatimTextOutput("t_anova") ,
            plotlyOutput("plot")
        )
    )
))





