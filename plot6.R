library(dplyr)
#NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#get baltimore only
baltimoreNEI <- subset(NEI, fips == '24510')

#get 
laNEI <- subset(NEI, fips == '06037')

#come together!
mergedBaltimore <- merge(baltimoreNEI, SCC, by.x='SCC', by.y='SCC')
mergedLA <- merge(laNEI, SCC, by.x='SCC', by.y='SCC')

#get motor vehicle data -> using anything that starts with 'mobile' in the EI.Sector column
motorBaltimore <- subset(mergedBaltimore, grepl("^Mobile", EI.Sector))
motorLA <- subset(mergedLA, grepl("^Mobile", EI.Sector))

# sum up by year
motorBaltimoreSums <- motorBaltimore %>% group_by(year) %>% summarise(emissionBaltimore=sum(Emissions))
motorLASums <- motorLA %>% group_by(year) %>% summarise(emissionLA=sum(Emissions))

#merge the 2 sets
motorSums <- merge(motorBaltimoreSums, motorLASums, by.x='year', by.y='year')

#plot 2 lines, needed to use ylim to show both ont he screen
plot(motorSums$year, motorSums$emissionBaltimore, type='l', main="Total PM2.5 Emissions Pollution by Motor Vehicles", xlab="Year", ylab="Pollution (in tons)", ylim=c(0,12000))
lines(motorSums$year, motorSums$emissionLA, type="l", col="red")
legend("topright", col=c("black", "red"), lty=1, lwd=2, legend=c("Baltimore", "LA"))

#save to png
dev.copy(png, file = "plot6.png") 
dev.off() 