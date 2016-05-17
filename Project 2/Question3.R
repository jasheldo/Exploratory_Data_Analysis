#****************************************************************************************************
#Exploratory Data Analysis
#Project 2, Week 4
#Question 3
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

#Check whether or not the package "ggplot2" is installed.  If not, download it.
if(is.installed("ggplot2") == FALSE) {
    install.packages("ggplot2")
}
#Load ggplot2  This makes everything easier.
library(ggplot2)

#Set the working directory and load the already downloaded files.
setwd("C:/Users/jsheld01/Desktop")

NEI <- readRDS("./data/summarySCC_PM25.rds")

#It's not important that SCC be read in right now.  Just building the base code to share with later
#R scripts.
#SCC <- readRDS("./data/Source_Classification_Code.rds")

#Use dplyr function filter to pull out only the Blatimore City (FIPS == "24510") from NEI.
NEI_BCM_POINT <- filter(NEI, fips == "24510" & type == "POINT")
NEI_BCM_NONPOINT <- filter(NEI, fips == "24510" & type == "NONPOINT")
NEI_BCM_ONROAD <- filter(NEI, fips == "24510" & type == "ON-ROAD")
NEI_BCM_NONROAD <- filter(NEI, fips == "24510" & type == "NON-ROAD")

#Use dplyr function group_by to group the data by years
years_point <- group_by(NEI_BCM_POINT, year)
years_nonpoint <- group_by(NEI_BCM_NONPOINT, year)
years_onroad <- group_by(NEI_BCM_ONROAD, year)
years_nonroad <- group_by(NEI_BCM_NONROAD, year)

#summarize the emissions data element by year, removing the NA values.
summ_point <- summarize(years_point, pm25 = sum(Emissions, na.rm = TRUE))
summ_nonpoint <- summarize(years_nonpoint, pm25 = sum(Emissions, na.rm = TRUE))
summ_onroad <- summarize(years_onroad, pm25 = sum(Emissions, na.rm = TRUE))
summ_nonroad <- summarize(years_nonroad, pm25 = sum(Emissions, na.rm = TRUE))

#Open the PNG graphics device and write the plot to that device.
png("plot3.png")

qplot() + geom_line(data = summ_point, aes(x = year, y = pm25, color = "POINT")) +
    geom_line(data = summ_nonpoint, aes(x = year, y = pm25, color = "NONPOINT")) +
    geom_line(data = summ_onroad, aes(x = year, y = pm25, color = "ON-ROAD")) +
    geom_line(data = summ_nonroad, aes(x = year, y = pm25, color = "NON-ROAD")) +
    xlab("Year") + ylab(expression("Total" ~ PM[25] ~ "Measured (tonnes)")) + 
    ggtitle(expression("Baltimore City, MD" ~ PM[2.5] ~ "Emmission by Source, Type and Year")) + 
    scale_fill_manual(name = "Type")

#close the PNG graphics device connection
dev.off()