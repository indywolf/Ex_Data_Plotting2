library(dplyr)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#come together!
merged <- merge(NEI, SCC, by.x='SCC', by.y='SCC')

#get coal data browsing some of the data appears to be search in short.name should work
coal <- subset(merged, grepl("Coal", Short.Name))
               
coalSums <- coal %>% group_by(year) %>% summarise(emissionSum=sum(Emissions))

plot(coalSums$year, coalSums$emissionSum, type='l', main="Total PM2.5 Emissions Pollution by Coal", xlab="Year", ylab="Pollution (in tons)")

#save to png
dev.copy(png, file = "plot4.png") 
dev.off() 
