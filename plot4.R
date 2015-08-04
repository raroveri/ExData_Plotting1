library(dplyr)
library(lubridate)

# reading the data
data <- read.csv("household_power_consumption.txt", 
                 colClasses = c("character", "character", "numeric", 
                                "numeric", "numeric", "numeric", 
                                "numeric", "numeric", "numeric"), 
                 na.strings = "?", 
                 sep=";")
# filtering only the desired dates
data <- filter(data, dmy(Date)==dmy("01/02/2007") | dmy(Date)==dmy("02/02/2007"))
# an extra field containing date and time
data <- mutate(data, DateTime = dmy_hms(paste(Date, Time)))
# an extra field containing the weekday
data <- mutate(data, WeekDayDT = wday(DateTime, label=TRUE))

# open PNG device; create 'plot4.png' in my working directory
png(file = "plot4.png")

#
# plotting
#

# layout setup
par(mfrow = c(2, 2))
par(mar = c(5.1, 4.1, 4.1, 2.1))

# plot top left
with(data, 
     plot(DateTime, Global_active_power,
          col="black",
          type="l",
          ylab="Energy sub metering", 
          xlab=""))

# plot top right
with(data, 
     plot(DateTime, Voltage,
          col="black",
          type="l",
          ylab="Voltage", 
          xlab="datetime"))

# plot bottom left
with(data, 
     plot(DateTime, Sub_metering_1,
          col="black",
          type="l",
          ylab="Energy sub metering", 
          xlab=""))
with(data, 
     points(DateTime, Sub_metering_2,
          col="red",
          type="l", 
          xlab=""))
with(data, 
     points(DateTime, Sub_metering_3, 
          type="l",
          col="blue", 
          xlab=""))
legend("topright", 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lwd = 1, bty = "n",
       col = c("black", "red", "blue"))

# plot bottom right
with(data, 
     plot(DateTime, Global_reactive_power,
          col="black",
          type="l",
          ylab="Global_reactive_power", 
          xlab="datetime"))

# Close the PNG file device
dev.off()