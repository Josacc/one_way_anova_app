library(tidyverse)
library(shiny)
library(readxl)
library(plotly)



shinyServer(function(input, output) {

    hoja <- function(documento , n_hoja){
        (documento %>%
             excel_sheets())[n_hoja]
    }

    grafica <- function(documento , n_hoja , n_col){

        d <- documento %>%
            read_excel(sheet = hoja(documento , n_hoja))

        g <- ggplot(d , aes(d %>% .[[1]] , d %>% .[[n_col]])) +
            geom_boxplot()

        ggplotly(g)
    }

    output$plot <- renderPlotly({

        grafica(input$archivo$datapath , input$n_hoja , input$n_col)

    })

})
