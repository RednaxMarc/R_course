setwd("~/R_course")
# Load the data of the hospital patients (hospitalpatients.csv) in a patients dataframe 
patients <- read.csv("./Rdatasets/hospitalpatients.csv")

# How many columns and row?
dim(patients)

# What are column names and the data types? 
str(patients)

# How many male and female patients?
nrow(subset(patients, Gender == "M"))
nrow(subset(patients, Gender == "F"))

# Create a vector with the patient ages sorted ascending
ages <- sort(c(patients$Age))

# How many male patients are larger than 180 cm and weigh > 100 kg?
nrow(subset(patients, Length >= 180, Weight > 100))

# How many female patients have died in hospital?
nrow(subset(patients, Gender == "F", HospitalSurvival == 0))

# Change the gender (levels): F to Female and M to Male
