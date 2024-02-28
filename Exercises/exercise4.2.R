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
colors <- brewer.pal(12,"Set2")
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
colors <- brewer.pal(12,"Set1")
par(mfrow = c(1,2))
for (i in num_as_factor){
  barplot(table(Arabidopsis[,i]),
          main = paste("Barplot",i),
          col = colors,)
  mtext(Arabidopsis[,i])
}




