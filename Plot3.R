
library(dplyr)
library(lubridate)

#download file
if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./data/power.zip")
unzip("./data/power.zip", exdir="./data")
path <- file.path("./data")

#subsetting the data
data1 <- tbl_df(read.table(file.path(path,"household_power_consumption.txt"), sep = ";", header = TRUE, na.strings = "?", nrows = 70000)) %>%
  mutate(datetime = dmy_hms(paste(Date, Time)), Date = dmy(Date), Time = hms(Time)) %>%
  subset(Date>="2007-02-01" & Date<="2007-02-02") ##note lubridate doesn't currently play well with filter from dplyr

#creating plot3.png
png(filename="plot3.png", width=480, height=480)
plot(data1$datetime, data1$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering" )
lines(data1$datetime, data1$Sub_metering_2, col="red" )
lines(data1$datetime, data1$Sub_metering_3, col="blue" )
legend("topright", lty=c(1,1,1), col=c("black", "red", "blue"), legend=c("Sub metering 1", "Sub metering 2", "Sub metering 3"))
dev.off()