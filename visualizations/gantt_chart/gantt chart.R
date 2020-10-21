require("tidyverse")
library(tidy)
setwd('C:/Users/bscheng/Box/PROJECT URO/2020/Drafts/Figs')

gantt <- read.csv("gantt chart data.csv", h=T)


acts<-c("Project planning", "Field work (collections, field data)", 
        "Spawning oyster drills","Thermal performance trials", 
        "Phenotypic data processing and workup", "RNA extraction and library preparation", 
        "Data archiving",
        "Sequencing","Bioinformatics",  
        "Population genetics", 
        "Mechanisms of CnGV","Sublethal and lethal integration", 
        "Swim instruction / ocean science boot camp")



els <- c("Coordination", "Field work", "Laboratory", "Analyses","Molecular work", "Publication preparation", "Broader impacts")
names(gantt)[1] <- "Item"

g.gantt <- gather(gantt, "start", "date", 4:5) %>% 
  mutate(date = as.Date(date, "%Y.%m.%d"), Activity=factor(Activity, acts[length(acts):1]), Project.element=factor(Project.element, els))

head(gantt)
str(gantt)


gantt.plot<-ggplot(g.gantt, aes(date, Activity, color = Project.element, group=Item)) +
geom_line(size = 10) +
labs(x="Project year", y=NULL, title="Project timeline")+theme_bw()+theme(
  axis.text=element_text(size=18),axis.title.x=element_text(size=22), 
  axis.title.y=element_text(size=22,vjust=1),panel.border = element_rect(size=.8, colour = "black"),
  legend.title=element_text(size=24), legend.text = element_text(size=22),
  plot.title = element_text(size=26))
ppi = 300
jpeg("gantt plot.jpg",quality = 100, width=18*ppi, height=8*ppi, res=ppi, units = "px") #define your png file
gantt.plot
dev.off()

