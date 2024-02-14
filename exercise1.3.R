sizes <- c("S", "M", "L", "S", "M")
sizes <- factor(sizes)
class(sizes)
sizes

# Change the levels to their full names
levels(sizes) <- c("Large", "Medium", "Small")
sizes

# Setting the 4th value to NA, and checking the levels and values again
sizes[4] <- NA
sizes
is.na(sizes)
