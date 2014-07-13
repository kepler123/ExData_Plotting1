# Using the “Individual household electric power consumption Data Set”,
# examines how household energy usage varies over a 2-day period in February, 2007
# by plotting a graph of Global Active Power over days.
plotGlobalActivePowerOverDays <- function() {
    dat <- loadData()
    
    png(filename = "plot2.png")

    x <- as.POSIXct(strptime(paste(dat$Date, dat$Time), "%d/%m/%Y %H:%M:%S"))
    y <- dat$Global_active_power

    plot(x, y, xlab="", ylab="Global Active Power (kilowatts)", type="n", bty="n", font=2, font.lab=2)
    box(lwd=2)
    lines(x, y, lwd=2)
    
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