## plot1.R
## GLobal Active Power vs Frequency histogram

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

hist(sub_dt$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")

## output png file

dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()

