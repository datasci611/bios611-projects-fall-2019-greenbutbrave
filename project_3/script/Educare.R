library(tidyverse)
library(dplyr)
library(tidyr)
library(caret)
install.packages("caret")
install.packages("tidyverse")
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggthemes)
library(VIM)
library(openxlsx)
library(readx1)
library(devtools)
install.packages("devtools")
install.packages("openxlsx")
install.packages("readx1")
install.packages("VIM")
install.packages("installr")

rm(list=ls()) 

library(installr)

updateR()

install.packages("hrbrthemes")
install.packages("viridis")
install.packages("ggthemes")
install.packages(c("readr", "readxl", "haven"))
install.packages("VIM")
library(readr)
library(readxl)
library(haven)

data <- read.csv('Analysis.csv')
data_d <- read.csv('Descriptive.csv')
data_d2 <- read.csv('Descriptive2.csv')
drop_na(data_d2)
### 1-1: Age of Entry & Time in Educare

  g <- ggplot(as.data.frame(data_d2)) +
    aes(x = Entrygrp, fill = timegrp, weight = Freq)+
    geom_bar(position = "fill") + stat_fill_labels()
  install.packages("ggplot2") library(ggplot2)
  
educare <- read_csv("C:/educare.csv")
  a <- ggplot(educare, aes(Entrygrp))
  a + geom_bar(aes(fill = timegrp))

aes(x = Entrygrp, y = Frequency, fill = timegrp, label = Frequency)) + 
  # Bar charts are automatically stacked when multiple bars are placed # at the same location. The order of the fill is designed to match 
  # the legend 
  geom_bar(stat = "identity") +
  geom_text(size = 3, position = position_stack(vjust = 0.5))+
  labs(title="Density Plot",
       subtitle="Age of Entry and Time in Educare",
       caption="Source: Educare Learning Network",
       x="Age of Entry",
       y="Time in Educare")


# geom_bar is designed to make it easy to create bar charts that show 
# counts (or sums of weights) 
g <- ggplot(data_d2, aes(x = Entrygrp, y = Frequency, fill = timegrp, label = Frequency)) + 
# Bar charts are automatically stacked when multiple bars are placed # at the same location. The order of the fill is designed to match 
# the legend 
  geom_bar(stat = "identity") +
  geom_text(size = 3, position = position_stack(vjust = 0.5))+
  labs(title="Density Plot",
     subtitle="Age of Entry and Time in Educare",
     caption="Source: Educare Learning Network",
     x="Age of Entry",
     y="Time in Educare")
      
### 1-2: Race4 & Primary Language

# geom_bar is designed to make it easy to create bar charts that show 
# counts (or sums of weights) 
g <- ggplot(data_d, aes(Race4)) 
# Number of cars in each class: 
# Bar charts are automatically stacked when multiple bars are placed # at the same location. The order of the fill is designed to match 
# the legend 
g + geom_bar(aes(fill = PrimLang))

### 2: (Race4 X Primary Language) & Time in Educare

p <- ggplot(data_d2, aes(Race4, EducaretimeYr)) 
p + geom_boxplot()
# Boxplots are automatically dodged when any aesthetic is a factor 
p + geom_boxplot(aes(colour = PrimLang))

### 3: Primary Language & Time in Educare

