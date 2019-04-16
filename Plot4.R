#Plot 4
library(dplyr)
#Download and unzip file
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              destfile="zip_rawdata")
unzip("zip_rawdata",exdir="rawdata")
#Load the table
rawdata<-read.table("./rawdata/household_power_consumption.txt",header=T,
                    sep=";",na.string="?",stringsAsFactors = F)
#Format date and time data
rawdata$Date<-as.Date(rawdata$Date,format="%d/%m/%Y")
rawdata$DT<-paste(rawdata$Date,rawdata$Time)
rawdata$DT<-strptime(rawdata$DT,format="%Y-%m-%d %H:%M:%S")
#Select data of 2007-02-01
data<-filter(rawdata,
             rawdata$DT<"2007-02-03 00:00:00"&
                     rawdata$DT>="2007-02-01 00:00:00")
data<-data[,-c(1,2)]
#Remove rawdata
rm(rawdata)

#Plot 4
png(filename="plot4.png")
par(mfrow=c(2,2))
plot(x=data$DT, y=data$Global_active_power, 
     type="l", col="black", xlab=" ", ylab="Global Active Power")
plot(x=data$DT, y=data$Voltage, 
     type="l", col="black", xlab="datatime", ylab="Voltage")
plot(x=data$DT, y=data$Sub_metering_1, 
     type="l", col="black", xlab=" ", ylab="Energy sub metering")
lines(x=data$DT, y=data$Sub_metering_2, col="red")
lines(x=data$DT, y=data$Sub_metering_3, col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col=c("black", "red", "blue"),lty = 1)
plot(x=data$DT, y=data$Global_reactive_power, 
     type="l", col="black", xlab=" ", ylab="Global Reactive Power")
dev.off()

rm(data)