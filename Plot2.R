## Assignment: Course Project 1
## Plot2.R


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
names(DN) <-  c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")

## check to see if only the 1/2/2007 and 2/2/2007 got subsetted
table(DN$Date)

## Assignment asking to use 'strptime()' function to format Data and Time
##You may find it useful to convert the Date and Time variables to Date/Time classes
## in R using the strptime()  and as.Date() functions.
## Combine the Date and Time in one column and format 
## ?strptime
DN$DateTime <- strptime(paste(DN$Date, DN$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

## Open png graphic device
png("plot2.png", width=480, height=480)

## create plot using plot base function
## type "l" for lines, color black default
## y-axis label "Global Active Power (kilowatts)"
## No x-axis label
with (DN, plot (DateTime,Global_active_power, type = "l",xlab = "", ylab = "Global Active Power (kilowatts)"))
      
##Turn off png graphic device
dev.off()
