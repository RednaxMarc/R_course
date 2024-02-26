setwd("/home/guest/R_course")
# Load the mice weight data from the previous lecture
mice_weights <- read.csv("./Rdatasets/mice_weights.csv")

# Look at the structure and five-number summary statistics (min, max, mean, Q1, Q3)
str(mice_weights)
summary(mice_weights)

# What is the standard deviation of the body weights
sd(mice_weights$Bodyweight)

# Make a barplot of the mice diet frequencies
barplot(table(mice_weights$Diet))

# Make a histogram of the body weight
hist(mice_weights$Bodyweight, 
     breaks = 10)

# Make a boxplot of the mice body weight by diet group
boxplot(mice_weights$Bodyweight ~ mice_weights$Diet)

# Make a Q-Q plot of the mice body weight “chow” vs “hf”
qqplot(mice_weights$Bodyweight[mice_weights$Diet == "chow"],
       mice_weights$Bodyweight[mice_weights$Diet == "hf"],
       xlab = "chow Diet",
       ylab = "hf Diet")
