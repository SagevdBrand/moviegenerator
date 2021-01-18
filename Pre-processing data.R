library(tidyverse)

# Loading the data
# Data downloaded from: https://www.kaggle.com/rounakbanik/the-movies-dataset
df <- read_csv("data/movies_metadata.csv")

# We only need the following columns
data <- df %>% select(id, original_title, genres)

# The genre column is a bit messy, we only really need the names of the genres:
data$genres <-str_extract_all(data$genres, "(?<=\\:[[:blank:]]\\')[[:alpha:]]+(?=\\'\\})")

# How many unique genres are there actually?
test <- c(unlist(data$genres))

# Let's save those to make radio buttons out of
genres <- unique(test)
genres <- c("Empty", genres)

# Lists are not going to be nice to work with later on, so I'd rather just have a string of the characters:
data$genres <- sapply(data$genres, paste0, collapse=" ")

# Save the data
write_csv(data, "data/appdata.csv")
write_rds(genres, "data/genres.Rds")

 