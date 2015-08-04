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

# open PNG device; create 'plot1.png' in my working directory
png(file = "plot1.png")

# plotting
hist(data$Global_active_power, 
     col="red", 
     xlab="Gloabal Active Power (kilowatts)", 
     main="Global Active Power")

# Close the PNG file device
dev.off()