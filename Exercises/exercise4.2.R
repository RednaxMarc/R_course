setwd("/home/guest/R_course")
# Load the Arabidopsis dataset from the lme4 package
# install.packages("lme4")
library(lme4)
Arabidopsis <- Arabidopsis

# Look at the structure of this dataset: how many observations and variables?
# How many factors and numeric variables?
str(Arabidopsis)

# Make one figure showing barplots for the different categorical variables,
# with title “Barplot variable name”,each bar in a different color  
# (at least 9 colors i.e. max. levels) and axes set with labels and limit (ylim)
library(RColorBrewer)
colors <- brewer.pal(12,"Paired")
layout(matrix(c(1,2,3,4,4,4),
              2,
              3, 
              byrow = TRUE))
cat_var <- c("reg", "amd", "status", "popu")
for (i in cat_var ){
  barplot(table(Arabidopsis[,i]),
          col = colors,
          xlab = paste(i, "levels"),
          main = paste("Barplot", i),
          ylim = c(0,max(table(Arabidopsis[,i]))+50))
}

# Make a second figure with histograms of the four numerical variable and add the density lines.
num_var <- c("gen", "rack", "nutrient", "total.fruits")
par(mfrow=c(2,2))
for (i in num_var){
  hist(Arabidopsis[,i],
      breaks = 10,
      main = paste0("Histogram of Arabidopsis$",i),
      col = "white",
      probability = TRUE)
  lines(density(Arabidopsis[,i]))
}

# Which numerical variables can be set as factor because they have only 
# a few possible numerical values? Set them as.factor and make a new figure with barplots.  
# Can you add the frequencies above the bars?
Arabidopsis$rack <- as.factor(Arabidopsis$rack)
Arabidopsis$nutrient <- as.factor(Arabidopsis$nutrient)
str(Arabidopsis)
num_as_factor <-c("rack", "nutrient")
colors <- brewer.pal(12,"Paired")
par(mfrow = c(1,2))
for (i in num_as_factor){
  bp <- barplot(table(Arabidopsis[,i]),
          main = paste("Barplot",i),
          col = colors,
          ylim=c(0,350))
  text(x=bp, y=table(Arabidopsis[,i]),label=table(Arabidopsis[,i]),pos=3)
}

# Make a new figure with boxplots of the remaining numerical values per region
# with title, labels and colors.
# num_var <- c("gen", "total.fruits")
par(mfrow=c(1,2))
boxplot(Arabidopsis$gen ~ Arabidopsis$reg,
        main = "Boxplot Gentype",
        col = colors)
boxplot(Arabidopsis$total.fruits ~ Arabidopsis$reg,
        main = "Boxplot Total Fruits",
        col = colors,)

# Also make a scatterplot of two numerical values with title, 
# colors and legend. Each region in different color and symbol
par(mfrow=c(1,1))
colors <- brewer.pal(3,"Paired")
reg_colors <- Arabidopsis$reg
levels(reg_colors) <- list("#66C2A5" = "NL",
                           "#FC8D62" = "SP",
                           "#8DA0CB" = "SW")
reg_colors <- as.character(reg_colors)
plot(Arabidopsis$gen, Arabidopsis$total.fruits,
     xlab = "Genotype",
     ylab = "Total Fruits",
     main = "Arabidopis genotype vs total fruits",
     pch = as.numeric(Arabidopsis$reg) -1,
     cex = 0.7,
     col = reg_colors)





