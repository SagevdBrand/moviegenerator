library(shiny)
library(tidyverse)
#source("Functions.R")
data <- read_csv("data/appdata.csv")
genres <- read_rds("data/genres.Rds") 


ui <-
  shinyUI(fluidPage(includeCSS("bootstrap.css"),
                        h1("Random movie generator"),
                        hr(),
                        h3("Tired of endless searching `on the Google` for a movie to watch?"),
                        h3("Select two genres and hit the button below to get a movie-suggestion."),
                        br(),
                        br(),
                        ##Input
                        selectInput(
                          inputId = "choice1",
                          label = "Genre 1",
                          choices = c(paste0(genres))
                        ), # close select input
                        
                        selectInput(
                          inputId = "choice2",
                          label = "Genre 2",
                          choices = c(paste0(genres))
                        ), # close select input
                        
                        ## Button
                        br(),
                        actionButton(
                          inputId = "actionbutton",
                          label = "Get me a movie!",
                          icon = icon("refresh")
                        ), # close action button
                      
                      ## Output
                      br(),
                      br(),
                    br(),
                      h2(textOutput(
                        outputId = "movie", inline = T) #close textOutput
                    ), # close h2
                    br(),
                    br(),
                    tags$footer("Full list of movies downloaded from",
                                a(href = "this kaggle dataset", "https://www.kaggle.com/rounakbanik/the-movies-dataset"))
                  ) # close fluidPage
                ) # close ShinyUI




server <- function(input, output) {
  
  
  output$movie <- renderText({
    
    
    input$actionbutton
    isolate(
    if (input$choice1 == "Empty" & input$choice2 == "Empty") {
      
      print("Please provide at least 1 genre")
      
    } else if (input$choice1 == "Empty") {
      
      t_r <-  which(str_detect(data$genres, input$choice2))
      as.character(data[floor(runif(1, min = 0, max = length(t_r))), 2])
      
    } else if (input$choice2 == "Empty") {
      
      t_r <-  which(str_detect(data$genres, input$choice1))
      as.character(data[floor(runif(1, min = 0, max = length(t_r))), 2])
      
    } else {
      
      # First get the rownumbers of those movies that contain both genres
      t_r <- intersect(which(str_detect(data$genres, input$choice1)), 
                       which(str_detect(data$genres, input$choice2)))
      # Get a random rownumber and return it's respective title
      as.character(data[floor(runif(1, min = 0, max = length(t_r))), 2])
    })
    
    
    })
  
  
}

shinyApp(ui = ui, server = server)
