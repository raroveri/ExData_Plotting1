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

# open PNG device; create 'plot2.png' in my working directory
png(file = "plot2.png")

# plotting
with(data, 
     plot(DateTime, Global_active_power, 
          type="l",
          ylab="Gloabal Active Power (kilowatts)"))

# Close the PNG file device
dev.off()