## Load file

library(dplyr)

library(tidyr)

library(magrittr)

## The name of the days are in spanish

if(!file.exists("./data")){dir.create("./data")}
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "./data/exdata_data_household_power_consumption.zip", method = "curl" )

unzip("./data/exdata_data_household_power_consumption.zip", exdir = "./data")

## Extract the data

exdata <- read.csv("./data/household_power_consumption.txt", sep = ";", header = TRUE)

exdata1 <- exdata

## Transform the data

exdatasel <- filter(exdata1, exdata$Date == "1/2/2007" |exdata$Date == "2/2/2007" )

exdatasel <- exdatasel[complete.cases(exdatasel),]

extransf <- transform(exdatasel, Global_active_power =as.numeric(Global_active_power), Global_reactive_power = as.numeric(Global_reactive_power), Voltage = as.numeric(Voltage), Date = strptime(Date,"%d/%m/%Y"), Sub_metering_1 = as.numeric(Sub_metering_1),Sub_metering_2 = as.numeric(Sub_metering_2))

extransf$datetime <- paste(extransf$Date, extransf$Time)

extransf$datetime <- as.POSIXct(extransf$datetime)

## Plot the data

exdat <- extransf

png("Plot2.png")

plot(exdat$Global_active_power ~ exdat$datetime, ylab= "Global Active Power (kilowatts)", xlab= "", type= "l")

dev.off()

