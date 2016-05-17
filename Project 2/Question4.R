#****************************************************************************************************
#Exploratory Data Analysis
#Project 2, Week 4
#Question 4
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

if(is.installed("plyr") == FALSE) {
    install.packages("plyr")
}

if(is.installed("ggplot2") == FALSE) {
    install.packages("ggplot2")
}

#Load some packages
library(plyr)
library(dplyr)
library(ggplot2)

#Set the working directory and load the already downloaded files.
setwd("C:/Users/jsheld01/Desktop")

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

#Isolate coal combusion in the SCC table
SCC_coal <- filter(SCC, EI.Sector == "Fuel Comb - Electric Generation - Coal" | 
                       EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal" | 
                       EI.Sector == "Fuel Comb - Comm/Institutional - Coal")

#Pare down NEI to include only the codes we just found.
NEI_coal <- filter(NEI, SCC %in% SCC_coal$SCC)

#Use ddply function to group and summarize by year and type
NEI_coal_summ <- ddply(NEI_coal,.(year,type),function(x) sum(x$Emissions))

#Open the PNG graphics device and write the plot to that device.
png("plot4.png")

qplot(year,V1, data = NEI_coal_summ, color = type, geom = "line") + 
    xlab("Year") + ylab(expression("Total" ~ PM[25] ~ "Measured (tonnes)")) + 
    ggtitle(expression("Total US" ~ PM[2.5] ~ "Emmission Due to Coal Sources by Type and Year"))

#close the PNG graphics device connection
dev.off()