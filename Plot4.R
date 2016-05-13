## Assignment: Course Project 1
## Plot4.R


## Checking if the file has laready been downloaded, if it hasn't then create a directory
if(!file.exists('Week1Project.zip')){
  dir.create('Week1Project')
  
  ## extracting data set from website
  fileUrl<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
  download.file(fileUrl,destfile = "./Week1Project/Data.zip")
}

setwd("./DataScientist/expData/Week1Project")##set working directory
unzippedData <-unzip("Data.zip")##unzip file
list.files()## double check to see if the file did indeed download and unzipped

## keep track of when the data got downloaded
dateDownLoaded <- date()
dateDownLoaded

## read only data needed (DN=DataNeeded)
## using function 'grep' which searches for matches to argument pattern
## also replace missing values from symbol ? to NA
DN <- read.table(text = grep("^[1,2]/2/2007", readLines(unzippedData), value = TRUE),na.strings = "?", sep = ";", header = FALSE)
head(DN) ## get an idea of what the data looks like

##Renaming Columns (it looks like grep is not reading the headers correctly)
names(DN) <-  c("Date", "Time", "Global_active_power", "Global_reactive_power",
                "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                "Sub_metering_3")

## check to see if only the 1/2/2007 and 2/2/2007 got subsetted
table(DN$Date)

## Assignment asking to use 'strptime()' function to format Data and Time
##You may find it useful to convert the Date and Time variables to Date/Time classes
## in R using the strptime()  and as.Date() functions.
## Combine the Date and Time in one column and format 
## ?strptime
DN$DateTime <- strptime(paste(DN$Date, DN$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

# Open png graphic device
png("plot4.png", width=480, height=480)
## 4 plots arranged in matrix 2x2
## use par mfcol function
par(mfcol=c(2, 2))

##Plot top left
with (DN, plot (DateTime,Global_active_power, type = "l",xlab = "" , ylab = "Global Active Power (kilowatts)"))
## Plot bottom left
with(DN, plot(DateTime, Sub_metering_1, type="l", 
              xlab="", ylab="Energy sub metering"))

with(DN,lines(DateTime,Sub_metering_2, col="red"))
with(DN,lines(DateTime,Sub_metering_3, col="blue"))

## legend on this plot doesnot have a box line
##? bty, box.lty
legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty=1, bty = "n")
      
##plot top right
with(DN,plot(DateTime,Voltage,  type="l",  xlab="datetime", ylab="Voltage"))
##plot bottom right
with(DN, plot(DateTime, Global_reactive_power,type="l", 
              xlab="datetime", ylab="Global_reactive_Power"))

# Turn off png graphic device
dev.off()