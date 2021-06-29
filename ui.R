
library(shiny)
library(DT)
library(dplyr)
library(ggplot2)

ui <- fluidPage(

    titlePanel("Data Table"),
    
    tabsetPanel(
        tabPanel("Tablas en DT",
                 h1('Vista Basica'),
                 fluidRow(column(12, DT::dataTableOutput("tabla_1"))),
                 
                 h1('Vista Con Filtros'),
                 fluidRow(column(12, DT::dataTableOutput("tablita")))
        ),
        
        tabPanel("Click en tablas ", 
                 fluidRow(column(6, 
                                 h2("Selección Simple"),
                                 DT::dataTableOutput("tab_3"),
                                 verbatimTextOutput('output1')),
                          column(6, 
                                 h2("Selección Múltiple"),
                                 DT::dataTableOutput("tab_4"),
                                 verbatimTextOutput('output2'))
                 )
        ),
        
        tabPanel("Gráficos",
                 
                 fluidRow(
                     column(6, plotOutput("MiPlot", click= "click", brush = "brush"),
                            verbatimTextOutput("click_data"), # Selección de 1 punto
                            verbatimTextOutput("brush_data"),  # Selección en cuadro (xmin, ymin), (xmax, ymax)),
                     ),
                     column(5, DT::dataTableOutput("tab_5"))
                     )
        )
        
    )
)