install.packages("tidyr","dplyr")
library(tidyr)
library(dplyr)

setwd("/Users/declanbarnes/Desktop")
myData <- read.csv("disability.csv", stringsAsFactors = FALSE)
head(myData)

gather(myData, key, value, Sex, Category, na.rm = FALSE, convert = FALSE,factor_key = FALSE)

