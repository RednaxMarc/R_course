# exercise 8.1
fecal <- c(3,13)
vancomycin <- c(9,4)
outcome <- data.frame(fecal, 
                      vancomycin, 
                      row.names = c("sick","cured"))
fisher.test(outcome)

# exercise 8.2
pigs <- read.csv("./Rdatasets/pigs-diets-weight.csv")

pig.weights <- c()
pig.diets <- c()
for (i in colnames(pigs)){
  pig.weights <- c(pig.weights, pigs[,i])
  pig.diets <- c(pig.diets, rep(i, length(pigs[,i])))
}
pigs.df <- data.frame(Diets=pig.diets, Weights=pig.weights)

boxplot(Weights~Diets, data=pigs.df)

for (i in colnames(pigs)){
  meanDiet <- mean(pigs[,i])
  print(paste("Mean for",i,":",meanDiet))
  sdDiet <- sd(pigs[,i])
  print(paste("SD for",i,":",sdDiet))
}

pigs.model = lm(Weights~Diets, data=pigs.df)
summary(pigs.model)
anova(pigs.model)
confint(pigs.model)