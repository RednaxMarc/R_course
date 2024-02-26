setwd("/home/guest/R_course")
# Simulate a dataset of 10000 random values having a right skewed distribution, 
# using rnbinom() with mean = 10 and size = .5
random <- rnbinom(10000, mu = 10, size = 0.5)

# Make a hist() and set the x-axis limits (xlim) to the min and max of the dataset
hist(random, 
     xlim = c(min(random), max(random)),
     breaks = 50)

#  Make another histogram using density on y-axis (prob = TRUE) instead of frequency
hist(random, 
     xlim = c(min(random), max(random)),
     breaks = 50,
     probability = TRUE)

# Compute the density estimates (default gaussian kernel), 
# and use this to plot the density using lines()
density <- density(random)
hist(random, 
     xlim = c(min(random), max(random)),
     breaks = 50,
     probability = TRUE)
lines(density, col = "blue")

# Determine the skewness and kurtosis
library(moments)
skewness(random)
kurtosis(random)
