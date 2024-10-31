library(shiny)
library(plotly)
library(bslib)
library(ggplot2)
library(gridExtra)
library(RColorBrewer)

## Preprocessing the data
car_data <- read.csv("Automobile.csv")
head(car_data)
str(car_data)

# Check for missing values
missing_values <- which(is.na(car_data), arr.ind = TRUE)
print(missing_values)
print(paste("Column 5 is",colnames(car_data)[5]))
car_data <- na.omit(car_data)

car_data$model_year <- as.character(car_data$model_year)
car_data$model_year <- paste0("19",car_data$model_year)
car_data$cylinders <- as.character(car_data$cylinders)
car_data$L_100km <- 235.215 / car_data$mpg # Converting mpg to L/100km
cat_var <- c("name", "brand", "model_year", "origin", "cylinders")
num_var <- c("L_100km", "displacement", "horsepower", "weight", "acceleration")

# Unique Carbrands
car_data$brand <- sapply(strsplit(car_data$name, " "), `[`, 1)
paste0("Unique car models: ",length(unique(car_data$name)),', Unique car brands: ', length(unique(car_data$brand)))


## Define UI for the application with a Minty theme
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
      actionLink("intro", "1. Introduction"),
      br(),
      actionLink("explore", "2. Explore Data")
    ), 
    
    # Main content area, which will update based on selected link
    mainPanel(
      # Output container for dynamic content
      uiOutput("content")
    )
  )
)

## Define server logic to switch content based on link selection
server <- function(input, output, session) {
  
  # Create a reactive value to keep track of the selected section
  rv <- reactiveValues(selected_tab = "intro") # Default to "intro" on load
  
  # Update the reactive value based on which link is clicked
  observeEvent(input$intro, {
    rv$selected_tab <- "intro"
  })
  
  observeEvent(input$explore, {
    rv$selected_tab <- "explore"
  })
  
  # Render content based on the current value of selected_tab
  output$content <- renderUI({
    if (rv$selected_tab == "intro") {
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
    } else if (rv$selected_tab == "explore") {
      tagList(
        h1("Explore Data"),
        selectInput("plot_type", "Choose a plot type:",
                    choices = c("Barplots", "Density Plots", "Boxplots", "Correlations", "Violin Plots", "Clustering via PCA")),
        # Render content based on the selected plot type
        output$explore_content <- renderUI({
          if (input$plot_type == "Barplots") {
            output$barplot1 <- renderPlot({
              par(mfrow = c(1,2))
              bp <- barplot(table(car_data$origin),
                            main = "Frequency of each origin",
                            ylim = c(0,max(table(car_data$origin))+50),
                            col = brewer.pal(3, "Paired"))
              text(x=bp, y=table(car_data$origin),label=table(car_data$origin),pos=3)
              bp <- barplot(table(car_data$cylinders),
                            main = "Frequency of numb of cylinders",
                            xlab = "Amount of cylinders",
                            ylim = c(0,max(table(car_data$cylinders)+20)),
                            col = brewer.pal(3, "Paired"))
              text(x=bp, y=table(car_data$cylinders),label=table(car_data$cylinders),pos=3)
             })
            output$barplot2 <- renderPlot({
              par(mfrow = c(1,1))
              bp <- barplot(table(car_data$model_year),
                            main = "Frequency of each model year",
                            ylim = c(0,45),
                            col = brewer.pal(12, "Set1"),
                            las = 2)
              text(x=bp, y=table(car_data$model_year),label=table(car_data$model_year),pos=3)
            })
            tabsetPanel(
              header = h2("Barplots"), 
              tabPanel("Summary", 
                       p("Some info here...")),
              tabPanel("Plots",
                       # fluidRow(...)
                       plotOutput("barplot1"),
                       plotOutput("barplot2")
              )
            )
          } else if (input$plot_type == "Density Plots") {
            output$densityplots <- renderPlot({
              plot_list <- list()
              for (var in num_var) {
                p <- ggplot(car_data, aes(x = !!sym(var))) +
                  geom_density(fill = "skyblue", color = "black") +
                  labs(title = paste("Densityplot of", var)) +
                  theme_minimal() +
                  theme(plot.title = element_text(hjust = 0.5))
                plot_list[[length(plot_list) + 1]] <- p
              }
              grid.arrange(grobs = plot_list, ncol = 2, nrow = 3)
            })
            tabsetPanel(
              header = h2("Density Plots"), 
              tabPanel("Summary", 
                       p("Some info here...")),
              tabPanel("Plots",
                       # fluidRow(...)
                       plotOutput("densityplots", height = 1500)
              )
            )
          } else if (input$plot_type == "Boxplots") {
            output$boxplots <- renderPlot({
              plot_list <- list()
              for (i in num_var) {
                # Making a table with the frequencies of each number of cylinders
                measurements <- car_data %>%
                  group_by(cylinders) %>%
                  summarise(count = sum(!is.na(!!sym(i))))
                
                p <- ggplot(car_data, aes(x = as.factor(cylinders), y = !!sym(i))) +
                  geom_boxplot(fill = "skyblue", color = "black") +
                  # Adding the frequency for the amount of cylinders
                  geom_text(data = measurements, aes(label = paste(count, "Measurements"), 
                                                     x = as.factor(cylinders), 
                                                     y = max(car_data[[i]], na.rm = TRUE)),
                            vjust = -1, size = 3) +
                  labs(title = paste("Cylinders ~", i), x = "Amount of cylinders") +
                  theme_minimal() + 
                  theme(plot.title = element_text(hjust = 0.5))
                plot_list[[length(plot_list) + 1]] <- p
              }
              grid.arrange(grobs = plot_list, ncol = 1, nrow = 5)
            })
            tabsetPanel(
              header = h2("Boxplots"), 
              tabPanel("Summary", 
                       p("Some info here...")),
              tabPanel("Plots",
                       # fluidRow(...)
                       plotOutput("boxplots", height = 3000)
              )
            )
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
