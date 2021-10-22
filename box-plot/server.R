library(shiny)
library(plotly)



shinyServer(function(input, output , session) {



    accion_grafica <-  eventReactive(input$go , {
        grafica(input$archivo$datapath ,
                input$n_hoja ,
                input$n_col ,
                input$nombre ,
                input$eje_y)
    })

    accion_analisis <- eventReactive(input$go , {
        analisis(input$archivo$datapath ,
                 input$n_hoja ,
                 input$n_col)
    })

    output$plot <- renderPlotly({
        if(input$tabset == "Plot")
        accion_grafica()

    })

    output$t_anova <- renderPrint({
        if(input$tabset == "Inference")
        accion_analisis()
    })



})



















