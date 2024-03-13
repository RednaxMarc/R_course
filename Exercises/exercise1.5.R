setwd("~/R_course")
# Take a look at the help of the datasets package (default, installed), 
# to see which datasets you can always directly use in R to try things out
library("datasets")
# Load the ChickWeight
ChickWeight <- ChickWeight

# Check how many column and rows are in this dataset,
# and what the different variables are (also in the help)
dim(ChickWeight)

# Save the data frame in an xlsx file (ChickWeight.xlsx)
library("xlsx")
write.xlsx(x = ChickWeight, 
           file = "Exercises/ChickWeight.xlsx",
           sheetName = "ChickWeight",
           row.names = FALSE)

# Time is the number of days since birth. Make a new column Day
# and use the paste function to fill it with “day 0”, “day 2”, ...
ChickWeight$Day<- paste("day",ChickWeight$Time)

# Now replace the d by D in day in the Day column
ChickWeight$Day <- gsub("d", "D", ChickWeight$Day)

# Get a logical vector (TRUE/FALSE) using grepl which rows are Day 0
grepl("Day 0", ChickWeight$Day)

#  What is the class of ChickWeight$Day? Set is to factor.
class(ChickWeight$Day)
ChickWeight$Day <- as.factor(ChickWeight$Day)
class(ChickWeight$Day)

# ChickWeight$Chick is an ordered factor with 50 levels: 18 < 16 <  ... < 48
# The ordering of the levels groups chicks on the same diet together,
# and orders them according to their final weight (lightest to heaviest) within diet.
# Sort ChickWeight descending and look at the sorting order.
# What are the first two and last two (different) values?
sort(ChickWeight$Chick, decreasing = TRUE)
unique(sort(ChickWeight$Chick, decreasing = TRUE))
# Make a new numeric column ChickWeight$Chick2 from ChickWeight$Chick
# and sort them descreasing. What are now the first two and last two different values?
ChickWeight$Chick2 <- as.numeric(ChickWeight$Chick)
sort(ChickWeight$Chick2, decreasing = TRUE)
unique(sort(ChickWeight$Chick2, decreasing = TRUE))

# Have a look at the first row and last row. Are the Chick and Chick values 
# the same? Do you know why this is?
ChickWeight[c(1,nrow(ChickWeight)),]

# Make four subsets of the chicks based on the same diet. 
# Can you do this in a loop? Make a list of dataframes: listofdfs <- list()
# and save a dataframe in the loop using: listofdfs[[dataframe]] <- subset
listofdfs <- list()
for (i in unique(ChickWeight$Diet)){
  diet <- paste("diet", i, sep = "")
  listofdfs[[diet]] <- subset(ChickWeight, Diet == i, c("Chick", "Diet"))
}


# Make a dataframe FatChicks with the chicks having weight > 300 grams
# How many of the chicks are weighing over 300 grams?
fatChicks <- subset(ChickWeight, weight > 300)
nrow(fatChicks)
