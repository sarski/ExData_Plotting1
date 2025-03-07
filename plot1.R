# download and unzip the contents of the zipfile to local drive
fileURL = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")

# read file into R
powerdata = read.csv2("household_power_consumption.txt", colClasses = "character")

# select data subset corresponding to dates 2007-02-01 and 2007-02-02
powerdatasub = powerdata[powerdata$Date == "01/02/2007" | powerdata$Date == "02/02/2007", ]

# convert first two columns of data subset into Date class
powerdatasub$Date = as.Date(powerdatasub$Date, format = "%d/%m/%Y")
powerdatasub$Time = strptime(paste(powerdatasub$Date, powerdatasub$Time), "%Y-%m-%d %H:%M:%S")

# convert the columns 3-9 of the data subset into Numeric class
for (idx in 3:9) {
    powerdatasub[, idx] = as.numeric(powerdatasub[, idx])
}

# open PNG device and create plot in working directory
png("plot1.png", width = 480, height = 480)

# plot histogram of Global Active Power from the data subset
hist(powerdatasub$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (in kilowatts)", col = 2)

#close PNG device
dev.off()