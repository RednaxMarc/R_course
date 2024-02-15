setwd("~/R_course")
# Install/load the Hmisc library
install.packages("Hmisc")
library("Hmisc")

# Use the describe() function on the urine dataset
urine_data <- read.csv(file="Rdatasets/urine.csv", header = TRUE)
describe(urine_data)

# Save the output in a file urine_descriptive.txt
sink("Exercises/urine_descriptive.txt", append=FALSE, split=FALSE)
describe(urine_data)
sink()
