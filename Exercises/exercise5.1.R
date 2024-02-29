# Loading in the data
data <- read.csv("./Rdatasets/Taskesen2016-GTExdata.csv", header = FALSE)
sample_lab <- read.csv("./Rdatasets/Taskesen2016-SampleLabels.csv", header = TRUE)
# Merging the data together
merged_data <- cbind(data, sample_lab)

# Filtering the data on muscle, blood vessel and heart
muscle <- subset(merged_data, merged_data$Tissue.type == "Muscle")
blood_vessel <- subset(merged_data, merged_data$Tissue.type == "Blood Vessel")
heart <- subset(merged_data, merged_data$Tissue.type == "Heart")
# merging the subsets and changing the tissue type to factor
data_subset <- rbind(muscle, blood_vessel, heart)
data_subset$Tissue.type <- as.factor(data_subset$Tissue.type)

# Making the colors
library(RColorBrewer)
levels(data_subset$Tissue.type) <- list("#66C2A5"="Muscle",
                                        "#FC8D62"="Blood Vessel",
                                        "#8DA0CB"="Heart")
colors <- as.character(data_subset$Tissue.type)

# Removing the last 3 columns with sample id, and tissue type
data_subset <- data_subset[, 1:(ncol(data_subset) - 3)]

# Generating the MDS plot 
d <- dist(data_subset)
fit <- cmdscale(d, eig = TRUE, k = 2)
fit
x <- fit$points[,1]
y <- fit$points[,2]
plot(x, y, 
     xlab = "Coordinate 1", 
     ylab = "Coordinate 2",
     main = "MDS using Euclidean distance",
     col = colors,
     pch = 1, # type="n",
     cex = 0.7)

# Generating the tSNE plot
library(Rtsne)



