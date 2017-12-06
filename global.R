require(plotly)||install.packages("plotly")
require(data.table)||install.packages("data.table")
flights <- fread("flight_edited.csv", stringsAsFactors = F)
