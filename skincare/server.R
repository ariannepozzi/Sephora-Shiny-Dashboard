library(shiny)
library(shinydashboard)
library(dplyr)
library(readr)
library(tidyr)

server <- function(input, output) {
 
  filtered_data <- reactive({
    product_info_clean %>%
      filter(primary_category %in% input$product_category,
             price_usd >= input$min_price, price_usd <= input$max_price,
             rating >= input$min_rating) %>%
      select(-variation_type, -variation_value, -variation_desc)  
  })
  
  # Render the filtered data in a table
  output$table <- renderTable({
    filtered_data()
  })
  
  # Plot for Trending Products with adjusted plot size
  output$trendPlot <- renderPlot({
    data <- filtered_data() %>%
      arrange(desc(loves_count)) %>%
      head(10)
    
    # Adjust margins to provide more space for labels
    par(mar = c(8, 4, 4, 2) + 0.1)  # Increase bottom margin
    
    barplot(data$loves_count, names.arg = data$product_name, las = 2, main = "Top Trending Products", 
            col = "pink", border = "white", cex.names = 0.5)  # Adjust text size
  }, width = 1000)  # Specify a wider plot to fit labels horizontally
  
  # Plot for Personalized Recommendations with adjusted plot size
  output$recsPlot <- renderPlot({
    data <- filtered_data() %>%
      arrange(desc(rating)) %>%
      head(10)
    
    # Adjust margins to provide more space for labels
    par(mar = c(8, 4, 4, 2) + 0.1)  
    
    barplot(data$rating, names.arg = data$product_name, las = 2, main = "Top Recommended Products", 
            col = "pink", border = "white", cex.names = 0.5)  
  }, width = 1000)  
}
