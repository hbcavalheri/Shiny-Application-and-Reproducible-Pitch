library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Non-stop flights from Brazil to United States"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
      sidebarPanel(
          selectInput("checkGroup1", label = h3("Flights from Brazil or United States"), 
                      choices = list("Brazil" = 1, "United States" = 2),
                      selected = 1),
          checkboxGroupInput("checkGroup2",label=NULL)),
      mainPanel(
          plotOutput("plot"),
          h3("Selected flights"),
          tableOutput("text1")
      )
  )
)
)