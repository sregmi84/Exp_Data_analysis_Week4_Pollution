###Assumption: File Downloaded and Data Unziped. See Plot1.R
setwd("~/Coursera/Exploratory Data Analysis/Week 4")

#Read in the data files
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

#Subset Baltimore data
baltimoreData <- subset(NEI, NEI$fips=="24510")

#Method 1 - Create Total Emissions by year for Baltimore
baltimore.emissions.yr <- with(baltimoreData,tapply(Emissions,year,sum,na.rm=TRUE))
baltimore.emissions.year <- data.frame(year=names(baltimore.emissions.yr),total.emissions=baltimore.emissions.yr,stringsAsFactors = F)

#Method 2 - Create Total Emissions by year using dplyr package
#library(dplyr)
# Group by year and summarize total emissions
#tot.emissions.year <- NEI %>% subset(fips == "24510") %>% 
#   group_by(year) %>%
#   summarize(Total.Emissions = sum(Emissions, na.rm = TRUE))

#Plot
## create the plot
png(filename = "plot2.png")
with(baltimore.emissions.year,
     plot(year, total.emissions, pch=19, type= "b", col="blue",
          main = "Total Emissions of PM2.5 in Baltimore City",
          ylab = "Total emissions of PM2.5 (tons)",
          xlab = "Year",
          ylim=range(total.emissions,na.rm=T))
)
dev.off()

#Compute decrease in Total Emissions from 1999 to 2008
#baltimore.emissions.year[baltimore.emissions.year$year=="1999",2] - baltimore.emissions.year[baltimore.emissions.year$year=="2008",2]