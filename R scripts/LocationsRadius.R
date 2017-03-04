#Set working directory
setwd("/Users/declanbarnes/Desktop/")

#Libraries
library(HistogramTools)
library(RMySQL)
library(DBI)
library(stats)
library(C50)
library(ggmap)
library(ggplot2)
library(raster)
library(gmodels)
library(googleVis)
library(knitr)
library(plotly)
library(tidyr)
library(caret)
library(dplyr)
library(lattice)
library(plyr)
library(rworldmap)
library(plotly)
library(grid)
library(leaflet)
###################################

#Connect to MySQL using credentials
con <- dbConnect(MySQL(), user="disabilitydb", password="disability1989_", dbname="disabilitydb", host="mysql3.gear.host")

#SQL Query to find the amount of disabled people(Male & Female) in each county in Ireland.
query <- dbSendQuery(con, "Select * From disabilitydb.healthcentres;")

#fetch data, number of rows=1822
centres <- fetch(query, n=1822)

#checj that the fetchhas gotten everything
isFinished <- dbHasCompleted(query)

#convert data into a data-frame
data.frame(centres)

#check data
centres

##################################

#Using ggmap to plot current HSE support centres

#subset data to only include Leinster
leinster <- subset(centres, County =="Wicklow" | County =="Wexford" | County =="Dublin" | County =="Kildare" 
                   | County =="Meath" | County =="Carlow" | County =="Kilkenny" 
                   | County =="Laois" | County =="Offaly" | County =="Westmeath" 
                   | County =="Longford" | County =="Louth")

#Create data frame
data = data.frame(
  ID = as.numeric(leinster$healthcentre_id),
  longitude = as.numeric(leinster$long_xcord),
  latitude = as.numeric(leinster$lat_ycord)
)


#Plot current centre locations
m <- leaflet() %>%
  addTiles() %>% 
  setView(-7.5050, 53.2000, zoom = 8) %>% 
  
  addCircleMarkers(data = leinster, lng = ~long_xcord, 
      lat = ~lat_ycord, radius=.5, color="black") %>% 

  addCircles(data = leinster, lng = ~long_xcord, 
      lat = ~lat_ycord, popup = leinster$Address,
      radius = 3218.69, fillOpacity = 0.3, #3218.69 = 2 miles
      color = 'black', fillColor = 'red',weight = 1, label=leinster$`Service name`) %>% 
  
  addLegend("bottomright", colors= "red", labels="Current HSE Support Centres",
             title="Location: Leinster,Ireland")

m  # Print the map
