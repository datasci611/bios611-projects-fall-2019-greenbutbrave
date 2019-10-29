library(shinydashboard)
library(shiny)
library(rsconnect)
library(tidyverse)
library(dplyr)
library(caret)
library(ggplot2)
library(grDevices)
library(EnvStats)
library(forecast)
library(timetk)
library(sweep)
library(GGally)
library(tidyquant)

Int1 = c("The Urban Ministries of Durham (UMD) Project aims for connecting with the community to diminish homelessness and fighting poverty through providing food, shelter and a future to neighbors with special needs (UMD, 2019). Through exploring some hidden patterns of the data using data science analytics, this paper will suggest what evidence social workers can glean from this data and help them better understand their clients and services.") 

# Data Cleaning

## Import the data 
rawdata <- read.table(file = './data/UMD_Services_Provided_20190719.txt', sep = '\t', fill = TRUE, header = TRUE)
## Rename the variables
data <- rawdata %>%
  rename(ClientID = Client.File.Number, Bus = Bus.Tickets..Number.of., Note = Notes.of.Service, 
         Food = Food.Provided.for, Clothing = Clothing.Items) %>%
  select(Date, ClientID, Bus, Food, Food.Pounds, Clothing, Diapers, School.Kits, Hygiene.Kits, 
         Referrals, Note, Financial.Support)

## Filtering
data$Date <- as.Date(data$Date, format = "%m/%d/%Y")
data = data %>%
  filter(Date >= "1983-01-01" & Date <= "2019-10-01")

# Roster tests and removing outliers

## rosnerTest(data$Bus, k = 10, warn = F)
data1 <- data[-which(data$Bus >= 7),]
## rosnerTest(data$Food, k = 10, warn = F)
data2 <- data1[-which(data1$Food >= 11),]
## rosnerTest(data$Food.Pounds, k = 5, warn = F)
data3 <- data2[-which(data2$Food.Pounds >= 200),]
## rosnerTest(data$Clothing, k = 100, warn = F)
data4 <- data3[-which(data3$Clothing >= 36),]
# rosnerTest(data$Diapers, k = 5, warn = F)
data5 <- data4[-which(data4$Diapers >= 36),]
# rosnerTest(data$Hygiene.Kits, k = 10, warn = F)
data6 <- data5[-which(data5$Hygiene.Kits >= 3),]

# RQ1: Boxplot function

boxplot1 = function(outlier) {
  if (outlier == 0) {
    boxplot(data$Bus, data$Food, data$Food.Pounds, data$Cloth, data$Diapers, data$School.Kits, 
            data$Hygiene.Kits, 
            main = "Multiple boxplots of the UMD Raw Data", 
            xlab = "Service Provided", ylab = "Value", 
            names = c("Bus", "Food", "Food.lb", "Cloth", "Diapers", "Sch.Kits", "Hyg.Kits"), 
            col = "cyan", border = "Blue", outcol = "red", outcex = 1.5)
  }
  else if (outlier == 1) {
    boxplot(data6$Bus, data6$Food, data6$Food.Pounds, data6$Cloth, data6$Diapers, data6$School.Kits, 
            data6$Hygiene.Kits, main = "Multiple boxplots: After removing the 
            outliers", xlab = "Service Provided", ylab = "Value", 
            names = c("Bus", "Food", "Food.lb", "Cloth", "Diapers", "Sch.Kits", "Hyg.Kits"), 
            col = "cyan", border = "Blue")
  }
}

# RQ2-3: Seasonality function

season2 = function(variable) {
  if (variable == 1) {
    RQ2_data = data6 %>%
      select(Date, Food) %>%
      filter(Date >= "2011-01-01" & Date <= "2019-10-01") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Food)) 
    ggplot(RQ2_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
  else if (variable == 2) {
    RQ2_data = data6 %>%
      select(Date, Food.Pounds) %>%
      filter(Date >= "2011-01-01" & Date <= "2019-10-01") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Food.Pounds)) 
    ggplot(RQ2_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
  else if (variable == 3) {
    RQ2_data = data6 %>%
      select(Date, Clothing) %>%
      filter(Date >= "2011-01-01" & Date <= "2019-10-01") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Clothing)) 
    ggplot(RQ2_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
  else if (variable == 4) {
    RQ2_data = data6 %>%
      select(Date, Diapers) %>%
      filter(Date >= "2011-01-01" & Date <= "2019-10-01") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Diapers)) 
    ggplot(RQ2_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
  else if (variable == 5) {
    RQ2_data = data6 %>%
      select(Date, Hygiene.Kits) %>%
      filter(Date >= "2011-01-01" & Date <= "2019-10-01") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Hygiene.Kits)) 
    ggplot(RQ2_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
}

season1 = function(variable) {
  if (variable == 1) {
    RQ3_data = data6 %>%
      select(Date, Food) %>%
      filter(Date >= "2000-01-01" & Date <= "2010-12-31") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Food)) 
    ggplot(RQ3_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
  else if (variable == 2) {
    RQ3_data = data6 %>%
      select(Date, Food.Pounds) %>%
      filter(Date >= "2000-01-01" & Date <= "2010-12-31") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Food.Pounds)) 
    ggplot(RQ3_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
  else if (variable == 3) {
    RQ3_data = data6 %>%
      select(Date, Clothing) %>%
      filter(Date >= "2000-01-01" & Date <= "2010-12-31") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Clothing)) 
    ggplot(RQ3_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
  else if (variable == 4) {
    RQ3_data = data6 %>%
      select(Date, Diapers) %>%
      filter(Date >= "2000-01-01" & Date <= "2010-12-31") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Diapers)) 
    ggplot(RQ3_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
  else if (variable == 5) {
    RQ3_data = data6 %>%
      select(Date, Hygiene.Kits) %>%
      filter(Date >= "2000-01-01" & Date <= "2010-12-31") %>%
      drop_na() %>%
      separate(Date, sep = "-", into = c("Year", "Month", "Day"))%>%
      group_by(Year, Month) %>%
      summarise(sum = sum(Hygiene.Kits)) 
    ggplot(RQ3_data, aes(x = Month, y = sum, group = Year)) +
      geom_area(aes(fill = Year), position = "stack") 
  }
}

# RQ4: GGally data transformation and function

vars = c("Bus", "Food", "Food.Pounds", "Clothing", "Diapers", "School.Kits", "Hygiene.Kits")
data_ <- data[,c(vars)]
data6_ <- data6[,c(vars)]

corr1 = function(outlier) {
  if (outlier == 0) {
    ggpairs(data_, progress = FALSE)
  }
  else if (outlier == 1) {
    ggpairs(data6_, progress = FALSE)
  }
}
