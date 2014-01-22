#作业1

#init
oldwd <- getwd()
setwd('/mnt/hgfs/WorkSpaces/Programming-R/Coursera/Computing_for_Data_Analysis/Week_1')
getwd()

data<-read.csv("hw1_data.csv",header = TRUE)

head(data)

dim(data)

tail(data)

class(data)

data[47,]$Ozone

length(which(is.na(data$Ozone)))

mean(data$Ozone,na.rm=TRUE)

mean(data[which(data$Ozone >31 & data$Temp > 90),]$Solar.R ,na.rm=TRUE)


mean(data[which(data$Month == 6) ,]$Temp ,na.rm=TRUE)


max(data[which(data$Month == 5) ,]$Ozone ,na.rm=TRUE)
