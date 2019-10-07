# BIOS 611: Urban Ministries of Durham Project

## Background: What is "The Urban Ministries of Durham (UMD) Project"?
The Urban Ministries of Durham (UMD) Project aims for connecting with the community to diminish homelessness and fighting poverty through providing food, shelter and a future to neighbors with special needs (UMD, 2019). Through exploring some hidden patterns of the data using data science analytics, this paper will suggest what evidence social workers can glean from this data and help them better understand their clients and services.

## Data Cited
The dataset is offered by the Urban Ministries of Durham (UMD) Project Team (http://www.umdurham.org/), which includes the dataset with 79838 observations from 1990's to 2019. It has 9 variables like below: 

### Variables
* Client File Number (Identifier)
* Bus Tickets: Service discontinued
* Food: # of people in the family for which food was provided
* Food Pounds: # of pounds of food that each individual or family received when shopping the food pantry
* Clothing Items: # of clothing items that each individual or family received in the clothing closet
* Diapers: # of packs of diapers received (individuals/families are given 2 packs of diapers per child, and packs contain 22 diapers on average)
* School Kits
* Hygiene Kits: # of kits received per individual or family. Kits contain soap, shampoo, conditioner, lotion, deodorant, a toothbrush, toothpaste, a washcloth, a disposable razor, and a bottle of shaving cream.
* Financial Support: Service discontinued

### Statistical Analyses

* Data management

After importing the data, I renamed the variables and remove some rows with dates before 1983 or after 2019, given that the UMD was estabblished in 1983.

Before analyzing the data, I detected, visualized and tested for outliers. When I had a look at columns of the UMD dataset with boxplot, I got a number of outliers in each variable. Particularly, through the rosnertest, I could get rows in which the outliers are and the actual values of the outliers. Accordingly, the rows containing the outliers were removed and I could notice that those pesky outliers are gone.

* Data Analysis

Visualization: 1) The Number of (New) Clients Served by UMD; 2) Duration of Assistance; and 3) Seasonality
Correlation analysis

## Conclusion

1. To begin with, through the graphs of the number of (new) clients served by UMD between 1994 and 2019, I could demonstrate that the number of new clients served by UMD had been increasing until 2002 but has been decreasing up to now.
2. Second, the number of clients served by UMD each month do differ. Generally, March is the month when the UMD serves the least amount of clients, and July is the month when the UMD serves the most amount of clients between 1994 and 2019.
3. Third, the histogram of the duration of assistance was skewed righ with a tail going off to the right. The most amount of clients was served by the UMD for 0-500 days and there are people who have been served over 10-20 years. 
4. Fourth, between 2000 to 2010, sum of the amount of foods tended to peak for July and then decline after summer. So time series of the food amount typically showed increasing pattern from January through July and declining pattern from July to December.
5. On the other hand, between 2011 to 2019, Sum of the amount of foods tend to peak for May and June, then decline after summer and rise again during winter. So time series of the food amount typically show increasing pattern from February through May , declining pattern from July to september and increasing pattern again from September to January.
6) Lastly, there isstatistically significant relationship between 1) Clothing and Food, 2) Diapers and Food, 3) Hygiene.Kits and Bus, 4) Hygiene.Kits and Food, 5) Hygiene.Kits and Diapers, and 6) Clothing and Food.pounds. 

In the presentation, the social workers said they are particularly interested in “which clients they can help make a permanent transition to self-sufficiency, and which clients continue to need help.” In this context, I suggest they perform analyses to find some hidden patterns and differences between different types of clients with fine-grained dataset (e.g., after shrinking the size of the variables through PCA, we can perform a unsupervised cluster analysis to find various types of clients and compare them in terms of mean, variance, kurtosis, and skewness (e.g., parametric methods) and general shape of distribution (e.g., nonparametric methods), based off of the principle components).