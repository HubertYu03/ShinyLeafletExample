library(shiny)
library(bslib)
library(leaflet)

# Define UI ----
ui <- fluidPage(
  # Link to external CSS file
  includeCSS("www/styles.css"),

  # UI components
  div(
    class = "header",
    p(span("Capstone", class = "header-color"),
      "Project Name",
      class = "title-text"
    ),
  ),

  # Sidebar contents
  sidebarLayout(
    # Main panel where the map lives
    mainPanel(
      class = "main-panel",
      leafletOutput("map", width = "100%", height = 800)
    ),

    # Sidebar component
    sidebarPanel(
      class = "sidebar-panel",
      h1("Sidebar Panel"),
      div(uiOutput("coords"), class = "coords"),

      # Weather hazard selection
      selectInput(
        "hazard",
        label = "Select weather condition: ",
        choices = c("Precipitation", "Wind", "Snow"),
        selected = "Rain",
      ),

      # Scenario selection
      selectInput(
        "scenario",
        label = "Select Scenario",
        choices = NULL
      ),

      # Metric Selection
      selectInput(
        "metric",
        label = "Select Metric",
        choices = c("50yr")
      ),
      uiOutput("result"),
      "Result based on selection"
    )
  ),
)
