setwd("/Users/declanbarnes/Desktop/")
data <-read.csv("Total Disabilities By Sex.csv")
names(data)
library(ggplot2)
plot(MalesWithADisability~FemalesWithADisability,data=data)

