library("ggplot2")
library("gridExtra")

## Making the plots
data <- read.csv("Homo_sapiens_CDS-GC-GC3.csv", header = FALSE)
str(data)
head(data, n = 5)
data$V1 <- as.factor(data$V1)

p1 <- ggplot(data = data, aes(x = V3, fill = as.factor(V1), color = as.factor(V1))) + 
  geom_density(alpha = 0) +
  labs(title = "A. Density plot", x = "GC3%") +
  ylim(c(0,0.05)) + 
  scale_color_brewer(palette = "Paired") +
  geom_vline(xintercept = c(25, 75), linetype = "dashed", color = "grey") +
  geom_vline(xintercept = 50, linetype = "dashed") +
  geom_hline(yintercept = 0, color = "#1F78B4") +
  theme(legend.position="none")

p2 <- ggplot(data = data, aes(x = as.factor(V1), y = V3, fill = as.factor(V1))) +
  geom_violin() +
  labs(title = "B. Violin Plot",fill = "Codon content", x = NULL, y = "%")

combined_plots <- grid.arrange(p1, p2, ncol = 2)

## Precede your code with the question in comment.
# How many transcripts (rows) have a GC3 percentage = 100.
nrow(subset(data, V3 == 100 & V1 == "Human  GC3"))
# How many transcripts (rows) have a GC3 percentage = 0.
nrow(subset(data, V3 == 0 & V1 == "Human  GC3"))
# Filter data excluding GC3 percentages equal to 100 and to 0, keeping only "Human  GC3" rows and save in a new dataframe 
data_filt <- subset(data, V3 != 0 & V3 != 100 & V1 == "Human  GC3")
# Filter 5 transcripts with lowest GC3 (0% and 100% not included). Filter 5 transcripts with highest GC3 (0% and 100% not included).
# Merge rows together in new dataframe (exemplified in the view below).
data_filt <- data_filt[order(data_filt$V3, decreasing = TRUE),]
data_filt_head <- head(data_filt, n = 5)
data_filt_tail <- tail(data_filt, n = 5)
data_filt_merge <- rbind(data_filt_head, data_filt_tail)
data_filt_merge <- data_filt_merge[order(data_filt_merge$V3, decreasing = FALSE),]

