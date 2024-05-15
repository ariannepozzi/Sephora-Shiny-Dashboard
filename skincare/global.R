library(shiny)
library(shinydashboard)
library(dplyr)
library(readr)
library(tidyr)

# Load the product info dataset and reviews, then clean the data
product_info <- read_csv("./files/Product_info.csv")
reviews_1250_end <- read_csv("./files/reviews_1250-end.csv") %>%
  mutate(author_id = as.character(author_id))  # Ensure author_id is character type

# Function to clean data: fill missing values with the median for numeric columns
clean_data <- function(df) {
  df %>% mutate(across(where(is.numeric), ~replace_na(., median(., na.rm = TRUE))))
}

# Apply the cleaning function
product_info_clean <- clean_data(product_info)
reviews_1250_end_clean <- clean_data(reviews_1250_end)
