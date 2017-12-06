library(dplyr)
data2<-flights%>%select(AIRLINES,AIR_SYSTEM_DELAY,SECURITY_DELAY,AIRLINE_DELAY,LATE_AIRCARFT_DELAY,WEATHER_DELAY)
data2[is.na(data2)]<-0
data3<-data2%>%
  group_by(AIRLINES)%>%
  summarize(AIR_SYSTEM_DELAY=sum(AIR_SYSTEM_DELAY),
            SECURITY_DELAY=sum(SECURITY_DELAY),
            AIRLINE_DELAY=sum(AIRLINE_DELAY),
            LATE_AIRCARFT_DELAY=sum(LATE_AIRCARFT_DELAY),
            WEATHER_DELAY=sum(WEATHER_DELAY))
col<-data3$AIRLINES
data4<-as.data.frame(t(data3[,-1]))
colnames(data4)<-col
data5<- data.frame("Reason"=rownames(data4),data4)
delayReason <- function(x){
  ax <- list(
    title = "",
    zeroline = FALSE,
    showline = FALSE,
    showticklabels = FALSE,
    showgrid = FALSE
  )
  data6<-data5[,c('Reason',x)]
  library(plotly)
  p<-plot_ly(data6,labels=data6$Reason,values=data6[,x],type = 'pie',
           textposition="inside",
           textinfo="label+percent",
           hoverinfo="text",
           text=paste(data6[,x],"times"),
           insidetextfont=list(color="#FFFFFF"),
           marker=list(colors=c("red","yellow","green","blue","purple"))
  )%>%
    layout(title=paste("What are the reasons for delay in",x,"in 2015 ?"),showlegend=TRUE,xaxis = ax, yaxis = ax)
  return(p)
}
