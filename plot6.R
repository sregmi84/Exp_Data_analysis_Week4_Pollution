###Assumption: File Downloaded and Data Unziped. See Plot1.R
setwd("~/Coursera/Exploratory Data Analysis/Week 4")

#Read in the data files
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

SCC.vehicle <-SCC[grep("veh",SCC$Short.Name,ignore.case = T),]
NEI.vehicle <- subset(NEI,  NEI$SCC %in% SCC.vehicle$SCC)

#Create Summary of Emissions by Year Using dplyr
library(dplyr)
Bal.vehicle.emission <- NEI.vehicle %>% subset(fips == "24510") %>%
    group_by(year) %>%
    summarize(tot.emissions = sum(Emissions, na.rm = TRUE))

LA.vehicle.emission <- NEI.vehicle %>% subset(fips == "06037") %>%
    group_by(year) %>%
    summarize(tot.emissions = sum(Emissions, na.rm = TRUE))

#names(vehicle.emission.compare)[2] <- "tot.emissions.Bal"
#names(vehicle.emission.compare)[3] <- "tot.emissions.LA"

Bal.vehicle.emission$City <- "Baltimore"
LA.vehicle.emission$City <- "Los Angeles"

vehicle.emission.compare <- rbind(Bal.vehicle.emission,LA.vehicle.emission)

## Method 1 - Create Comparision plot using qplot()
library(ggplot2)

g <- ggplot(vehicle.emission.compare, aes(year,tot.emissions, col=City))
vehicle.compare.plot <- g +
    geom_line( size = 1, 
               alpha = 2/3) +
    geom_line( size = 1, 
               alpha = 2/3) +
    labs(color = "City") +
    xlab("Year") +
    ylab("Total Emissions [Tons]") +
    ggtitle("Emissions of PM2.5 in Baltimore City (24510) and LA (06037)") +
    theme(plot.title = element_text(hjust = 0.5))

png(filename = "plot6.png")
vehicle.compare.plot
dev.off()
