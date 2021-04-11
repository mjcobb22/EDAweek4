library(dplyr)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#filter for years. also update filter in yearly var calc
yearFilter<-c(1999,2002,2005,2008)


balt<-NEI %>%
        filter(fips == "24510") %>%
        group_by(type, year) %>% 
        summarize(Yearly.Total = sum(Emissions))

balt$type<-factor(balt$type, levels = c("ON-ROAD", "NON-ROAD", "POINT", "NONPOINT"))

png("plot3.png")

p<-ggplot(balt,
       aes(x = factor(year),
           y = Yearly.Total,
           fill = type)) +
        geom_bar(stat = "identity") +
        facet_wrap(~type) +
        labs(x = "year",
        y = "total pm2.5 in Baltimore by type")

#calling print since auto printing hates me
print(p)
dev.off()