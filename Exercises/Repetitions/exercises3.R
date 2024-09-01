# exercise 3.1
mice <- read.csv("./Rdatasets/mice_weights.csv")
str(mice)
sd(mice$Bodyweight)
barplot(table(mice$Diet))
hist(mice$Bodyweight)
boxplot(mice$Bodyweight ~ mice$Diet)
qqplot(mice$Bodyweight[mice$Diet == "chow"], mice$Bodyweight[mice$Diet == "hf"])

# exercise 3.2


# exercise 3.3
hospital <- read.csv("./Rdatasets/hospitalpatients.csv")
str(hospital)
hospital$Gender <- as.factor(hospital$Gender)
hospital$HospitalSurvival <- as.factor(hospital$HospitalSurvival)
barplot(table(hospital$Gender))
barplot(table(hospital$HospitalSurvival))
quantile(hospital$Age)
hist(hospital$Age)
plot(density(hospital$Age))
hist(hospital$Age, probability = TRUE)
lines(density(hospital$Age),
      col = "gray")
boxplot(hospital$Weight)
vars <- c("Length", "Weight", "HospitalDays")
for (i in vars){
  par(mfrow = c(1,2))
  hist(hospital[,i])
  boxplot(hospital[,i], data = hospital)
}
