###Assumption: File Downloaded and Data Unziped. See Plot1.R
setwd("~/Coursera/Exploratory Data Analysis/Week 4")

#Read in the data files
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

library(dplyr)
type.emissions.year <- NEI %>% subset(fips == "24510") %>% 
                       group_by(year,type) %>% 
                       summarize(total.emissions.type=sum(Emissions,na.rm=T))

library(ggplot2)

#Method 1 - Make plot - Using qplot() and colors for each type
png(filename = "plot3.png")
qplot(year, total.emissions.type, data = type.emissions.year, color = type, geom = "line") +
    ggtitle("Total Emissions of PM 2.5 in Baltimore City by Pollutant Type") + 
    ylab("Total Emissions (tons)") + 
    xlab("Year") +
    labs(col= "Pollutant Type")
dev.off()

#Method 2 - Make plot - Using ggplot() and facets for each type
#g <- ggplot(data = type.emissions.year, aes(year, total.emissions.type))
#plotType <- g + 
#    geom_point(color = "steel blue", 
#               size = 2, 
#               alpha = 2/3) + 
#    facet_grid(. ~ type) +
#    xlab("Year") +
#    ylab("Total Emissions [Tons]") +
#    ggtitle("Total Emissions of PM 2.5 in Baltimore City by Pollutant Type")

#png(filename = "plot3.png")
#plotType
#dev.off()
