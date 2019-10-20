# BIOS 611: Urban Ministries of Durham Project 2 - Shiny Dashboard

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

### Shiny Dashboard Project

* Data management

After importing the data, I renamed the variables and remove some rows with dates before 1983 or after 2019, given that the UMD was estabblished in 1983.

* Data visualization

In the presentation, the social workers said they are particularly interested in “which clients they can help make a permanent transition to self-sufficiency, and which clients continue to need help.” In this context, I suggest they perform analyses to find some hidden patterns and differences between different types of clients with fine-grained dataset.

Shiny is an R package that makes it easy to build interactive web apps straight from R. I will build my web app dashboard using Shiny and R, to visualize: 1) The Number of (New) Clients Served by UMD; 2) Duration of Assistance; and 3) Seasonality.