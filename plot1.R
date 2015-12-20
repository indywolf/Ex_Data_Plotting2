NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

#reduce df to 2 columns
reducedNEI <- NEI[,c(4,6)]
#sum up by year
#totalYear <- rowsum(totalPollution, totalPollution$year)
totalYear <- aggregate.data.frame(reducedNEI, by=list(reducedNEI$year), FUN="sum")
#divide by 1,000,000 in order to make data easier to read on plot
totalYear[,'Emissions'] <- totalYear[,'Emissions']/1000000
#plot it!
plot(totalYear[,1], totalYear$Emissions, type='l', main="Total PM2.5 Emissions Pollution", xlab="Year", ylab="Pollution (millions of tons)")
#save to png
dev.copy(png, file = "plot1.png") 
dev.off() 
                      