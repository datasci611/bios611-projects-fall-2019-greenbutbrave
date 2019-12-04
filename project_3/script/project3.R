install.packages("tidyverse")
install.packages("dplyr")
install.packages("tidyr")
install.packages("caret")
install.packages("ggplot2")
install.packages("GGally")
install.packages("ISLR") 
install.packages("glmnet") 
install.packages("jtools") 
install.packages("interactions")
library(tidyverse)
library(dplyr)
library(tidyr)
library(caret)
library(ggplot2)
library(GGally)
library(ISLR) 
library(glmnet) 
library(jtools) 
library(interactions)

# Import the Data
data <- read.csv('final_data.csv')
data_demo <- read.csv('final_data_demo.csv')

# Visualization
## Bar Plot (Gender & Race)
a <- ggplot(data_demo, aes(Gender)) 
a + geom_bar(aes(fill = Race)) +
  labs(title="Bar Plot",
       subtitle="Gender and Race in UMD",
       caption="Source: Urban Ministries of Durham",
       x="Race",
       y="Frequency")

## Density Plot (Time in UMD & Gender)
b <- ggplot(data, aes(Time, fill = Gender, colour = Gender))
b + geom_density(alpha = 0.1) +
  labs(title="Density Plot",
       subtitle="Gender and Time in UMD",
       caption="Source: Urban Ministries of Durham",
       x="Time",
       y="Density")

## Box Plot (Time in UMD & (Race X Gender))
c <- ggplot(data, aes(Race, Time)) 
c + geom_boxplot(aes(colour = Gender)) +
  labs(title="Box Plot",
       subtitle="(Race X Gender) and Time in UMD",
       caption="Source: Urban Ministries of Durham",
       x="Race",
       y="Frequency")

## Box Plot (Monthly income & (Race X Gender))
d <- ggplot(data, aes(Race, Income_Monthly)) 
d + geom_boxplot(aes(colour = Gender)) +
  labs(title="Box Plot",
       subtitle="(Race X Gender) and Monthly Income",
       caption="Source: Urban Ministries of Durham",
       x="Race",
       y="Frequency")

## Scatter Plot and Density Plot (Time & Income & Age)
vars = c("Time", "Income_Monthly", "Age")
data2 <- data[,c(vars)]
drop_na(data2)
ggpairs(data2, progress = FALSE, 
        upper = list(continuous = "cor"),
        lower = list(continuous = "density"))

## Scatter Plot and Density Plot (Gender X (Time & Income & Age))
vars1 = c("Time", "Income_Monthly", "Age", "Gender")
data3 <- data[,c(vars1)]
drop_na(data3)
ggpairs(data3, columns=1:3, ggplot2::aes(colour=Gender),
        upper = list(continuous = "cor", combo = "box_no_facet"),
        lower = list(continuous = "density", combo = "dot_no_facet"),
        diag = list(continuous = "densityDiag"))

## Scatter Plot and Density Plot (Gender X (Time & Income & Age))
vars1 = c("Time", "Income_Monthly", "Age", "Gender")
data3 <- data[,c(vars1)]
drop_na(data3)
ggpairs(data3, ggplot2::aes(colour=Gender),
        upper = list(continuous = "density", combo = "dot_no_facet"),
        lower = list(continuous = "cor", combo = "box_no_facet"),
        diag = list(continuous = "densityDiag"))

## LASSO
Variables = c("Age","Gender","Race","Ethnicity","Veteran","Income_Monthly","Disability","HealthInsurance","DomesticViolence","Time")
Variables_ <- data[,c(Variables)]
### Splitting data into training and testing data
x = model.matrix(Time~.^2, Variables_)[,-1]
y = Variables_ %>% select(Time) %>% unlist() %>% as.numeric()
train = Variables_ %>% sample_frac(0.5)
test = Variables_ %>% setdiff(train)
x_train = model.matrix(Time~., train)[,-1]
x_test = model.matrix(Time~., test)[,-1]
y_train = train %>% select(Time) %>% unlist() %>% as.numeric()
y_test = test %>% select(Time) %>% unlist() %>% as.numeric()
### Fit LASSO model on training data and evaluate the model (lamda) on testing data
lasso_mod = glmnet(x_train, y_train, alpha = 1) # Fit lasso model on training data
plot(lasso_mod)    # Draw plot of coefficients
cv.out = cv.glmnet(x_train, y_train, alpha = 1) # Fit lasso model on training data
plot(cv.out) # Draw plot of training MSE as a function of lambda
bestlam = cv.out$lambda.min # Select lamda that minimizes training MSE
lasso_pred = predict(lasso_mod, s = bestlam, newx = x_test) # Use best lambda to predict test data
mean((lasso_pred - y_test)^2) # Calculate test MSE
### LASSO Outcomes
out = glmnet(x, y, alpha = 1) # Fit lasso model on full dataset
lasso_coef = predict(out, type = "coefficients", s = bestlam)[1:40,] # Display coefficients using lambda chosen by CV
lasso_coef
lasso_coef[lasso_coef != 0] # Display only non-zero coefficients

## Interaction Plot
interaction1 <- lm(Time ~ Age * Race , data = data)
interact_plot(interaction1, pred = Age, modx = Race)
interaction2 <- lm(Time ~ Age * HealthInsurance , data = data)
interact_plot(interaction2, pred = Age, modx = HealthInsurance)
interaction3 <- lm(Time ~ Age * Income_Monthly , data = data)
interact_plot(interaction3, pred = Age, modx = Income_Monthly)