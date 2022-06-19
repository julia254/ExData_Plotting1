

##############################################################################
# STEP 1 - Load Data 
##############################################################################

File_Source <- "https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption"
energy_UCI <-  read.table("household_power_consumption.txt", sep = ";", header = TRUE)



##############################################################################
# STEP 2 - Convert Date column to dmy format  
##############################################################################
library(tidyverse)
library(lubridate)

energy_UCI$Date <- dmy(energy_UCI$Date)


##############################################################################
# STEP 3 - Subset the Data  
##############################################################################

Feb <- energy_UCI %>% filter(between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))



##############################################################################
# STEP 4 - Generate and Save Plot 
##############################################################################

png(file = "GlobalActivePower_Freq_Plot1.png", 
    width = 480, height = 480)


Plot1 <- hist(Feb$Global_active_power, 
              col = "red", 
              main = "Global Active Power",
              xlab = "Global Active Power (kilowatts)")

dev.off()


##############################################################################



