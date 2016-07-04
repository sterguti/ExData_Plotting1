
Epc <- read.table(text = grep("^[1,2]/2/2007", readLines("household_power_consumption.txt"), value = TRUE),  
                  col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity",
                                "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                  sep = ";", header = TRUE)

# convert date and time variables to Date/Time class
Epc$Time <- strptime(Epc$Time, format ="%H:%M:%S")
Epc$Date <- as.Date(Epc$Date, format ="%d/%m/%Y")

datetime <- paste(as.Date(Epc$Date), Epc$Time)
Epc$Datetime <- as.POSIXct(datetime)


png("plot2.png", width=480, height=480)
plot(Epc$Datetime, Epc$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()