r <- ggplot(data_d2, aes(EducaretimeYr, fill = PrimLang, colour = PrimLang)) 
r + geom_density(alpha = 0.1) +
  labs(title = "Density Plot", subtitle = "Primary Language & Time in Educare", 


# Stacked density plots: if you want to create a stacked density plot, you 
# probably want to 'count' (density * n) variable instead of the default 
# density 
# Loses marginal densities 
r <- ggplot(data_d2, aes(EducaretimeYr, group = PrimLang, fill = PrimLang)) 
r + geom_density(alpha = 0.2) + 
theme_ipsum()

r <- ggplot(data_d2, aes(EducaretimeYr, group = PrimLang, fill = PrimLang)) 
r + geom_density(position = "stack")

r <- ggplot(data_d2, aes(PrimLang, EducaretimeYr)) 
r + geom_boxplot()

d <- ggplot(data_d2, aes(EducaretimeYr, fill = Race4, colour = Race4))
d + geom_density(alpha = 0.2) 

### 4:

m <- ggplot(data, aes(plsEng_TenureYr, 1 / pls4_span)) + geom_point()
m + geom_quantile(colour = "red", size = 2, alpha = 0.5)

# You can create interesting shapes by layering multiple points of 
# different sizes 
s <- ggplot(data, aes(ppvt_standard, pls4_span, shape = factor(PrimLang))) 
s + geom_point(aes(colour = factor(PrimLang)), size = 1) 

ggplot(data, aes(x=ppvt_standard, y=pls4_span, 
                      color=PrimLang, size=TeenMom)) + 
geom_point(size = 1) +
geom_smooth(mapping = aes(x = ppvt_standard, y = pls4_span, color = PrimLang), show.legend = FALSE ) 

ggplot(data, aes(x=ppvt_standard, y=deca_behaTscore, color=Race4)) +
  geom_point(size=1) + 
  geom_smooth(mapping = aes(x = ppvt_standard, y = deca_behaTscore, color = Race4), show.legend = FALSE ) 

ggplot(data, aes(x=ppvt_standard, y=pls4_span, 
                      color=entryage)) + 
geom_point() 

### 5:
install.packages("GGally")
library(GGally)
vars = c("deca_initTscore", "deca_behaTscore", "deca_selfTscore", "ppvt_standard", "pls4_span", 
         "entryage", "ppvt_TenureYr", "deca_TenureYr", "plsEng_TenureYr", "Male", 
         "TeenMom", "parentednumcM", "singleparent1", "IEP", "chealth1", "FoodIns", "pDepressM", "qual_totalc")
vars1 = c("deca_initTscore", "deca_behaTscore", "deca_selfTscore", "ppvt_standard", "pls4_span", "PrimLang")

vars2 = c("deca_initTscore", "deca_behaTscore", "deca_selfTscore", "ppvt_standard", "pls4_span", 
         "entryage", "ppvt_TenureYr", "qual_totalc")

data2 <- data[,c(vars2)]
data2_ <- data2 %>%
  rename(deca_ini = deca_initTscore, deca_beh = deca_behaTscore, deca_sel = deca_selfTscore, 
         ppvt = ppvt_standard, pls = pls4_span, entryage = entryage, time_edu = ppvt_TenureYr,
         qual = qual_totalc)


vars3 = c("deca_initTscore", "deca_behaTscore", "deca_selfTscore", "ppvt_standard", "pls4_span")
data3_ <- data[,c(vars3)] %>%
  rename(deca_ini = deca_initTscore, deca_beh = deca_behaTscore, deca_sel = deca_selfTscore, 
         ppvt = ppvt_standard, pls = pls4_span)
marginmatrix(data3_)

shadow<- as.data.frame(abs(is.na(data3_)))
miss.shadow<-shadow[,which(unlist(lapply(shadow,sum))!=0)]
round(cor(miss.shadow),3)
spineMiss(data3_)
scattmatrixMiss(data3_)

data2 <- data[,c(vars2)]
data2_ <- data2 %>%
  rename(deca_ini = deca_initTscore, deca_beh = deca_behaTscore, deca_sel = deca_selfTscore, 
         ppvt = ppvt_standard, pls = pls4_span, entryage = entryage, time_edu = ppvt_TenureYr,
         qual = qual_totalc)
res<-summary(aggr(data2_, sortVar=TRUE))$combinations
matrixplot(data2_, sortby = 2)
marginplot(data2_[,c("deca_ini","deca_beh")])
marginmatrix(data2_)

drop_na(data2)
ggpairs(data2, progress = FALSE)
snsplot = sns.pairplot(data2, kind="scatter", hue="PrimLang", palette = "Set2")


### 6:
ggpairs(data2, columns=1:5, ggplot2::aes(colour=PrimLang),
        upper = list(continuous = "cor", combo = "box_no_facet"),
        lower = list(continuous = "density", combo = "dot_no_facet"),
        diag = list(continuous = "densityDiag"))

ggpairs(data2, ggplot2::aes(colour=PrimLang),
        upper = list(continuous = "cor", combo = "facetdensity"),
        lower = list(continuous = "density", combo = "box_no_facet"),
        diag = list(continuous = "densityDiag"))
### 7:

ggpairs(data2, columns=1:5, progress = FALSE, 
        upper = list(continuous = "cor"),
        lower = list(continuous = "density"))

vars2 = c("pi_c_story1", "pi_c_music1", "pi_c_sport1", "pi_c_crafts1") 
data2 <- data[,c(vars2)]

vars3 = c("pi_nEvents", "pi_school", "pi_feelDepC", "pi_relation1", "pi_c_encour1r")
data3 <- data[,c(vars3)]

vars3 = c("pi_c_letters1r", "pi_c_story1", "pi_c_wordnum1", "pi_c_music1", "pi_c_sport1", "pi_c_crafts1", "pi_nEvents", "pi_school", "pi_feelDepC", "pi_relation1", "pi_c_encour1r")
data3 <- data[,c(vars3)]
data3_ <- data3 %>%
  rename(story = pi_c_story1, music = pi_c_music1, sport = pi_c_sport1, 
         crafts = pi_c_crafts1, events = pi_nEvents, school = pi_school, depression = pi_feelDepC,
         relation = pi_relation1, encourage = pi_c_encour1r, word = pi_c_wordnum1, letter = pi_c_letters1r)
library(naniar)
gg_miss_var(data2_)
barMiss(data2_)
res<-summary(aggr(data2_, sortVar=TRUE))$combinations
marginplot(data3_[,c("crafts","sport")])
  
library(VIM)

install.packages("mice")
library(mice)

data(data, package = "VIM")
md.pattern(data2)
md.pattern(data3)
install.packages("naniar")

matrixplot(data2)
matrixplot(data3)
barMiss(data2)
barMiss(data3)

res<-summary(aggr(data2, sortVar=TRUE))$combinations


