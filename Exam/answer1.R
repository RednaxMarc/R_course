library("Stat2Data")
library("RColorBrewer")

data(BirdNest)
str(BirdNest)

nesttype <- table(BirdNest$Nesttype)
nesttype <- sort(nesttype)

par(mar = c(5,9,3,3))
bp <- barplot(nesttype,
              horiz = TRUE,
              names.arg = names(nesttype), las=1,
              main = "Counts of nesttypes",
              xlab = "Total number of nests",
              xlim = c(0,60),
              col = rev(brewer.pal(length(nesttype), "Dark2")))
text(y = bp, x = nesttype, label = nesttype, pos = 4, col = rev(brewer.pal(length(nesttype), "Dark2")))
mtext("Type of Nest", side = 2, adj = 0, las = 1)
abline(v = seq(10,60,10), lty = 5) 
abline(v = seq(5,55,10), lty = 4)



