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

png(filename="plot2.png", width=480, height=480, units="px")

## Plot the graph

plot(pow_cnsmptn$DateTime,pow_cnsmptn$Global_active_power, type="l", ylab="Global Active Power(kilowatts)", xlab="")

## Close the png graphic device

dev.off()