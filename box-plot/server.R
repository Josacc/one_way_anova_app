library(tidyverse)
library(shiny)
library(readxl)
library(plotly)



shinyServer(function(input, output) {




    output$plot <- renderPlotly({

        grafica(input$archivo$datapath ,
                input$n_hoja ,
                input$n_col ,
                input$nombre ,
                input$eje_y)

    })

    output$t_anova <- renderPrint({
        analisis(input$archivo$datapath ,
                 input$n_hoja ,
                 input$n_col)
    })



})



















