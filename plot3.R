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

# open PNG device; create 'plot3.png' in my working directory
png(file = "plot3.png")

# plotting
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
       lwd = 1,
       col = c("black", "red", "blue"))

# Close the PNG file device
dev.off()