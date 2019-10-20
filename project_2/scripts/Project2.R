library(shiny)
library(tidyverse)
library(shinydashboard)
library(dplyr)
library(caret)
library(ggplot2)
library(grDevices)
library(EnvStats)
library(forecast)
library(tidyquant)
library(timetk)
library(sweep)

data = read.delim(file = 'Project2.csv', sep = ";", fill = TRUE, header = TRUE) %>%
  filter(!is.na(Date))

ui <- fluidPage(
  titlePanel("Violin Plot"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "column_name",
                  label = "Choose a variable to display:",
                  choices = c("Year", "Month", "Day"),
                  selected = "Year"),
      textOutput(outputId = "Month")
    ),
    mainPanel(
      plotOutput(outputId = "distPlot"),
      textOutput(outputId = "disttext")
    )
  )
)

plot = function(column, data){
  p = ggplot(data, aes(x = get(column), y = Victim.Age)) +
    geom_violin() +
    labs(x = column,
         y = "Frequency")
  return(p)
}

server <- function(input, output) {
  output$distPlot <- renderPlot({
    plot(input$column_name, data)
  })
  output$disttext <- renderText({
    paste("How many unique values are found in that column:", length(unique(input$column_name)))
  })
}
shinyApp(ui = ui, server = server)

# The number of clients served by UMD between 1994 and 2019

ui <- fluidPage(
  titlePanel("Violin Plot"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "column_name",
                  label = "Choose a variable to display:",
                  choices = c("Year", "Month", "Day"),
                  selected = "Year"),
      textOutput(outputId = "Month")
    ),
    mainPanel(
      plotOutput(outputId = "distPlot"),
      textOutput(outputId = "disttext")
    )
  )
)

plot = function(column, data){
  client.data = data %>%
    select(Date, ClientID) %>%
    drop_na() %>%
    separate(Date, sep = "-", into = c("Year", "Month", "Day")) 
  ggplot(data = client.data) +
    geom_bar(mapping = aes(x = Year, fill = Year)) +
    labs(title = "Number of Clients by Year")
}

server <- function(input, output) {
  output$distPlot <- renderPlot({
    plot(input$column_name, data)
  })
  output$disttext <- renderText({
    paste("How many unique values are found in that column:", length(unique(input$column_name)))
  })
}
shinyApp(ui = ui, server = server)

# The Number of new clients by month

ui <- fluidPage(
  titlePanel("Violin Plot"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "column_name",
                  label = "Choose a variable to display:",
                  choices = c("Year", "Month", "Day"),
                  selected = "Year"),
      textOutput(outputId = "Month")
    ),
    mainPanel(
      plotOutput(outputId = "distPlot"),
      textOutput(outputId = "disttext")
    )
  )
)

plot = function(column, data){
  client.data = data %>%
    select(Date, ClientID) %>%
    drop_na() %>%
    separate(Date, sep = "-", into = c("Year", "Month", "Day")) %>%
    distinct(ClientID, .keep_all = TRUE) 
  ggplot(data = client.data) +
    geom_bar(mapping = aes(x = Month, fill = Month)) +
    labs(title = "Number of New Clients by Month")
}

server <- function(input, output) {
  output$distPlot <- renderPlot({
    plot(input$column_name, data)
  })
  output$disttext <- renderText({
    paste("How many unique values are found in that column:", length(unique(input$column_name)))
  })
}
shinyApp(ui = ui, server = server)