## Exercise 9.1
# Yukilevich and True (2008) mixed 30 male and 30 female fruit flies Drosophila 
# melanogaster from Alabama with 30 male and 30 females from Grand Bahama 
# Island -> observed 246 matings: 140 homotypic (male x female same location,
# 106 heterotypic (male x female different location)

# Test H0: flies mate randomly (equal numbers homotypic vs heterotypic matings)
binom.test(c(140,106), p = 0.5)
binom.test(c(106,140), p = 0.5)
# p-value = 0.03 -> Reject 0 hypothesis

## Exercise 9.2
# Measles attack rates were followed among vaccinated and unvaccinated  
# children. Of the vaccinated children 10 had measles and 90 were not attacked.
# Of the unvaccinated children 26 were attacked by measles vs. 74 not.
# Are the vaccination and attack rates independent (H0)?
# Or does the vaccination protects (Ha not independent)?

attacked <- c(26,10)
nonattacked <- c(74,90)
outcome <- data.frame(attacked, 
                      nonattacked, 
                      row.names = c("unvaccinated","vaccinated"))
fisher.test(outcome)
# p-values = 0.005249 -> Vaccinations hepls preventing attacks

## Exercise 9.3
# Allele frequencies at the Lap locus in mussel were surveyed by McDonald and 
# Siebenaller (1989) on the Oregon coast. Mussels were collected from inside four 
# estuaries and from a marine habitat outside the estuary. 
# Alleles were classified as Lap94 and non-94 class. 

# H0: at each area there is no difference in proportion of Lap94 alleles
# between marine and estuarine habitats. Reject H0 or not?
# make the array
mussel <- array(c(56,40,69,77,
                61,57,257,301,
                73,71,65,79,
                71,55,48,48),
                dim = c(2,2,4),
                dimnames = list(Allele = c("94", "non-94"),
                                Habitiat = c("Marine", "Estuearine"),
                                Location = c("Tillamook", "Yaquina", "Alsea", "Umpqua")))

mantelhaen.test(mussel)

## Exercise 9.4
# In a corn planting experiment two factors are considered affecting the yield:
# the manure (low, high) and the fertilizer (low, high)
# Use corn-dataset.csv in Rdatasets
# Make a boxplot of the yield for each manure x fertilizer group
# Test the effect of manure, fertilizer and if there is an interaction between them
corn <- read_csv("./Rdatasets/corn-dataset.csv")
boxplot(data = corn, Yield ~ Fert*Manure,
        ylab = "Fert x Manure")
corn.model = lm(data = corn, Yield ~ Fert*Manure)
summary(corn.model)
anova(corn.model)






