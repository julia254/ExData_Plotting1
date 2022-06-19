
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
# STEP 4 - Create a new variabe Datetime  
##############################################################################

#Concatenate time and date to create POSIX object  
datetime <- paste(as.Date(Feb$Date), Feb$Time) 
Feb$Datetime <- as.POSIXct(datetime)




##############################################################################
# STEP 5 - Generate and Save Plots 
##############################################################################
png(file = "EnergyUse_Timeseries_Plot4.png", 
    width = 480, height = 480)

# Set parameters for 4 figures arranged in 2 rows and 2 columns 

par(mfrow = c(2,2))

#Plot 1 
with(Feb, plot(Datetime, Global_active_power, type = "l",
               ylab = "Global Active Power (kilowatts)",
               xlab = "")) 

#Plot 2 
with(Feb, plot(Datetime, Voltage, type = "l",
               ylab = "Voltage")) 

#Plot 3
with(Feb, plot(Datetime, Sub_metering_1, type = "l",
               ylab = "Energy sub metering",
               xlab = ""))

lines(Feb$Datetime, Feb$Sub_metering_2, type = "l", col = "red")
lines(Feb$Datetime, Feb$Sub_metering_3, type = "l", col = "blue") 

#Plot 4
with(Feb, plot(Datetime, Global_reactive_power, type = "l"))
                

dev.off()

##############################################################################