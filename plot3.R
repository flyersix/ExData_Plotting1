## plot3.R
## GEnergy sub metering vs day

# read dataset from working directory

dt <- read.csv("./household_power_consumption.txt", header=T, sep=';', na.strings="?", nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')

dt$Date <- as.Date(dt$Date, format ="%d/%m/%Y")

# select data within given date range

sub_dt <- subset(dt, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(dt)

## fix dates and times

dt_fix <- paste(as.Date(sub_dt$Date), sub_dt$Time)
sub_dt$Datetime <- as.POSIXct(dt_fix)

## make plot

with(sub_dt, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## output png file

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()