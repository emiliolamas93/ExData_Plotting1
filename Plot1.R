
## Load file

library(dplyr)

library(tidyr)

library(magrittr)

if(!file.exists("./data")){dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./data/exdata_data_household_power_consumption.zip", method = "curl" )

unzip("./data/exdata_data_household_power_consumption.zip", exdir = "./data")

## Extract the data

exdata <- read.csv("./data/household_power_consumption.txt", sep = ";", header = TRUE)

exdata1 <- exdata

## Transform the data

exdatasel <- filter(exdata1, exdata$Date == "1/2/2007" |exdata$Date == "2/2/2007" )

extransf <- transform(exdatasel, Global_active_power =as.numeric(Global_active_power), Global_reactive_power = as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage), Date = as.Date(Date))

## Plot the data

png("Plot1.png")
hist(extransf$Global_active_power, col ="red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")
dev.off()


