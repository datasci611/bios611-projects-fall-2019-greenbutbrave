library(tidyverse)
library(dplyr)
library(tidyr)
library(caret)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(ggthemes)
library(VIM)
library(openxlsx)
library(devtools)
library(tidyverse)
library(ggplot2)
library(multigroup)
library(installr)
library(readr)
library(readxl)
library(haven)
library(GGally)
library(naniar)
library(VIM)
library(mice)
library(statVisual)
library(jtools)
library(interactions)
library(ggplot2)
library(sandwich)
library(rgl)
library(car)
library(scatterplot3d)
library(lattice)
library(ISLR)
library(glmnet)

# Import the Data
data <- read.csv("C:\Users\Wonkyung Jang\Documents\GitHub\bios611-projects-fall-2019-greenbutbrave\project_3\data\client_income.tsv", sep = "\t")

# Visualization

## Density Plot: Income Source & Receiving Income
a <- ggplot(data, aes(Income Source (Entry)))
a + geom_bar(aes(fill = Receiving Income (Entry)))+
  labs(title="Density Plot",
       subtitle="Income Source & Receiving Income",
       caption="UMD",
       x="Income Source",
       y="Density")

## Box Plot: Income Source, Receiving Income, & Monthly Amount
c <- ggplot(data, aes(Income Source (Entry), Receiving Income (Entry))) 
c + geom_boxplot(aes(colour = Monthly Amount (Entry)))

## Correlation GGPairs
vars = c("Income Source (Entry)", "Receiving Income (Entry)", "Monthly Amount (Entry)")
data2 <- data[,c(vars)]
drop_na(data2)
ggpairs(data2, progress = FALSE, 
        upper = list(continuous = "cor"),
        lower = list(continuous = "density"))

## Missing Pattern
gg_miss_var(data2)
res <- summary(aggr(data2, sortVar = TRUE))$combinations
marginmatrix(data2)
shadow <- as.data.frame(abs(is.na(data2)))
miss.shadow <- shadow[,which(unlist(lapply(shadow,sum))!=0)]
round(cor(miss.shadow),3)
scattmatrixMiss(data2)

## LASSO

### Splitting data into training and testing data
x = model.matrix(Monthly Amount (Entry)~.^2, Variables_)[,-1]
y = Variables_ %>% select(Monthly Amount (Entry)) %>% unlist() %>% as.numeric()
train = Variables_ %>% sample_frac(0.5)
test = Variables_ %>% setdiff(train)
x_train = model.matrix(Monthly Amount (Entry)~., train)[,-1]
x_test = model.matrix(Monthly Amount (Entry)~., test)[,-1]
y_train = train %>% select(Monthly Amount (Entry)) %>% unlist() %>% as.numeric()
y_test = test %>% select(Monthly Amount (Entry)) %>% unlist() %>% as.numeric()

### Fit LASSO model on training data and evaluate the model (lamda) on testing data
lasso_mod = glmnet(x_train, y_train, alpha = 1) # Fit lasso model on training data
plot(lasso_mod)    # Draw plot of coefficients
cv.out = cv.glmnet(x_train, y_train, alpha = 1) # Fit lasso model on training data
plot(cv.out) # Draw plot of training MSE as a function of lambda
bestlam = cv.out$lambda.min # Select lamda that minimizes training MSE
lasso_pred = predict(lasso_mod, s = bestlam, newx = x_test) # Use best lambda to predict test data
mean((lasso_pred - y_test)^2) # Calculate test MSE
out = glmnet(x, y, alpha = 1) # Fit lasso model on full dataset
lasso_coef = predict(out, type = "coefficients", s = bestlam)[1:40,] # Display coefficients using lambda chosen by CV
lasso_coef
lasso_coef[lasso_coef != 0] # Display only non-zero coefficients

