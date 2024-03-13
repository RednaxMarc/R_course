# Install the gap package (Genetic analysis package) and load the hla dataset
# install.packages("gap")
library("gap")
library("gap.datasets")
data(hla)
head(hla)
str(hla)

# Make one figure with two boxplots (DQR alleles a1 and a2 vs patient group)
par(mfrow=c(1,2))
boxplot(hla$DQR.a1 ~ hla$id)
boxplot(hla$DQR.a2 ~ hla$id)

# Use ggplot2 and gridExtra (grid.arrange two combine two ggplot boxplots)
library("ggplot2")
library("gridExtra")
library("RColorBrewer")
library("ggthemes")
brewer.pal(3,"Dark2")
bxp1 <- ggplot(hla, aes(x = hla$id, y = hla$DQR.a1)) +
  geom_boxplot(colour = "#1B9E77") + 
  theme_economist() +
  ggtitle("Boxplot DQR.a1") + 
  scale_x_discrete(name = "Patient group") +
  scale_y_continuous(name = "Alleles",
                     breaks = seq(0, 26, 2),
                     limits=c(0, 26)) +
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))
bxp1
bxp2 <- ggplot(hla, aes(x = hla$id, y = hla$DQR.a2)) +
  geom_boxplot(colour = "#D95F02") +
  theme_economist() +
  ggtitle("Boxplot DQR.a2") + 
  scale_x_discrete(name = "Patient group") +
  scale_y_continuous(name = "Alleles",
                     breaks = seq(0, 26, 2),
                     limits=c(0, 26)) + 
  theme(plot.title = element_text(hjust = 0.5),
        plot.margin = margin(1, 1, 1, 1, "cm"))
bxp2
combined_plot <- grid.arrange(bxp1, bxp2, ncol = 2)
combined_plot


