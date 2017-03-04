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
library(grid)


#Using ggmap to plot current HSE support centres

#read in data
centres <- read.csv("population.csv", header=TRUE)


map <- get_map(make_bbox(c(lon = mean(centres$Longitude), lat = mean(centres$Latitude), f=0.2))
               
ggmap(map) +  
  aes(x=centres$Longitude, y=centres$Latitude) + 
  stat_density_2d(aes(fill = ..level..), centres, geom="polygon") + 
  geom_point(data=centres, position="jitter", alpha=.2, colour="white")






