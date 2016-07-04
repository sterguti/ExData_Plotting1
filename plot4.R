
Epc <- read.table(text = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value = TRUE),  
                  col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
                                "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                  sep = ";", header = TRUE)

# convert date and time variables to Date/Time class
Epc$Time <- strptime(Epc$Time, format ="%H:%M:%S")
Epc$Date <- as.Date(Epc$Date, format ="%d/%m/%Y")

datetime <- paste(as.Date(Epc$Date), Epc$Time)
Epc$Datetime <- as.POSIXct(datetime)


png("plot4.png", width=480, height=480)
par(mfrow=c(2,2))
#1
plot(Epc$Datetime, Epc$Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")

#2
plot(Epc$Datetime, Epc$Voltage, type = "l", ylab = "Voltage", xlab= "datetime")

#3
plot(Epc$Datetime, Epc$Sub_metering_1, type="l", col="black",
     xlab="", ylab="Energy sub metering")
lines(Epc$Datetime, Epc$Sub_metering_2, col="red")
lines(Epc$Datetime, Epc$Sub_metering_3, col="blue")
legend("topright",
       col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1, lwd = 1, 
       bty = "n")
# 4
plot(Epc$Datetime, Epc$Global_reactive_power, type="n",
     xlab="datetime", ylab="Global_reactive_power")
lines(Epc$Datetime, Epc$Global_reactive_power)
dev.off()
