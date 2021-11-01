library(shiny)
library(plotly)



shinyServer(function(input, output) {



    accion_grafica <-  eventReactive(input$go , {
        archivo <- input$archivo
        ext <-  tools::file_ext(archivo$datapath)
        req(archivo)
        validate(need(ext == "csv" | ext == "xlsx" , "Please upload a csv or xlsx file"))
        if(ext == "csv"){
            d <- archivo$datapath %>%
                read_csv()
        }else(d <- archivo$datapath %>%
                  read_excel(sheet = hoja(archivo$datapath , input$n_hoja))
        )
        grafica(d ,
                input$n_hoja ,
                input$n_col ,
                input$nombre ,
                input$eje_y)
    })

    # accion_analisis <- eventReactive(input$go , {
    #     archivo <- input$archivo
    #     ext <-  tools::file_ext(archivo$datapath)
    #     req(archivo)
    #     validate(need(ext == "csv" | ext == "xlsx" , "Please upload a csv or xlsx file"))
    #     if(ext == "csv"){
    #         d <- archivo$datapath %>%
    #             read_csv()
    #         d <- d %>%
    #             filter(!is.na(d))
    #     }else(d <- archivo$datapath %>%
    #               read_excel(sheet = hoja(archivo$datapath , input$n_hoja))
    #     )
    #     analisis(d ,
    #              input$n_col)
#
#     })

    analysis_type <- eventReactive(input$go , {
        archivo <- input$archivo
        ext <-  tools::file_ext(archivo$datapath)
        req(archivo)
        validate(need(ext == "csv" | ext == "xlsx" , "Please upload a csv or xlsx file"))
        if(ext == "csv"){
            d <- archivo$datapath %>%
                read_csv()
            d <- d %>%
                filter(!is.na(d))
        }else(d <- archivo$datapath %>%
                  read_excel(sheet = hoja(archivo$datapath , input$n_hoja))
        )
        switch(
            input$selection ,
            Normality = shapiro(d , input$n_col) ,
            Homoscedasticity = bar(d , input$n_col) ,
            ANOVA = an(d , input$n_col) ,
            all = analisis(d , input$n_col)
        )
    })


    output$plot <- renderPlotly({
        if(input$tabset == "Plot")
        accion_grafica()

    })

    output$t_anova <- renderPrint({
        if(input$tabset == "Inference")
        analysis_type()
    })



})



















