## plot4.R
## all 4 plots together for comaprison

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

par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(sub_dt, {
  plot(Global_active_power~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~Datetime, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~Datetime, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~Datetime, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})

## output png file

dev.copy(png, file = "plot4.png", height = 480, width = 480)
dev.off()