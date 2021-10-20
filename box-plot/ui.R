library(tidyverse)
library(shiny)
library(readxl)
library(plotly)


shinyUI(fluidPage(

    titlePanel("Box plot"),

    sidebarLayout(
        sidebarPanel(width = 3 ,
            radioButtons(
               "tipo_archivo" ,
               "file type" ,
               choices = c("xlsx" , "csv") ,
               inline = T
            ) ,
            fileInput("archivo" ,
                      NULL ,
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
                                           label = "Nombre del gráfico") ,
                                 textInput("eje_y" ,
                                           "Nombre del eje y")
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





