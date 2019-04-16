#Plot 2
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

#Plot 2
png(filename="plot2.png")
plot(x=data$DT,y=data$Global_active_power,type="l",
     xlab="",ylab="Global Active Power (kilowatts)")
dev.off()

rm(data)