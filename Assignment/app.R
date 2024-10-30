# Load the Shiny and bslib packages
library(shiny)
library(bslib)

# Define UI for the application with a Minty theme
ui <- fluidPage(
  
  # Apply Minty theme from Bootstrap 5
  theme = bs_theme(version = 5, bootswatch = "minty"),
  
  # Application title
  titlePanel("Car Information Dataset Analysis"),
  
  # Sidebar layout with input and output definitions
  sidebarLayout(
    
    # Sidebar panel with navigation links
    sidebarPanel(
      width = 2,
      h3("Navigation"),
      actionLink("intro", "Introduction"),
      br(),
      actionLink("explore", "Explore Data")
    ), 
    
    # Main content area, which will update based on selected link
    mainPanel(
      # Output container for dynamic content
      uiOutput("content")
    )
  )
)

# Define server logic to switch content based on link selection
server <- function(input, output, session) {
  
  # Create a reactive value to keep track of the selected section
  selected_tab <- reactiveVal("intro") # Default to "intro" on load
  
  # Update the reactive value based on which link is clicked
  observeEvent(input$intro, {
    selected_tab("intro")
  })
  
  observeEvent(input$explore, {
    selected_tab("explore")
  })
  
  # Render content based on the current value of selected_tab
  output$content <- renderUI({
    if (selected_tab() == "intro") {
      tagList(
        h1("Introduction of the Data"),
        p("The dataset contains 399 rows of 9 features, which provide general properties of various cars. These 9 features are the following:"),
        
        # Displaying list of features
        tags$ol(
          tags$li("Name: Unique identifier for each automobile."),
          tags$li("MPG: Fuel efficiency measured in miles per gallon."),
          tags$li("Cylinders: Number of cylinders in the engine."),
          tags$li("Displacement: Engine displacement, indicating its size or capacity."),
          tags$li("Horsepower: Power output of the engine."),
          tags$li("Weight: Weight of the automobile in pounds."),
          tags$li("Acceleration: Capability to increase speed, measured in seconds to 60 miles/hour."),
          tags$li("Model Year: Year of manufacture for the automobile model."),
          tags$li("Origin: Country or region of origin for each automobile.")
        ),
        
        # Link to the dataset
        p("The dataset can be found via this ",
          a("link", href = "https://www.kaggle.com/datasets/tawfikelmetwally/automobile-dataset", target = "_blank"))
      )
    } else if (selected_tab() == "explore") {
      tagList(
        h1("Explore Data"),
        selectInput("plot_type", "Choose a plot type:",
                    choices = c("Barplots", "Density Plots", "Boxplots", "Correlations", "Violin Plots", "Clustering via PCA")),
        # Render content based on the selected plot type
        output$explore_content <- renderUI({
          if (input$plot_type == "Barplots") {
            h2("Barplots")
          } else if (input$plot_type == "Density Plots") {
            h2("Density Plots")
          } else if (input$plot_type == "Boxplots") {
            h2("Boxplots")
          } else if (input$plot_type == "Correlations") {
            h2("Correlations")
          } else if (input$plot_type == "Violin Plots") {
            h2("Violin Plots")
          } else if (input$plot_type == "Clustering via PCA") {
            h2("Clustering via PCA")
          }
        })
      )
    }
  })
}

# Run the application
shinyApp(ui = ui, server = server)
