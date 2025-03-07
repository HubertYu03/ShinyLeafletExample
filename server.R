library(shiny)
library(leaflet)
library(RNetCDF)

# Define server logic ----
server <- function(input, output, session) {
  data <- open.nc("snow_out50.nc", write = FALSE)

  file.inq.nc(data)["format"]

  print(var.get.nc(data, "value"))

  lat_data <- var.get.nc(data, "lat")
  lon_data <- var.get.nc(data, "lon")
  snow_data <- var.get.nc(data, "value")

  close.nc(data)

  output$coords <- renderUI({
    "Latitude: 0.0000 | Longitude: 0.0000"
  })

  output$map <- renderLeaflet({
    leaflet(options = leafletOptions(
      dragging = FALSE,
      zoomControl = FALSE,
      scrollWheelZoom = FALSE,
      doubleClickZoom = FALSE,
      touchZoom = FALSE
    )) |>
      addTiles() |>
      setView(lat = 37.8402, lng = -118.4546, zoom = 6)
  })

  # Observing the hazard input
  observeEvent(input$hazard, {
    # Update available scenario
    if (input$hazard == "Snow") {
      updateSelectInput(
        session = session,
        "scenario",
        choices = c(370),
        selected = 370
      )
    } else if (input$hazard == "Wind") {
      updateSelectInput(
        session = session,
        "scenario",
        choices = c(245, 370),
        selected = 245
      )
    } else if (input$hazard == "Precipitation") {
      updateSelectInput(
        session = session,
        "scenario",
        choices = c(245, 370),
        selected = 245
      )
    }
  })

  # Listen for the map click events
  observeEvent(input$map_click, {
    lat <- input$map_click$lat
    lng <- input$map_click$lng

    output$coords <- renderUI({
      div("Latitude: ", round(lat, 4), " | Longitude: ", round(lng, 4))
    })


    leafletProxy("map") |>
      clearMarkers() |>
      addMarkers(lat = lat, lng = lng, popup = paste(round(lat, 4), " | ", round(lng, 4))) # nolint
  })
}
