library(shiny)
library(plotly)



shinyServer(function(input, output , session) {



    accion_grafica <-  eventReactive(input$go , {

        archivo <- input$archivo
        ext <-  tools::file_ext(archivo$datapath)

        req(archivo)
        validate(need(ext == "csv" | ext == "xlsx" , "Please upload a csv or xlsx file"))

        if(ext == "csv"){
            d <- read_csv(archivo$datapath)
        }else(d <- archivo$datapath %>%
                  read_excel(sheet = hoja(archivo$datapath , input$n_hoja))
        )

        grafica(d ,
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



















