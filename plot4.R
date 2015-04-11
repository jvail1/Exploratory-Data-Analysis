require(dplyr)
require(sqldf)

# Read data in from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Unzip household_power_consumption.txt to local working directory
#Make table from subset of data 2/2/2007 and 2/2/2007
hpc <- read.csv.sql("household_power_consumption.txt", 'select * from file where Date = "1/2/2007" or Date = "2/2/2007" ', sep = ";")

#Close all connections
closeAllConnections()

#Convert to table for use with dplyr
hpc <- tbl_df(hpc)

#Create DateTime column with Date and Time convert to POSIXT
hpc <- mutate(hpc,DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

#Create multi base plots
par(mfcol= c(2,2), mar=c(4,4,1,1), oma=c(1,1,0,0))

with (hpc, {
        #Plot 1
        plot(DateTime, Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
        lines(DateTime, Global_active_power) 
        
        #Plot2
        x <- range(DateTime)
        y <- range(c(Sub_metering_1, Sub_metering_2, Sub_metering_3))
        plot(x, y, type = "n", xlab="", 
             ylab="Energy sub metering") 
        
        #Plot lines for each measure
        lines(DateTime, Sub_metering_1, col = "black")
        lines(DateTime, Sub_metering_2, col= "red")
        lines(DateTime, Sub_metering_3, col = "blue")
        
        
        # add a legend 
        legend("topright", lty=1, bty = "n", cex = 0.8, col=c("black","red","blue"), 
               c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
        
        #Plot 3
        plot(DateTime, Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
        lines(DateTime, Voltage) 
        
        #Plot 4
        plot(DateTime, Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
        lines(DateTime, Global_reactive_power) 
         })

#Write Plot out to PNG file for upload to Github
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()