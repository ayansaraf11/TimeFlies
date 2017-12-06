library(dplyr)
library(formattable)
source("delayPlot.R")
source("delay_reason.R")
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  value1 <- reactiveVal("Seattle-Tacoma International Airport")
  value2 <- reactiveVal("Oakland International Airport")
  output$delay_plot <- renderPlotly({
    name <- state.abb[[grep(input$state,state.name)]]
    return(mapplot(name))
  })
  
  output$delay_reason <- renderPlotly({
    return(delayReason(input$airlines))
  })
  output$origin_airport <- renderUI({
    if (is.null(input$state1))
      return()
    name1 <- state.abb[[grep(input$state1,state.name)]]
    airport.state.origin <- filter(airports,STATE == name1)
    selectInput("origin.airport","Choose Origin Airport",choices = c(airport.state.origin$AIRPORT),selected = value1())
  })
  output$destination_airport <- renderUI({
    if (is.null(input$state2))
      return()
    name <- state.abb[[grep(input$state2,state.name)]]
    airport.state <- filter(airports,STATE == name)
    selectInput("destination.airport","Choose Destination Airport",choices = c(airport.state$AIRPORT),selected = value2())
  })
  results <- table(unique(flights$AIRLINE_NAME))
  
  observeEvent(
    input$submit,{
      airport_code(input$origin.airport,input$destination.airport)
      output$table_info <- renderTable({
        airport_code(input$origin.airport,input$destination.airport)
      })
    }
  )
  
})
