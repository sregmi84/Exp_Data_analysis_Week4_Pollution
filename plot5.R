###Assumption: File Downloaded and Data Unziped. See Plot1.R
setwd("~/Coursera/Exploratory Data Analysis/Week 4")

#Read in the data files
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

SCC.vehicle <-SCC[grep("veh",SCC$Short.Name,ignore.case = T),]
NEI.vehicle <- subset(NEI, fips == "24510" & NEI$SCC %in% SCC.vehicle$SCC)

#Method 1 - Create Summary of Emissions by Year Using dplyr
library(dplyr)
tot.emissions.vehicle <- NEI.vehicle %>% 
    group_by(year) %>%
    summarize(tot.emissions = sum(Emissions, na.rm = TRUE))


#Method 2 - Create Summary of Emissions by Year
#tot.emissions.vehicle <- aggregate(NEI.vehicle$Emissions, 
#                                by=list(NEI.vehicle$year), FUN=sum)
#colnames(tot.emissions.vehicle) <- c("year", "tot.emissions")

#Method 1 - Create Plot using ggplot2
library(ggplot2)
g <- ggplot(tot.emissions.vehicle, aes(year, tot.emissions))

vehicle.plot <- g + 
    geom_point(color = "green", 
               size = 2, 
               alpha = 1/2) + 
    xlab("Year") +
    ylab("Total Emissions [Tons]") +
    ggtitle("Emissions of PM2.5 in Baltimore City from Motor Vehicles")

png(filename = "plot5.png")
vehicle.plot
dev.off()

# Method 2 - Create a plot showing coal related emissions across the US from 1999-2008
#png(filename = "plot5a.png")
#with(tot.emissions.vehicle,
#     plot(year, tot.emissions, type = "o",
#          xlab = "Year",
#          ylab = "Total Emissions (tons)",
#          main = "Emissions of PM2.5 in Baltimore City from Motor Vehicles")
#)
#dev.off()

#Difference in emission from coal related consumption from 1999 to 2008
#tot.emissions.vehicle[tot.emissions.vehicle$year == 1999, 2] - tot.emissions.vehicle[tot.emissions.vehicle$year == 2008, 2]
