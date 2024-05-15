library(shiny)
library(shinydashboard)
library(dplyr)
library(readr)
library(tidyr)
ui <- dashboardPage(
  dashboardHeader(title = "Sephora Skincare Dashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard")),
      menuItem("Trends", tabName = "trends", icon = icon("line-chart")),
      menuItem("Recommendations", tabName = "recs", icon = icon("star"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "dashboard",
              fluidRow(
                box(selectInput("product_category", "Choose Category:", choices = unique(product_info_clean$primary_category))),
                box(sliderInput("min_price", "Minimum Price:", min = min(product_info_clean$price_usd, na.rm = TRUE), max = max(product_info_clean$price_usd, na.rm = TRUE), value = min(product_info_clean$price_usd, na.rm = TRUE))),
                box(sliderInput("max_price", "Maximum Price:", min = min(product_info_clean$price_usd, na.rm = TRUE), max = max(product_info_clean$price_usd, na.rm = TRUE), value = max(product_info_clean$price_usd, na.rm = TRUE))),
                box(sliderInput("min_rating", "Minimum Rating:", min = 0, max = 5, value = 0, step = 0.1))
              ),
              fluidRow(
                box(width = 12, tableOutput("table"))
              )
      ),
      tabItem(tabName = "trends",
              fluidRow(
                box(title = "Trending Products", width = 12, plotOutput("trendPlot"))
              )
      ),
      tabItem(tabName = "recs",
              fluidRow(
                box(title = "Personalized Recommendations", width = 12, plotOutput("recsPlot"))
              )
      )
    )
  )
)
