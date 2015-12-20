library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#get baltimore only
baltimoreNEI <- subset(NEI, fips == '24510')

#come together!
merged <- merge(baltimoreNEI, SCC, by.x='SCC', by.y='SCC')

#get motor vehicle data -> using anything that starts with 'mobile' in the EI.Sector column
motor <- subset(merged, grepl("^Mobile", EI.Sector))

motorSums <- motor %>% group_by(year) %>% summarise(emissionSum=sum(Emissions))

plot(motorSums$year, motorSums$emissionSum, type='l', main="Total PM2.5 Emissions Pollution by Motor Vehicles", xlab="Year", ylab="Pollution (in tons)")

#save to png
dev.copy(png, file = "plot5.png") 
dev.off() 