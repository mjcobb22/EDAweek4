library(dplyr)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#filter for years. also update filter in yearly var calc
yearFilter<-c(1999,2002,2005,2008)

yearly<-NEI %>%
        group_by(year) %>% 
        filter(year == 1999|2002|2005|2008) %>%
        summarize(Yearly.Total = sum(Emissions))

png("plot1.png")
plot(yearly$year, yearly$Yearly.Total,
     type="l",
     lwd=2,
     axes = FALSE,
     xlab = "Year",
     ylab = "Total of PM25");
yearlydata<-yearly$Yearly.Total
axis(1, at = yearFilter, labels = paste(yearFilter))
axis(2, at = yearlydata, labels = paste(yearlydata))
dev.off()