library(dplyr)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#IE.Sector names
#unique(SCC[c("Short.Name")])

#filter for years. also update filter in yearly var calc
yearFilter<-c(1999,2002,2005,2008)

vehc.scc<-SCC[grep("Mobile.*Vehicles",SCC$EI.Sector),]
list.vehc.scc<-unique(vehc.scc$SCC)

vehc.nei<-NEI[NEI$SCC %in% list.vehc.scc,]
vehc.nei$year<-as.factor(vehc.nei$year)
total.vehc.nei<-vehc.nei %>%
        filter(fips == "24510"|fips == "06037") %>%
        group_by(fips, year) %>% 
        summarize(Yearly.Total = sum(Emissions))

total.vehc.nei$fips[total.vehc.nei$fips == "24510"]<-"baltimore"
total.vehc.nei$fips[total.vehc.nei$fips == "06037"]<-"los angeles"

png("plot6.png")


p<-ggplot(total.vehc.nei,
       aes(x = factor(year),
           y = Yearly.Total)) +
        geom_bar(stat = "identity") +
        facet_wrap(~fips) +
        labs(x = "year",
        y = "total emmisions from vehicles in baltimore vs los angeles")

#calling print since auto printing hates me
print(p)
dev.off()