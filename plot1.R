# Using the “Individual household electric power consumption Data Set”,
# examines how household energy usage varies over a 2-day period in February, 2007
# by plotting a graph of Global Active Power.
plotGlobalActivePower <- function() {
    dat <- loadData()
    
    png(filename = "plot1.png")

    hist(dat$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")

    # The snapshot of the assignment seems to look like the axis lines, ticks, and captions are thicker than the default.
    axis(side=1, lwd=2)
    axis(side=2, lwd=2)
    par(font.axis=2, font.lab=2, lwd=2)

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