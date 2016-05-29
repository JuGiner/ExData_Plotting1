# Download and read data
#--------------------------------------------------------------
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile = "household_power_consumption.zip", method = "curl")
unzip("household_power_consumption.zip")
epc <- read.table("./household_power_consumption.txt", sep = ";", 
                  header = TRUE, stringsAsFactors = FALSE, na.strings = "?")

# Defining variables
#--------------------------------------------------------------
height <- 480
width <- 480

# Extracting util data
#--------------------------------------------------------------
# Convert Date/time
epc$DateTime <- paste(epc$Date, epc$Time)
epc$DateTime <- strptime(epc$DateTime, "%d/%m/%Y %H:%M:%S")
epc$Date <- as.Date(strptime(epc$Date, "%d/%m/%Y"))
t1 <- as.Date("2007-02-01")
t2 <- as.Date("2007-02-02")
# Subset
dat <- subset(epc, Date == t1 | Date == t2)

# Making the plot
#--------------------------------------------------------------
png("plot3.png", width = width, height = height)
plot(dat$DateTime, dat$Sub_metering_1, ylab = "Energy sub metering", 
     xlab = "", type = "n")
lines(dat$DateTime, dat$Sub_metering_1, col = "black")
lines(dat$DateTime, dat$Sub_metering_2, col = "red")
lines(dat$DateTime, dat$Sub_metering_3, col = "blue")
legend("topright", lwd=1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
