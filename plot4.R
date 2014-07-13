# using the “Individual household electric power consumption Data Set”,
# examines how household energy usage varies over a 2-day period in February, 2007

# Serves as the driver function for creating multiple plots
# for the energy usage data.
plotMultipleGraphs <- function() {

    dat <- loadData()
    
    png(filename = "plot4.png")
    
    par(mfrow = c(2, 2))
    plotGlobalActivePower(dat)
    plotVoltage(dat)
    plotSubmetering(dat)
    plotGlobalReactivePower(dat)
    
    x <- dev.off()
}

# Loads the data from the text data file.
# Returns a data frame with only the data for Feb 1-2, 2007.
loadData <- function() {
    dat <- read.table(
        pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
        header=FALSE, sep=';', na.strings='?', stringsAsFactors=FALSE)
    colnames(dat) <- names(read.table('household_power_consumption.txt', header=TRUE, sep=";", nrows=1))
    dat
}

# Plots the Voltage over days.
plotVoltage <- function(dat) {
    x <- as.POSIXct(strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S"))
    y <- dat$Voltage
    
    plot(x, y, xlab="datetime", ylab="Voltage", type="n", bty="n", font=2, font.lab=2)
    box(lwd=2)
    lines(x, y, lwd=2)
}

# Plots the global active power over days.
plotGlobalActivePower <- function(dat) {
    x <- as.POSIXct(strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S"))
    y <- dat$Global_active_power
    
    plot(x, y, xlab="", ylab="Global Active Power", type="n", bty="n", font=2, font.lab=2)
    box(lwd=2)
    lines(x, y, lwd=2)    
}

# Plts the submetering data over days.
plotSubmetering <- function(dat) {
    
    x <- as.POSIXct(strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S"))
    p <- dat$Sub_metering_1
    q <- dat$Sub_metering_2
    r <- dat$Sub_metering_3
    
    plot(x, y=p, xlab="", ylab="Energy sub metering", type="n", bty="n", font=2, font.lab=2)
    box(lwd=2)
    axis(side = 2, lwd.ticks=2, labels=NA)
    
    legend(
        "topright",
        col=c("black", "red", "blue"),
        lty="solid",
        legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
        inset=.0025,
        text.font=1,
        bty="n")
    
    lines(x, p, lwd=2)
    lines(x, q, lwd=2, col="red")
    lines(x, r, lwd=2, col="blue")
}

# Plots the global reactive power over days.
plotGlobalReactivePower <- function(dat) {
    x <- as.POSIXct(strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S"))
    y <- dat$Global_reactive_power
    
    plot(x, y, xlab="datetime", ylab="Global_reactive_power", type="n", bty="n", font=2, font.lab=2)
    box(lwd=2)
    lines(x, y, lwd=2)
}


