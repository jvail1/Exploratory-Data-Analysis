
require(sqldf)

# Read data in from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#Unzip household_power_consumption.txt to local working directory
#Make table from subset of data 2/2/2007 and 2/2/2007
hpc <- read.csv.sql("household_power_consumption.txt", 'select * from file where Date = "1/2/2007" or Date = "2/2/2007" ', sep = ";")

#Close all connections
closeAllConnections()

#Plot histogram of Global Active Power with appropriate labels and color
hist(hpc$Global_active_power, xlab = "Global Active Power (kilowatts)", col = "red", main = "Global Active Power")

#Write Histogram out to PNG file for upload to Github
dev.copy(png, file = "plot1.png", width = 480, height = 480)
dev.off()