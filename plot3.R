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

# Create Line Chart of Sub metering measurements against DateTime

# get the range for the x and y axis 
x <- range(hpc$DateTime)
y <- range(c(hpc$Sub_metering_1, hpc$Sub_metering_2, hpc$Sub_metering_3))

# set up the plot for each sub metering measure by DateTime
plot(x, y, type = "n", xlab="", 
     ylab="Energy sub metering") 

#Plot lines for each measure
lines(hpc$DateTime, hpc$Sub_metering_1, col = "black")
lines(hpc$DateTime, hpc$Sub_metering_2, col= "red")
lines(hpc$DateTime, hpc$Sub_metering_3, col = "blue")


# add a legend 
legend("topright", lty=1,  col=c("black","red","blue"),
        c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))

#Write Plot out to PNG file for upload to Github
dev.copy(png, file = "plot3.png", width = 480, height = 480)
dev.off()