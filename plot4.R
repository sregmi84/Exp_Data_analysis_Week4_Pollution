###Assumption: File Downloaded and Data Unziped. See Plot1.R
setwd("~/Coursera/Exploratory Data Analysis/Week 4")

#Read in the data files
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

SCC.coal <- SCC[grep("[Cc]oal",SCC$Short.Name,ignore.case = T),]
NEI.coal <- subset(NEI,NEI$SCC %in% SCC.coal$SCC)

#Method 1 - Create Summary of Emissions by Year
tot.emissions.coal <- aggregate(NEI.coal$Emissions, 
                                 by=list(NEI.coal$year), FUN=sum)
colnames(tot.emissions.coal) <- c("year", "tot.emissions")

#Method 2 - Create Summary of Emissions by Year Using dplyr
#library(dplyr)
#tot.emissions.coal <- NEI.coal %>% 
#    group_by(year) %>%
#    summarize(tot.emissions = sum(Emissions, na.rm = TRUE))

# Method 1 - Create a plot showing coal related emissions across the US from 1999-2008
png(filename = "plot4.png")
with(tot.emissions.coal,
    plot(year, tot.emissions, type = "o",
         xlab = "Year",
         ylab = "Total Emissions (tons)",
         main = "Emissions of PM2.5 in US from Coal Related Combustion")
)
dev.off()

#Method 2 - Create Plot using ggplot2
#library(ggplot2)
#g <- ggplot(tot.emissions.coal, aes(year, tot.emissions))

#coal.plot <- g + 
#    geom_point(color = "blue", 
#               size = 4, 
#               alpha = 1/3) + 
#    xlab("Year") +
#    ylab("Total Emissions [Tons]") +
#    ggtitle("Emissions of PM2.5 in US from Coal Related Combustion")

#png(filename = "plot4.png")
#coal.plot
#dev.off()

#Difference in emission from coal related consumption from 1999 to 2008
#tot.emissions.coal[tot.emissions.coal$year == 1999, 2] - tot.emissions.coal[tot.emissions.coal$year == 2008, 2]
