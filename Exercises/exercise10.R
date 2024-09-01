# Load sleep-in-mammals.csv and look at the structure of the dataset
sleep <- read.csv("./Rdatasets/sleep-in-mammals.csv")
str(sleep)

# Look for missing variables. Subset the data by keeping only the species (rows)
# with complete data (62->42 without NAs). 
missing_values <- which(is.na(sleep), arr.ind = TRUE)
print(missing_values)
paste("Missing values: ", length(missing_values))

sleep_filtered <- na.omit(sleep)
missing_values <- which(is.na(sleep_filtered), arr.ind = TRUE)
paste("Missing values after filtering: ", length(missing_values))

# Additionally remove species Echidna,
# Lessershort-tailedshrew and Muskshrew to keep 39 (used in paper).
sleep_filtered <- subset(sleep_filtered, !(Species %in% c("Echidna", "Lessershort-tailedshrew", "Muskshrew")))

# Calculate pairwise correlations (for three methods Pearson, Kendall and Spearman)
cor(sleep_filtered[,2:ncol(sleep_filtered)], use = "pairwise", method="pearson")
cor(sleep_filtered[,2:ncol(sleep_filtered)], use = "pairwise", method="kendall")
cor(sleep_filtered[,2:ncol(sleep_filtered)], use = "pairwise", method="spearman")

# Generate pairwise plots (pairs or chart.Correlation)
chart.Correlation(sleep_filtered[,2:ncol(sleep_filtered)], 
                  method = "pearson",
                  histogram = TRUE, 
                  pch = 16)
chart.Correlation(sleep_filtered[,2:ncol(sleep_filtered)], 
                  method = "kendall",
                  histogram = TRUE, 
                  pch = 16)
chart.Correlation(sleep_filtered[,2:ncol(sleep_filtered)], 
                  method = "spearman",
                  histogram = TRUE, 
                  pch = 16)

# Run stepwise multiple regression analysis in which SWS or SP are dependent variable 
# and constitutional (lifespan, bodyweight, brain weight, gestation) and ecological 
# measures (predation, exposure, danger) are independent variables
# (either use paradoxical "dreaming" sleep / PS or slow wave ("nondreaming") sleep / SWS as dependent variable)
# For NonDreaming (SWS)
model.null = lm(NonDreaming ~ 1 ,
                data = sleep_filtered)
model.full = lm(NonDreaming ~ LifeSpan + BodyWt + BrainWt + Gestation + Predation + Exposure + Danger,
                 data = sleep_filtered)
step(model.null,
     scope = list(upper = model.full),
     direction = "both", test="F",
     data = sleep_filtered)
model.final_SWS = lm(formula = NonDreaming ~ Gestation + Danger, 
                     data = sleep_filtered)
summary(model.final_SWS)
plot(model.final_SWS, pch = 16, which = 1)

# For Dreaming (SP)
model.null = lm(Dreaming ~ 1 ,
                data = sleep_filtered)
model.full = lm(Dreaming ~ LifeSpan + BodyWt + BrainWt + Gestation + Predation + Exposure + Danger,
                data = sleep_filtered)
step(model.null,
     scope = list(upper = model.full),
     direction = "both", test="F",
     data = sleep_filtered)
model.final_SP = lm(formula = Dreaming ~ Danger + Predation + BodyWt + Gestation + Exposure, 
                    data = sleep_filtered)
summary(model.final_SP)
plot(model.final_SP, pch = 16, which = 1)

# Perform principal component analysis (PCA) and look at results with 3D PCA plot
# Add labels to small spheres in 3D plot
library("rgl")
pcaData <- sleep_filtered[,2:ncol(sleep_filtered)]
pca <- prcomp(scale(pcaData))
head(pca) # usefull to check axis
matrixPCA <- cbind(pca$x[,1],pca$x[,2],pca$x[,3])
pcaPlot <- plot3d(matrixPCA, 
                  main = "",
                  pch = 1, 
                  type = "s",
                  # 'p' points, 's' spheres, 'l' lines, 'h' line segments
                  radius = 0.15,
                  xlab = "pc1", 
                  ylab = "pc2", 
                  zlab = "pc3")
text3d(matrixPCA, texts = sleep_filtered$Species, adj = c(-0.1, -0.1), cex = 0.7)
