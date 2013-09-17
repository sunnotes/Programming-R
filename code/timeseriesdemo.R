kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
kings
              
kingstimeseries <- ts(kings)
kingstimeseries
              
plot.ts(kingstimeseries)  
              
dates <- Sys.Date()-c(42:1)
dates <-as.Date(dates)
dates

timeSeries(dates,kingstimeseries) 