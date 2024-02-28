setwd("/home/guest/R_course")
# Load the urine data from a previous lecture.
urine_data <- read.csv("./Rdatasets/urine.csv")
# Make two boxplots next to each other
# The first boxplot shows r (presence of calcium oxalate crystals)
# on x-axis as group (0 or 1) vs calc (calcium concentration)
# on y-axis without any other parameters set.
par(mfrow=c(1,2))
boxplot(urine_data$calc ~ urine_data$r,
        xlab = "r",
        ylab = "calc")

# Now make a second similar boxplot but now specifiying title, outlier symbol x,
# titles for x- and y-axis and set the limit of the y-axis from 0 to 15.
# Change the 0/1 group names on the x-axis to no/yes
urine_data$r <- as.factor(urine_data$r)
levels(urine_data$r) <- c("No", "Yes")
boxplot(urine_data$calc ~ urine_data$r,
        xlab = "Precence of calcium oxidate crystals",
        ylab = "Calcium concentration mM/L",
        ylim = c(0,15),
        main = "Boxplot calcium concentration urine datset", 
        pch = "x")

# Is there a difference in calcium concentration when crystals are present?
# Yes, when there are crystals present, the calcium concentration is higher. 