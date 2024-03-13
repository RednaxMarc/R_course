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

# Making the colors and symbols
library(RColorBrewer)
col_tissue <- data_subset$Tissue.type
levels(col_tissue) <- list("#E41A1C"="Muscle",
                           "#377EB8"="Blood Vessel",
                           "#4DAF4A"="Heart")
col_tissue <- as.character(col_tissue)

subset.pch <- data_subset$Tissue.type
levels(subset.pch) <- list("0"="Muscle",
                           "1"="Blood Vessel",
                           "2"="Heart")
subset.pch <- as.numeric(as.character(subset.pch))

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
     col = col_tissue,
     pch = subset.pch, # type="n",
     cex = 0.7)

# MDS plot on all the data
d <- dist(data)
fit <- cmdscale(d, eig = TRUE, k=2)
x <- fit$points[,1]
y <- fit$points[,2]
plot(x, y, 
     xlab = "Coordinate 1", 
     ylab = "Coordinate 2",
     main = "MDS using Euclidean distance",
     cex = 0.7)
# Generating the tSNE plot
library(Rtsne)
set.seed(1)
tsne.out <- Rtsne(data_subset, 
                  #dims = 2, initial_dims = 50, 
                  perplexity = 10)
plot(tsne.out$Y,
     pch = subset.pch,
     col = col_tissue,
     main = "tSNE subset GTExdata (perplexity=10)",
     #xlim = c(-200,200), 
     #ylim = c(-100,100),
     cex = 0.6)

# To add a legend
legend("topleft", 
       title = "Tissue type",
       #title.col = "black",
       cex = 0.8,
       legend = c("Muscle","Blood Vessel","Heart"),
       #text.col = unique(subset.col),
       pch = unique(subset.pch),
       col = unique(col_tissue))



