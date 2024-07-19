library(shiny)

ui <- fluidPage(
  titlePanel("Forest Fires Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", "Variable:", 
                  choices = c("Temperature" = "temp", "Humidity" = "RH", "Wind" = "wind")),
      sliderInput("range", "Range of Interest:", min = 0, max = 40, value = c(10, 30))
    ),
    mainPanel(
      plotOutput("scatterPlot")
    )
  )
)

server <- function(input, output) {
  output$scatterPlot <- renderPlot({
    ggplot(forest_fires, aes_string(x = input$variable, y = "area")) +
      geom_point() +
      xlim(input$range[1], input$range[2]) +
      labs(x = input$variable, y = "Area Burned")
  })
}

shinyApp(ui = ui, server = server)
