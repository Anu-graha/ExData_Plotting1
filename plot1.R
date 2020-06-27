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

org_data$Date<-as.Date(org_data$Date, format="mm/dd/yyyy")

## Extract only 2 days data

pow_cnsmptn<-subset(org_data, org_data$Date==as.Date("2007-02-01") | org_data$Date==as.Date("2007-02-02"))


## Open png graphic device

png(filename="plot1.png", width=480, height=480, units="px")

## Plot the Hist graph

hist(pow_cnsmptn$Global_active_power,col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", main="Global Active Power")

## Close the png graphic device

dev.off()

