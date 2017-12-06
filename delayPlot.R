airports <- read.csv("airports.csv", stringsAsFactors = F)
colnames(airports)[1] <- "ORIGIN_AIRPORT"

flights_airports <- select(flights, ORIGIN_AIRPORT, DEPARTURE_DELAY) 
total_flights_num <- group_by(flights_airports, ORIGIN_AIRPORT) %>% summarise(total_num = n())
delay_flight_num <- filter(flights_airports, DEPARTURE_DELAY > 0) %>% group_by(ORIGIN_AIRPORT) %>% summarise(delay_num = n())
flight_info <- left_join(total_flights_num, delay_flight_num, by = "ORIGIN_AIRPORT")
flight_info <- mutate(flight_info, delay_rate = percent(delay_num / total_num))

flight_airports_info <- left_join(airports, flight_info, by = "ORIGIN_AIRPORT")
mapplot <- function(state){
  data_select <- filter(flight_airports_info, STATE == state)
  g <- list(
    scope = 'usa',
    projection = list(type = 'albers usa'),
    showland = TRUE,
    landcolor = toRGB("gray95"),
    subunitcolor = toRGB("gray85"),
    countrycolor = toRGB("gray85"),
    countrywidth = 0.5,
    subunitwidth = 0.5
  )
  
  x <- plot_geo(data_select, lat = ~LATITUDE, lon = ~LONGITUDE,colors = c("green","red")) %>% 
    add_markers(
      color = ~delay_rate, 
      symbol = I("circle"), 
      size = I(10), 
      hoverinfo = "text",
      text = paste(data_select$AIRPORT, data_select$CITY, data_select$STATE, sep = "<br />")
    ) %>%
    colorbar(title = "Delay Rate") %>%
    layout(
      title = "US Airport Delay Rate", geo = g
    )
  return(x)
}
airport_code <- function(airport_name_origin,airport_name_destination){
  parsed.data.origin <- filter(airports,airports$AIRPORT==airport_name_origin) 
  result.data.origin <- parsed.data.origin$ORIGIN_AIRPORT
  parsed.data.destination <- filter(airports,airports$AIRPORT==airport_name_destination) 
  result.data.destination <- parsed.data.destination$ORIGIN_AIRPORT
  table_data <- flights[which((flights$DEPARTURE_DELAY<=0) & (flights$ARRIVAL_DELAY<=0) &(flights$ORIGIN_AIRPORT==result.data.origin) & (flights$DESTINATION_AIRPORT==result.data.destination)),]
  results <- sort(table(table_data$AIRLINE_NAME),decreasing = TRUE)
  return(results)
}

