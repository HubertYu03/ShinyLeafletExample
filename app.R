library(shiny)

# Pulling from UI and Server files
source("ui.R")
source("server.R")

# Run the app ----
shinyApp(ui = ui, server = server)
