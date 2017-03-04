#Set working directory
setwd("/Users/declanbarnes/Documents/FinalYearProject/DataSets/")

#Libraries
library(HistogramTools)
library(RMySQL)
library(DBI)
library(stats)
library(C50)
library(ggmap)
library(ggplot2)
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

# create circles data frame from the centers data frame
make_circles <- function(centers, radius, nPoints = 100){
  # centers: the data frame of centers with ID
  # radius: radius measured in kilometer
  #
  meanLat <- mean(centers$latitude)
  # length per longitude changes with lattitude, so need correction
  radiusLon <- radius /111 / cos(meanLat/57.3) 
  radiusLat <- radius / 111
  circleDF <- data.frame(ID = rep(centers$ID, each = nPoints))
  angle <- seq(0,2*pi,length.out = nPoints)
  
  circleDF$lon <- unlist(lapply(centers$longitude, function(x) x + radiusLon * cos(angle)))
  circleDF$lat <- unlist(lapply(centers$latitude, function(x) x + radiusLat * sin(angle)))
  return(circleDF)
}

# here is the data frame for all circles
myCircles <- make_circles(data, 0.1)

# getting the map
island <- get_map(location = c(lon = mean(leinster$long_xcord), lat = mean(leinster$lat_ycord)), zoom = 8,
                     source="google",maptype="roadmap")
#show map
islandMap <- ggmap(island)


RL = geom_point(aes(x = longitude, y = latitude), data = data, color = "#ff0000")

islandMap + RL + 
  scale_x_continuous(limits = c(-8.5, -5), expand = c(0, 0)) + 
  scale_y_continuous(limits = c(52.1, 54.2), expand = c(0, 0)) +
  ########### add circles
  geom_point(aes(x = lon, y = lat, group = ID), data = myCircles, size = 10, shape = 1,  color = "darkblue")

