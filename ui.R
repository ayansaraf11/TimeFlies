
library(shiny)
library(shinythemes)
shinyUI(fluidPage(
theme = shinytheme("flatly"),
  navbarPage("TimeFlies",
             tabPanel("Home",
                      titlePanel(h3("What is TimeFlies?")),
                      includeText("description.txt"),
                      br(),
                      br(),
                      titlePanel(h3("What is the source of the data used?")),
                      includeText("source.txt"),
                      br(),
                      br(),
                      titlePanel(h3("What is the future scope of TimeFlies?")),
                      includeText("scope.txt"),
                      br(),
                      br(),
                      titlePanel(h3("What were the challenges faced while making TimeFlies?")),
                      includeText("challenges.txt"),
                      br(),
                      br(),
                      titlePanel(h3("What packages were used in making this app?")),
                      includeText("packages.txt")),
  tabPanel("Airports and Delays",
    sidebarLayout(
      sidebarPanel(
        selectInput("state", h3("Choose State"), 
                  choices = c(state.name),selected = "Washington")
      ),
      
      mainPanel(
        plotlyOutput("delay_plot"),
       includeText("delayrate.txt")
      ))),
    
  tabPanel("Reasons for Delays",
     sidebarLayout(
       sidebarPanel(
         selectInput("airlines", h3("Choose Airlines"), 
                     choices = c("United Airlines Inc."= "UA", "American Airlines Inc." = "AA","US Airways Inc."="US","Frontier Airlines Inc."="F9",
                                 "JetBlue Airways"="B6","Skywest Airlines Inc."="OO","Alaska Airlines Inc."="AS","Spirit Air Lines"="NK","Southwest Airlines Co."="WN",
                                 "Delta Air Lines Inc."="DL","Atlantic Southeast Airlines"="EV","Hawaiian Airlines Inc."="HA","American Eagle Airlines Inc"="MQ","Virgin America"="VX"),selected = "AS")
       ),
       
       mainPanel(
         plotlyOutput("delay_reason"),
        includeText("delayreason.txt"),
        br(),
        br(),
        includeText("delayreason1.txt"),
        br(),
        br(),
        includeText("delayreason2.txt"),
        br(),
        br(),
        includeText("delayreason3.txt"),
        br(),
        br(),
        includeText("delayreason4.txt")
       ))),
  tabPanel("Travel Routes and delays",
           sidebarLayout(
             sidebarPanel(
          selectInput("state1", "Choose State of Origin Airport", 
             choices = c(state.name),selected = "Washington"),
          uiOutput("origin_airport"),
          selectInput("state2", "Choose State of Destination Airport", 
                      choices = c(state.name),selected = "California"),
          uiOutput("destination_airport"),
          actionButton("submit","Find Flight")),
          mainPanel(
            tableOutput("table_info"),
            br(),
            br(),
            includeText("best.txt")
          ))
  )
  )
))
