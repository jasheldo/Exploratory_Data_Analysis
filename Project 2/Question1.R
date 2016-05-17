#****************************************************************************************************
#Exploratory Data Analysis
#Project 2, Week 4
#Question 1
#Submission by James Sheldon, 2016/May/17
#****************************************************************************************************
#Create a function to test whether or not a package is installed.
is.installed <- function(mypkg) { 
    is.element(mypkg, installed.packages()[,1]) 
}

#Check whether or not the package "dplyr" is installed.  If not, download it.
if(is.installed("dplyr") == FALSE) {
    install.packages("dplyr")
}
#Load dplyr.  This makes everything easier.
library(dplyr)

#Set the working directory and load the already downloaded files.
setwd("C:/Users/jsheld01/Desktop")

NEI <- readRDS("./data/summarySCC_PM25.rds")

#It's not important that SCC be read in right now.  Just building the base code to share with later
#R scripts.
#SCC <- readRDS("./data/Source_Classification_Code.rds")

#Use dplyr group_by package to group the data by years
years <- group_by(NEI, year)

#summarize the emissions data element by year, removing the NA values.
summ <- summarize(years, pm25 = sum(Emissions, na.rm = TRUE))

#Open the PNG graphics device and write the plot to that device.
png("plot1.png")

plot(summ$year, summ$pm25, lty = 1, lwd = 2, xlab = "Year", 
     ylab = expression("Total" ~ PM[25] ~ "Measured (tonnes)"), pch = 19, 
     main = "Total Pollutant Measured by Year", type = "l")

#close the PNG graphics device connection
dev.off()