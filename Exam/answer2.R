## 2A/ Give the type of variable(s) you can identify in this dataset. 
# One measurement variable: yield
# Two nominal variables: (yield_sidedressed_tomatoes and yield_nonsidedressed_tomatoes), and Variety

## 2B/ Using the given variable(s), give the name of the test to analyze this dataset. 
# Paired t-test

## 2C/ Prepare/load the data in the appropriate structure in R(Studio) and view before running the test. 
library(xlsx)
tomat <- read.xlsx("tomatoes.xlsx", sheetName = "Sheet1")
str(tomat)
tomat$Variety.ID <- as.factor(tomat$Variety.ID)
tomat$Differences <- NULL
str(tomat)
tomat

## 2D/ Perform the test and explain the outcome of the test (written as comments in the R script)
t.test(tomat$yield_sidedressed_tomatoes, tomat$yield_nonsidedressed_tomatoes,
       paired = TRUE)
# p-value  = 0.07936 -> We do not reject the null hypothesis, which means that there is not a 
# difference between side dressing and non-side dressing

## 2E/ Give the name of a typical visualization technique that can be used to accompany this data and test. 
# A Boxplot 
par(mfrow = c(1,1))
boxplot(tomat$yield_sidedressed_tomatoes, tomat$yield_nonsidedressed_tomatoes,
        names = c("side-dressed", "non-sidedressed"),
        ylab = "Yield")
