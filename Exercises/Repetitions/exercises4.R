# exercise4.1
urine <- read.csv("./Rdatasets/urine.csv")
par(mfrow = c(1,2))
boxplot(calc ~ r, data = urine)
urine$r <- as.factor(urine$r)
levels(urine$r) <- c("No", "Yes")
boxplot(calc ~ r, data = urine,
        xlab = "Presence of calcium oxate crystals",
        ylab = "Calcium concentration",
        main = "Boxplot calcium concentation urine dataset",
        pch = "x")

# exercise4.2
library(lme4)
library(RColorBrewer)

arabi <- Arabidopsis
str(arabi)

cat_var <- c("reg", "amd", "status", "popu")
layout(matrix(c(1,2,3,4,4,4), 2, 3, byrow = TRUE))
for (var in cat_var){
  barplot(table(arabi[,var]),
          main = paste("Barplot of", var), 
          ylab = "Frequency",
          xlab = paste(var, "levels"),
          ylim = c(0,max(table(arabi[,var]) + 50)),
          col = brewer.pal(9, "Paired"))
}

num_var <- c("gen", "rack", "nutrient", "total.fruits")
par(mfrow = c(2,2))
for (var in num_var){
  hist(arabi[,var], probability = TRUE,
       col = "white", 
       main = paste("Histogram of", var),
       xlab = var)
  lines(density(arabi[,var]))
}

factors <- c("rack", "nutrient")
par(mfrow = c(1,2))
for (var in factors){
  bp <- barplot(table(arabi[,var]),
          main = paste("Barplot of", var), 
          col = brewer.pal(3, "Paired"), 
          ylim = c(0,max(table(arabi[,var])) + 50))
  text(x = bp, y = table(Arabidopsis[,var]), label = table(Arabidopsis[,var]), pos = 3)
}

other_var <- c("gen", "total.fruits")
for (var in other_var){
  boxplot(arabi[,var] ~ arabi$reg,
          main = paste("Boxplot of", var),
          col = brewer.pal(3, "Paired"),
          xlab = NULL,
          ylab = NULL)
}

par(mfrow = c(1,1))
colors <- arabi$reg
levels(colors) <- list("#A6CEE3" = "NL", 
                       "#1F78B4" = "SP",
                       "#B2DF8A" = "SW")
colors <- as.character(colors)
plot(arabi$total.fruits ~ arabi$gen,
     xlab = "Genotype",
     ylab = "Total fruits",
     main = "Arabidopsis genotype vs total fruits",
     pch = as.numeric(arabi$reg) - 1,
     col = colors)
legend("topright", levels(arabi$reg), 
       pch = c(0,1,2), 
       col = levels(as.factor(colors)),
       title = "Region")





