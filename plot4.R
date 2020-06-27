##loading library
library(lubridate)
library(dplyr)

## Downloading and reading the data

fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filename<-"Household_Power_Consumption"

if(!file.exists("exdata_data_household_power_consumption.zip")){
  download.file(fileURL,"Household_Power_Consumption", method="curl")
}

if(!file.exists("household_power_consumption.txt")){
  unzip(filename)
}

## Read and Set data formats for Date and Time

org_data<-read.csv("Household_Power_Consumption.txt", sep=";",stringsAsFactors = FALSE,na.strings = "?",header = TRUE)

org_data$Date<-as.Date(org_data$Date, format= "%d/%m/%Y")

## Extract only 2 days data

pow_cnsmptn<-subset(org_data, org_data$Date==as.Date("2007-02-01") | org_data$Date==as.Date("2007-02-02"))

## Add a new column Date Time

pow_cnsmptn<-mutate(pow_cnsmptn, DateTime=paste(pow_cnsmptn$Date, pow_cnsmptn$Time))
pow_cnsmptn$DateTime<-as_datetime(pow_cnsmptn$DateTime, format="%Y-%m-%d %H:%M:%S")

## Open png graphic device

png(filename="plot4.png", width=480, height=480, units="px")

## Plot the graph

#create plot frame

par(mfrow=c(2,2))

#plot1

plot(pow_cnsmptn$DateTime,pow_cnsmptn$Global_active_power, type="l", ylab="Global Active Power(kilowatts)", xlab="")

#plot2

plot(pow_cnsmptn$DateTime,pow_cnsmptn$Voltage, type="l", ylab="Voltage", xlab="datetime")

#plot3

plot(pow_cnsmptn$DateTime,pow_cnsmptn$Sub_metering_1, type="l", col="black", ylab="Energy sub metering", xlab="")
lines(pow_cnsmptn$DateTime,pow_cnsmptn$Sub_metering_2, type="l", col="red")
lines(pow_cnsmptn$DateTime,pow_cnsmptn$Sub_metering_3, type="l", col="blue")

legend("topright", lty="solid", col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")


#plot4

plot(pow_cnsmptn$DateTime,pow_cnsmptn$Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")


## Close the png graphic device

dev.off()