NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")
#select out Baltimore data only, flips = 24510
baltimoreNEI <- subset(NEI, fips == '24510')
#reduce df to 2 columns
reducedNEI <- baltimoreNEI[,c(4,6)]
#sum up by year
#totalYear <- rowsum(totalPollution, totalPollution$year)
totalYear <- aggregate.data.frame(reducedNEI, by=list(reducedNEI$year), FUN="sum")
#divide by 1,000,000 in order to make data easier to read on plot
totalYear[,'Emissions'] <- totalYear[,'Emissions']/1000
#plot it!
plot(totalYear[,1], totalYear$Emissions, type='l', main="Total PM2.5 Emissions Pollution", xlab="Year", ylab="Pollution (thousands of tons)")
#save to png
dev.copy(png, file = "plot2.png") 
dev.off() 
