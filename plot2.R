library(dplyr)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#filter for years. also update filter in yearly var calc
yearFilter<-c(1999,2002,2005,2008)

balt<-NEI %>%
        filter(fips == "24510") %>%
        group_by(year) %>% 
        summarize(Yearly.Total = sum(Emissions))

png("plot2.png")
plot(balt$year, balt$Yearly.Total,
     type="l",
     lwd=2,
     axes = FALSE,
     xlab = "Year",
     ylab = "Total of PM25 in Baltimore");
baltdata<-round(balt$Yearly.Total)
axis(1, at = yearFilter)
axis(2, at = baltdata, labels = paste(baltdata))
dev.off()