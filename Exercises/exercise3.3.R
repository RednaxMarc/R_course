setwd("/home/guest/R_course")
# Load the hospital patients dataset from the previous Exercises 2.
patients <- read.csv("./Rdatasets/hospitalpatients.csv")

# Look at the structure. What are the variable types?
str(patients)
dim(patients)
colnames(patients)

# Are the classes of the variables matching the types? If not change (as.nnn).
patients$Gender <- as.factor(patients$Gender)
patients$HospitalSurvival <- as.factor(patients$HospitalSurvival)
summary(patients)
str(patients)

# Make a barplot of gender and a barplot of hospital survival (frequencies)
barplot(table(patients$Gender))
barplot(table(patients$HospitalSurvival))

# What are the quartiles (4-quantiles) of the ages?
# Can you also get the 20%, 40%, 60% and 80% quantiles? Use the help: “probs =“
quantile(patients$Age)
quantile(patients$Age, probs = seq(0,1,0.2))

# Plot a histogram of the patients ages. Next make a density plot of the ages.
hist(patients$Age)
plot(density(patients$Age))

# Now plot the histogram again with a gray density line. What is the distribution mode?  
# Does this change if you increase the bins (e.g. breaks=10)
hist(patients$Age, probability = TRUE, breaks = 10)
lines(density(patients$Age), col="blue")

# Make a boxplot of the patients weights. Any outliers?
# How could you know of which patient the weight is an outlier?
boxplot(patients$Weight)

# Now program a loop by going over the features Length, Weight and HospitalDays 
# and for each of these features make a histogram and boxplot

         