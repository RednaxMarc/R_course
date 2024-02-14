name <- c("Xander", "Arne", "Lore", "Aline", "Louis", "Iris")
age <- c(24,24,21,21,26,21)
df_patients <- data.frame(name, age)
df_patients

# Summary of the dataframe
summary(df_patients)

colnames(df_patients) <- c("Name", "Age")
summary(df_patients)


# Print the first row of the dataframe
head(df_patients, n=1)
df_patients[1,]

# Display patient 2, 3, 4
df_patients[2:4, ]
df_patients[c(2,4),] # If you dont't want to show row 3

# Display the ages of all patients
df_patients[,2]
df_patients$age
df_patients$Age

# Class of patients name
class(df_patients$Name)

# Change the class of patients name as factor
df_patients$Name <- as.factor(df_patients$Name)
df_patients$Name
df_patients$Name <- as.character(df_patients$Name)
class(df_patients$Name)

# Add gender as factor
gender <- as.factor(c("M", "M", "F", "F", "M", "F"))
class(gender)
df_patients <- data.frame(name, age, gender)
df_patients
class(df_patients$gender)
