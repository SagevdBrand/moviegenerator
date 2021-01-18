find_movie <- function(input){
    # count the empties
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
  }
}
