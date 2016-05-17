#****************************************************************************************************
#Exploratory Data Analysis
#Project 2, Week 4
#Question 5
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

#Isolate motor vehicle sources from the SCC file.  It was determined that the most comprehensive 
#method of getting the data is taking a subset of EI.Sector using the keyword "vehicle", not case
#sensitive.  This was determined by outputting the file to CSV and performing some quick summary 
#analyses in Excel.
SCC_vehicle <- filter(SCC, EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles" | 
                       EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" | 
                       EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles" | 
                       EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles")

#Pare down NEI to include only the codes we just found and only Baltimore City, MD.
NEI_vehicle <- filter(NEI, SCC %in% SCC_vehicle$SCC)

NEI_vehicle <- filter(NEI_vehicle, fips == "24510")

#Use ddply function to group and summarize by year and type
NEI_vehicle_summ <- ddply(NEI_vehicle,.(year,type),function(x) sum(x$Emissions))

#Open the PNG graphics device and write the plot to that device.
png("plot5.png")

qplot(year,V1, data = NEI_vehicle_summ, color = type, geom = "line") + 
    xlab("Year") + ylab(expression("Total" ~ PM[25] ~ "Measured (tonnes)")) + 
    ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Yearly Motor Vehicle Emissions"))

#close the PNG graphics device connection
dev.off()