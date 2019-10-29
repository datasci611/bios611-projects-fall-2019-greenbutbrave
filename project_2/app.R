source("helper_functions.R")

# Define UI for app that draws a histogram ----
ui = dashboardPage(
    # Title
    dashboardHeader(title = "UMA Data Visualization Dashboard",
                    titleWidth = 270
    ),
    # Sidebar 
    dashboardSidebar(
      sidebarMenu(
        menuItem("Introduction", tabName = "Introduction", icon = icon("home")),
          menuSubItem("RQ 1", tabName = "RQ_1", icon = icon("star")),
          menuSubItem("RQ 2", tabName = "RQ_2", icon = icon("star")),
          menuSubItem("RQ 3", tabName = "RQ_3", icon = icon("star")),
          menuSubItem("RQ 4", tabName = "RQ_4", icon = icon("star"))
      )
    ),
    
    ## Body 
    dashboardBody(
      tabItems(
        # Introduction Tab
        tabItem(tabName = "Introduction",
                h2("Introduction"),
                textOutput("Introduction")
        ),
      
        
        # Data Analysis RQ 1 Tab 
        tabItem(tabName = "RQ_1",
                h2("RQ 1: Do outliers matter in terms of distribution?"),
                fluidRow(
                  radioButtons("RQ1_Outlier", label = "Do you want to remove outliers?",
                             choices = list("No" = 0, "Yes" = 1),
                             selected = 0)
                  ),
        mainPanel(
                  plotOutput(outputId = "RQ1"),
                  helpText("When the rows containing the outliers are removed based on the rosner tests, the distributions of the data have been drastically changed. Accordingly, we should have those pesky outliers gone.")
                  )
        ),
        
        # Data Analysis RQ 2 Tab 
        tabItem(tabName = "RQ_2",
                h2("RQ 2: Are there seasonalities from 2011-2019?"),
                fluidRow(
                  selectInput("RQ2_Selection", label = "Select a variable",
                              choices = list("Food" = 1,
                                             "Food.Pounds" = 2, "Clothing" = 3,
                                             "Diapers" = 4, 
                                             "Hygiene.Kits" = 5), selected = 1)
                ),
                mainPanel(
                  plotOutput(outputId = "RQ2"),
                  helpText("In general, between 2011 to 2019, Sum of the amount of resources tend to peak for May and June, then decline after summer and rise again during winter. So time series of the resource amount typically show increasing pattern from February through May, declining pattern from July to september and increasing pattern again from September to January.")
                )
        ),
        
        # Data Analysis RQ 3 Tab 
        tabItem(tabName = "RQ_3",
                h2("RQ 3: Are there differences between seasonalities from 2000-2010 and seasonalities from 2011-2019?"),
                fluidRow(
                  selectInput("RQ3_Selection", label = "Select a variable",
                              choices = list("Food" = 1,
                                             "Food.Pounds" = 2, "Clothing" = 3,
                                             "Diapers" = 4, 
                                             "Hygiene.Kits" = 5), selected = 1)
                ),
                mainPanel(
                  plotOutput(outputId = "RQ3"),
                  helpText("In general, between 2000 to 2010, sum of the amount of resources tended to peak for July and then decline after summer. So time series of the resource amount typically showed increasing pattern from January through July and declining pattern from July to December.")
                )
        ),
        
        # Data Analysis RQ 4 Tab 
        tabItem(tabName = "RQ_4",
                h2("RQ 4: Do outliers matter in terms of correlation? (the coding takes about 10 seconds)"),
                fluidRow(
                  radioButtons("RQ4_Outlier", label = "Do you want to remove outliers?",
                               choices = list("No" = 0, "Yes" = 1),
                               selected = 0)
                ),
                mainPanel(
                  plotOutput(outputId = "RQ4"),
                  helpText("There is statistically significant relationship between 1) Clothing and Food, 2) Diapers and Food, 3) Hygiene.Kits and Bus, 4) Hygiene.Kits and Food, 5) Hygiene.Kits and Diapers, and 6) Clothing and Food.pounds. The outliers affect correlations and distributions significantly.")
                )
        )
      )
  )
)

server = function(input, output) {
  
  # Introduction
  output$Introduction <- renderText({
    paste(Int1)
  })
    
  # Data Analysis - RQ 1
  output$RQ1 <- renderPlot({
    boxplot1(input$RQ1_Outlier)
  })

  # Data Analysis - RQ 2
  output$RQ2 <- renderPlot({
    season2(input$RQ2_Selection)
  })

  # Data Analysis - RQ 3
  output$RQ3 <- renderPlot({
    season1(input$RQ3_Selection)
  })
  
  # Data Analysis - RQ 4
  output$RQ4 <- renderPlot({
    corr1(input$RQ4_Outlier)
  })
}

shinyApp(ui = ui, server = server)      