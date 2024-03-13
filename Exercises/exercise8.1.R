fecal <- c(3,13)
vancomycin <- c(9,4)
outcome <- data.frame(fecal, 
                      vancomycin, 
                      row.names = c("sick","cured"))
fisher.test(outcome)

