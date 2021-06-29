
library(shiny)
library(DT)
library(dplyr)
library(ggplot2)

server <- function(input, output) {
    output$tabla_1 <- DT::renderDataTable( {mtcars %>% 
            DT::datatable(rownames = F, filter= 'top', 
                          options= list(PageLength= 5,lengthMenu= list(5,10,30)))} 
            )
    
    output$tablita <- DT::renderDataTable( {diamonds %>%
            DT::datatable() %>% 
            formatCurrency(columns= 'price')} )
    
    output$tab_3 <- DT::renderDataTable({mtcars %>% 
            DT::datatable(selection = 'single')} )

    output$tab_4 <- DT::renderDataTable({mtcars %>% 
            DT::datatable(selection = 'multiple')} )
    
    output$output1 <- renderPrint({input$tab_3_rows_selected})
    output$output2 <- renderPrint({input$tab_4_rows_selected})
    
    output$MiPlot<- renderPlot(diamonds %>% ggplot(aes(x= carat, y=price, color=color)) + geom_point() )
    output$click_data<- renderText({c(input$click$x, input$click$y)})
    output$brush_data<- renderText({c(input$brush$xmin, input$brush$ymin, input$brush$xmax, input$brush$ymax)})    
    
    output$tab_5 <- DT::renderDataTable({
        if( !is.null(input$brush) ){
            diamonds %>% filter(between(carat, input$brush$xmin, input$brush$xmax), 
                                between(price, input$brush$ymin, input$brush$ymax)) %>% 
                DT::datatable(selection = 'multiple')
            }
    })
}


# Run the application 
shinyApp(ui = ui, server = server)


#diamonds %>% filter(between(carat, 1, 2), between(price, 0, 5000))
