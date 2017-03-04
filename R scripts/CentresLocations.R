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

#Set directory
setwd("/Users/declanbarnes/Documents/FinalYearProject/DataSets/")
#Read in CSV file
csvFile <- read.csv("DisabledSurvey.csv")

#SQL Query to find the amount of disabled people(Male & Female) in each county in Ireland.
query <- dbSendQuery(con, "Select Sex,County,Amount From disabilitydb.disabledsurvey where Category = 'Total persons with a disability'; ")

#fetch data, number of rows=1822
data <- fetch(query, n=1822)

#checj that the fetchhas gotten everything
isFinished <- dbHasCompleted(query)

#convert data into a data-frame
data.frame(data)

#check data
data

#Export data to MySQL database as a table called BothSexesStats
dbWriteTable(con, value = data, name = "BothSexesStats", append = TRUE )
##################################

#Using ggmap to plot current HSE support centres

#read in data
centres <- read.csv("healthcentres.csv", header=TRUE)

#subset data to only include Leinster
leinster <- subset(centres, County =="Wicklow" | County =="Wexford" | County =="Dublin" | County =="Kildare" 
                   | County =="Meath" | County =="Carlow" | County =="Kilkenny" 
                   | County =="Laois" | County =="Offaly" | County =="Westmeath" 
                   | County =="Longford" | County =="Louth")

# getting the map
currentCentres <- get_map(location = c(lon = mean(leinster$long_xcord), lat = mean(leinster$lat_ycord)), zoom = 8,
                          source="google",maptype="roadmap",crop=FALSE)
#show map
ggmap(currentCentres)

# Adding Latitude and Longitude points to the map
map <- ggmap(currentCentres, legend = "none")+geom_point(aes(x = leinster$long_xcord, y = leinster$lat_ycord), 
                          data = leinster, alpha = .7, color = "red", size = 1)
#Display map with Latitude and Longitude points 
print(map)




