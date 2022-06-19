

##############################################################################
# STEP 1 - Load Data 
############################################################################## 
File_Source <- "https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption"
energy_UCI <-  read.table("household_power_consumption.txt", 
                          sep = ";", 
                          header = TRUE, 
                          na.strings="?")

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
# STEP 4 - Create a new variable Datetime  
##############################################################################

#Concatenate time and date to create POSIX object  
datetime <- paste(as.Date(Feb$Date), Feb$Time) 
Feb$Datetime <- as.POSIXct(datetime)


##############################################################################
# STEP 5 - Generate and Save Plot 
##############################################################################
png(file = "GlobalActivePower_Timeseries_Plot2.png", 
    width = 480, height = 480)


with(Feb, plot(Datetime, Global_active_power, type = "l",
               ylab = "Global Active Power (kilowatts)",
               xlab = ""))  

         
dev.off()


##############################################################################
          