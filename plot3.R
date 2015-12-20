library(dplyr)
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
#select out Baltimore data only, flips = 24510
baltimoreNEI <- subset(NEI, fips == '24510')

#create the summary data set
typeSums <- baltimoreNEI %>% group_by(year, type) %>% summarise(typeSum=sum(Emissions))

#qplot it up!
qplot(year, typeSum, data = typeSums, facets = .~type, geom="line", ylab="Emissions (in Tons)")

#save to png
dev.copy(png, file = "plot3.png") 
dev.off() 