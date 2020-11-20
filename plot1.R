###Download and Unzip the Data Files
setwd("~/Coursera/Exploratory Data Analysis/Week 4")
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
destfile1 <- "exdata_data_NEI_data.zip"

if(!file.exists(destfile1)) {
    download.file(url1, 
                  destfile = destfile1, 
                  method = "curl")
    unzip(destfile1, exdir = "./Data")
}

#Read in the data files
NEI <- readRDS("Data/summarySCC_PM25.rds")
SCC <- readRDS("Data/Source_Classification_Code.rds")

#Method 1 - Create Total Emissions by year
tot.emissions.yr <- with(NEI,tapply(Emissions,year,sum,na.rm=TRUE))
tot.emissions.year <- data.frame(year=names(tot.emissions.yr),total.emissions=tot.emissions.yr,stringsAsFactors = F)
#tot.emissions.year$year <- as.character(tot.emissions.year$year)

#Method 2 - Create Total Emissions by year using dplyr package
#library(dplyr)
# Group by year and summarize total emissions
#tot.emissions.year <- NEI %>% group_by(year) %>%
#   summarize(Total.Emissions = sum(Emissions, na.rm = TRUE))

#Method 3 - Create Total Emissions using aggregate function
#tot.emissions.year <- aggregate(emissions_data$Emissions, by=list(year=emissions_data$year), FUN=sum)

#Plot
## create the plot
png(filename = "plot1.png")
with(tot.emissions.year,
     plot(year, total.emissions, pch=19, type= "b", col="blue",
     main = "Total Emissions of PM2.5 in US",
     ylab = "Total emissions of PM2.5 (tons)",
     xlab = "Year",
     ylim=range(total.emissions,na.rm=T))
    )
dev.off()

#Compute decrease in Total Emissions from 1999 to 2008
#tot.emissions.year[tot.emissions.year$year=="1999",2] - tot.emissions.year[tot.emissions.year$year=="2008",2]