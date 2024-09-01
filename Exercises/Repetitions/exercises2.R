# exercise 1.4
library(Hmisc)
urine_data <- read.csv(file="Rdatasets/urine.csv", header = TRUE)
describe(urine_data)
sink("Exercises/urine_descriptive.txt", append=FALSE, split=FALSE)
describe(urine_data)
sink()

# exercise 1.5
chickies <- ChickWeight
dim(chickies)
describe(chickies)
library("xlsx")
write.xlsx(x = chickies, 
           file = "Exercises/ChickWeight.xlsx",
           sheetName = "ChickWeight",
           row.names = FALSE)
chickies$Day <- paste("day", chickies$Time)
chickies$Day <- gsub("d", "D", chickies$Day)
grepl("Day 0", chickies$Day)
class(chickies$Day)
chickies$Day <- as.factor(chickies$Day)
sort(chickies$weight, decreasing = TRUE)
order(chickies$weight, decreasing = TRUE)
unique(sort(ChickWeight$Chick, decreasing = TRUE))
chickies$Chick2 <- chickies$Chick
chickies$Chick2 <- as.numeric(chickies$Chick2)
sort(chickies$Chick2, decreasing = TRUE)
unique(sort(chickies$Chick2, decreasing = TRUE))
listofchickies <- list()
for (diet in levels(chickies$Diet)){
  listofchickies[paste("diet",diet)] <- subset(chickies, Diet == diet)
}
FatChicks <- data.frame(subset(chickies, weight > 300))

# exersice 1.6
