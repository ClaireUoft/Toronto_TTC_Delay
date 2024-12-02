
library(shiny)
library(ggplot2)
library(dplyr)
library(here)
library(readr)
library(shinyjs)
library(arrow)

# Load your dataset (e.g., the cleaned TTC delay dataset)

ttc_data <- read_parquet(here::here("data/02-analysis_data/cleaned_combined_data.parquet"))

# Define the User Interface (UI)
ui <- fluidPage(
  titlePanel("TTC Delay Analysis"),
  sidebarLayout(
      sidebarPanel(
        selectInput("transit_mode", "Select Transit Mode:", 
                    choices = unique(ttc_data$Transit_mode), 
                    selected = "Bus"),
        sliderInput("delay_range", "Select Delay Duration Range (Minutes):",
                    min = 0, max = 60, value = c(0, 45)),
        selectInput("day_of_week", "Select Day of the Week:",
                    choices = unique(ttc_data$Day), 
                    selected = "Monday"),
        selectInput("transit_line", "Select Transit Line:", 
                    choices = unique(ttc_data$Line), 
                    selected = unique(ttc_data$Line)[1]),
        selectInput("location", "Select Location:",
                    choices = unique(ttc_data$Location),
                    selected = unique(ttc_data$Location)[1])
    ),
    mainPanel(
        h4("Interactive Analysis of TTC Transit Delays"),
        p("Use the controls on the left to filter data and explore trends in transit delays for the Toronto Transit Commission's buses, streetcars, and subways. The graphs will dynamically update to reflect your selections."),
        plotOutput("delayPlot"),
        plotOutput("timePlot")
    )
  )
)

# Define the Server
server <- function(input, output) {
  # Reactive dataset based on user input
  filtered_data <- reactive({
    ttc_data %>%
      filter(Transit_mode == input$transit_mode,
             `Min Delay` >= input$delay_range[1],
             `Min Delay` <= input$delay_range[2],
             Day == input$day_of_week)
  })
  
  # Plot delay distribution
  output$delayPlot <- renderPlot({
    ggplot(filtered_data(), aes(x = `Min Delay`)) +
      geom_histogram(binwidth = 5, fill = "blue", alpha = 0.7) +
      labs(title = "Delay Duration Distribution",
           x = "Delay Duration (Minutes)",
           y = "Frequency")
  })
  
  # Plot average delay by hour of the day
  output$timePlot <- renderPlot({
    avg_delay_data <- filtered_data() %>%
      group_by(Time) %>%
      summarise(avg_delay = mean(`Min Delay`, na.rm = TRUE))
    
    ggplot(avg_delay_data, aes(x = Time, y = avg_delay)) +
      geom_line(color = "red") +
      labs(title = "Average Delay by Hour of the Day",
           x = "Time of Day",
           y = "Average Delay (Minutes)")
  })
}

# Run the Application
shinyApp(ui = ui, server = server)

