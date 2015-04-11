require(dplyr)
require(sqldf)

# Read data in from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Make table from subset of data 2/2/2007 and 2/2/2007
hpc <- read.csv.sql("household_power_consumption.txt", 'select * from file where Date = "1/2/2007" or Date = "2/2/2007" ', sep = ";")

#Close all connections
closeAllConnections()

#Convert to table for use with dplyr
hpc <- tbl_df(hpc)

#Create DateTime column with Date and Time convert to POSIXT
hpc <- mutate(hpc,DateTime = as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

#Plot Global Active Power against DateTime with lines
plot(hpc$DateTime, hpc$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(hpc$DateTime, hpc$Global_active_power)

#Write Plot out to PNG file for upload to Github
dev.copy(png, file = "plot2.png", width = 480, height = 480)
dev.off()