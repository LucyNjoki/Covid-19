#*********************************************************************
#Purpose: COVID-19 Trends
#Date: 13/5/2020
#Author: LNN
#Acknowledge: Taryn Morris (R-Ladies - Intro to shiny)
#*********************************************************************

rm(list = ls(all = TRUE))

#package load
library(tidycovid19)
library(tidyverse)
library(extrafont)
library(ggthemes)
library(ggrepel)
library(plotly)
library(shiny)
library(shinyWidgets)

#import data
data <- readRDS("CovData.rds")


# Define UI for application that draws the graph
ui <- fluidPage(

    # Application title
    titlePanel("Covid-19 Trends"),

    # Sidebar with a slider input for choosing country
    sidebarLayout(
        sidebarPanel(
            pickerInput(inputId = "countries", label = "Choose your country",
                        choices = unique(data$country),
                        selected = "Kenya",
                        multiple = TRUE),
        #sliderInput("bins",
         #               "Number of bins:",
          #              min = 1,
           #             max = 50,
            #            value = 30)
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotlyOutput("covid19Trend")
        )
    )
)

# Define server logic to show Covid-19 trends
server <- function(input, output) {

    output$covid19Trend <- renderPlot({
        theme_set(theme_tufte())
        
        ggplotly(
            ggplot(data %>% filter(country == input$countries),
                   aes(x = date, y = confirmed, colour = country)) +
                geom_line() +
                geom_point() +
                labs(x = "Date", y = "Confirmed Cases",
                     title = "Covid-19 Trends") +
                theme(plot.title = element_text(family = "Calibri Light", size = rel(1.2), 
                                                hjust = 0.5), 
                      axis.line = element_line(colour = "black", size = 0.5), 
                      axis.text.x = element_text(family = "Calibri Light", size = rel(1.0),
                                                 hjust = 0.5),
                      axis.text.y = element_text(family = "Calibri Light", size = rel(1.0), 
                                                 hjust = 0.5))
        )
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
