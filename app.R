library(shiny)
library(leaflet)
library(dplyr)

# Sample data: Country, Latitude, Longitude, Population Density
# You should replace this with more accurate and comprehensive data
data <- read.csv(textConnection("
Country,Latitude,Longitude,PopDensity
France,46.2276,2.2137,122
Spain,40.4637,-3.7492,93
Germany,51.1657,10.4515,237
Italy,41.8719,12.5674,200
Poland,51.9194,19.1451,124
United Kingdom,55.3781,-3.4360,275
"), header = TRUE)

ui <- fluidPage(
  leafletOutput("map", width = "100%", height = "800px")
)

server <- function(input, output) {
  output$map <- renderLeaflet({
    leaflet(european_places) %>% 
      addTiles() %>% 
      addCircles(
        lng = ~Longitude, lat = ~Latitude, weight = 1,
        radius = ~count_animals * 1000,
        popup = ~paste(Place, ifelse(european_places$is_nationalPark, ", national park", ",pivate owned"), ", Density:", count_animals, " 1/ km², ", sep=""),
        color =ifelse(european_places$is_nationalPark, "#008000", "#0000FF") 
   
      )
  })
}

shinyApp(ui = ui, server = server)