install.packages("RMySQL")
library(RMySQL)

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

#remove 1st column
data <- data[-1]

#remove 3rd column
data <- data[-3]

#show data
data

#Clear the results
dbClearResult(query)

#disconnect from MySQL
dbDisconnect(con)




