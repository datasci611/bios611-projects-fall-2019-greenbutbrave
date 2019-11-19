# BIOS 611: Urban Ministries of Durham Project

## Background: What is "The Urban Ministries of Durham (UMD) Project"?
The Urban Ministries of Durham (UMD) Project aims for connecting with the community to diminish homelessness and fighting poverty through providing food, shelter and a future to neighbors with special needs (UMD, 2019). Through exploring some hidden patterns of the data using data science analytics, this paper will suggest what evidence social workers can glean from this data and help them better understand their clients and services.

## Data Cited: The dataset is offered by the Urban Ministries of Durham (UMD) Project Team (http://www.umdurham.org/).

### Dataset
* CLIENT_191102.tsv: Client's Information (e.g., ID, Age at Entry, Age at Exit, Gender, Race, Ethnicity, Status)
* DISABILITY_ENTRY_191102.tsv: Client's Disability Information (e.g., ID, Disability Type, Start Date, End Date)
* HEALTH_INS_ENTRY_191102.tsv: Client's Health Insurance Information (e.g., ID, Start Date, End Date)   
* INCOME_ENTRY_191102.tsv: Client's Income Information (e.g., ID, Receiving Income, Income Source, Monthly Amount, Start Date, End Date) 
* NONCASH_ENTRY_191102.tsv: Client's Noncash Benefit (e.g., Receiving Benefit, Non-Cash Source, Start Date, End Date)

## Statistical Analyses

* Data management

Before analyzing the data, I detected, visualized and tested for outliers. When I had a look at columns of the UMD dataset with boxplot, I got a number of outliers in each variable. Particularly, through the rosnertest, I could get rows in which the outliers are and the actual values of the outliers. Accordingly, the rows containing the outliers were removed and I could notice that those pesky outliers are gone.

* Data Analysis

In the presentation, the social workers said they are particularly interested in “which clients they can help make a permanent transition to self-sufficiency, and which clients continue to need help.” In this context, I performed analyses to find some hidden trends and patterns and differences between different types of clients with fine-grained dataset.

1. Visualization: “One look is worth a thousand words”: Visualization offers a front line of attack, revealing intricate structure in data that cannot be absorbed in any other way.   We discover unimagined effects and we challenge imagined ones (Cleveland, 1993).
1) Missing Pattern
2) Two-way Interaction and Quadratic Terms

2. Using LASSO (i.e., least absolute shrinkage and selection operator) variable selection (Tibshirani, 1996), I explored all possible higher-order terms (e.g., quadratic and two-way interaction terms).  

3. After shrinking the size of the variables using PCA, I performed an unsupervised cluster analysis to find various types of clients and compare them in terms of mean, variance, kurtosis, and skewness (e.g., parametric methods) and general shape of distribution (e.g., nonparametric methods), based off of the principle components.