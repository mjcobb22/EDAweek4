library(dplyr)
library(ggplot2)
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("./Source_Classification_Code.rds")

#IE.Sector names
#unique(SCC[c("Short.Name")])

#filter for years. also update filter in yearly var calc
yearFilter<-c(1999,2002,2005,2008)

coal.scc<-SCC[grep("Fuel Comb.*Coal",SCC$EI.Sector),]
list.coal.scc<-unique(coal.scc$SCC)

coal.nei<-NEI[NEI$SCC %in% list.coal.scc,]
coal.nei$year<-as.factor(coal.nei$year)
total.coal.nei<-coal.nei %>%
        group_by(year) %>% 
        summarize(Yearly.Total = sum(Emissions))

png("plot4.png")


p<-ggplot(total.coal.nei,
       aes(x = factor(year),
           y = Yearly.Total)) +
        geom_bar(stat = "identity") +
        labs(x = "year",
        y = "total emmisions from coal")

#calling print since auto printing hates me
print(p)
dev.off()