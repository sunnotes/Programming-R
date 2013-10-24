kings <- scan("http://robjhyndman.com/tsdldata/misc/kings.dat",skip=3)
kings
kingstimeseries <- ts(kings)
kingstimeseries

births <- scan("http://robjhyndman.com/tsdldata/data/nybirths.dat")
birthstimeseries <- ts(births, frequency=12, start=c(1946,1))
birthstimeseries

souvenir <- scan("http://robjhyndman.com/tsdldata/data/fancy.dat")
souvenirtimeseries <- ts(souvenir, frequency=12, start=c(1987,1))
souvenirtimeseries

plot.ts(kingstimeseries)
plot.ts(birthstimeseries) 
plot.ts(souvenirtimeseries)


library("TTR")

kingstimeseriesSMA3 <- SMA(kingstimeseries,n=3)
plot.ts(kingstimeseriesSMA3)

kingstimeseriesSMA8 <- SMA(kingstimeseries,n=8)
plot.ts(kingstimeseriesSMA8)

birthstimeseriescomponents <- decompose(birthstimeseries)
birthstimeseriescomponents$seasonal
plot(birthstimeseriescomponents)

birthstimeseriescomponents <- decompose(birthstimeseries) 
birthstimeseriesseasonallyadjusted <- birthstimeseries - birthstimeseriescomponents$seasonal
plot(birthstimeseriesseasonallyadjusted)


rain <- scan("http://robjhyndman.com/tsdldata/hurst/precip1.dat",skip=1)
rainseries <- ts(rain,start=c(1813))
plot.ts(rainseries)
rainseriesforecasts <- HoltWinters(rainseries, beta=FALSE, gamma= FALSE)
rainseriesforecasts
rainseriesforecasts$fitted

plot(rainseriesforecasts) 
rainseriesforecasts$SSE

HoltWinters(rainseries, beta=FALSE, gamma=FALSE, l.start=23.56)  
library("forecast")



rainseriesforecasts2 <- forecast.HoltWinters(rainseriesforecasts, h=8)
rainseriesforecasts2
plot.forecast(rainseriesforecasts2)


acf(rainseriesforecasts2$residuals, lag.max=20)  
Box.test(rainseriesforecasts2$residuals, lag=20, type="Ljung-Box")
plot.ts(rainseriesforecasts2$residuals) 



plotForecastErrors <- function(forecasterrors)
{
  # make a red histogram of the forecast errors:
  mybinsize <- IQR(forecasterrors)/4
  mysd    <- sd(forecasterrors)
  mymin   <- min(forecasterrors) + mysd*5
  mymax   <- max(forecasterrors) + mysd*3
  mybins <- seq(mymin, mymax, mybinsize)
  hist(forecasterrors, col="red", freq=FALSE, breaks=mybins)
  # freq=FALSE ensures the area under the histogram = 1  
  # generate normally distributed data with mean 0 and standard deviation mysd
  mynorm <- rnorm(10000, mean=0, sd=mysd)
  myhist <- hist(mynorm, plot=FALSE, breaks=mybins)
  # plot the normal curve as a blue line on top of the histogram of forecast errors:
  points(myhist$mids, myhist$density, type="l", col="blue", lwd=2)
}

plotForecastErrors(rainseriesforecasts2$residuals)



skirts <- scan("http://robjhyndman.com/tsdldata/roberts/skirts.dat",skip=5)
skirtsseries <- ts(skirts,start=c(1866))
plot.ts(skirtsseries) 

skirtsseriesforecasts <- HoltWinters(skirtsseries, gamma=FALSE)
skirtsseriesforecasts
plot(skirtsseriesforecasts)

HoltWinters(skirtsseries, gamma=FALSE, l.start=608, b.start=9)
skirtsseriesforecasts2 <- forecast.HoltWinters(skirtsseriesforecasts, h=19)
plot.forecast(skirtsseriesforecasts2)

acf(skirtsseriesforecasts2$residuals, lag.max=20)
Box.test(skirtsseriesforecasts2$residuals, lag=20, type="Ljung-Box")

plot.ts(skirtsseriesforecasts2$residuals)    
plotForecastErrors(skirtsseriesforecasts2$residuals) 


logsouvenirtimeseries <- log(souvenirtimeseries)
souvenirtimeseriesforecasts <- HoltWinters(logsouvenirtimeseries) 
souvenirtimeseriesforecasts

souvenirtimeseriesforecasts$SSE
plot(souvenirtimeseriesforecasts)

souvenirtimeseriesforecasts2 <- forecast.HoltWinters(souvenirtimeseriesforecasts, h=48)
plot.forecast(souvenirtimeseriesforecasts2)

acf(souvenirtimeseriesforecasts2$residuals, lag.max=20)
Box.test(souvenirtimeseriesforecasts2$residuals, lag=20, type="Ljung-Box")


plot.ts(souvenirtimeseriesforecasts2$residuals)             # make a time plot
plotForecastErrors(souvenirtimeseriesforecasts2$residuals)  # make a histogram


skirtsseriesdiff1 <- diff(skirtsseries, differences=1)
plot.ts(skirtsseriesdiff1)

skirtsseriesdiff2 <- diff(skirtsseries, differences=2)
plot.ts(skirtsseriesdiff2) 



kingtimeseriesdiff1 <- diff(kingstimeseries, differences=1)
plot.ts(kingtimeseriesdiff1) 


acf(kingtimeseriesdiff1, lag.max=20)  
acf(kingtimeseriesdiff1, lag.max=20, plot= FALSE)# get the autocorrelation values


pacf(kingtimeseriesdiff1, lag.max=20)              # plot a partial correlogram
pacf(kingtimeseriesdiff1, lag.max=20, plot=FALSE) # get the partial autocorrelation values



volcanodust <- scan("http://robjhyndman.com/tsdldata/annual/dvi.dat", skip=1)
volcanodustseries <- ts(volcanodust,start=c(1500))
plot.ts(volcanodustseries) 

acf(volcanodustseries, lag.max=20)              # plot a correlogram
acf(volcanodustseries, lag.max=20, plot= FALSE) # get the values of the autocorrelations


pacf(volcanodustseries, lag.max=20)
pacf(volcanodustseries, lag.max=20, plot=FALSE)


kingstimeseriesarima <- arima(kingstimeseries, order=c(0,1,1))  # fit an ARIMA(0,1,1) model
kingstimeseriesarima



library("forecast") # load the "forecast" R library
kingstimeseriesforecasts <- forecast.Arima(kingstimeseriesarima, h=5)
kingstimeseriesforecasts

plot.forecast(kingstimeseriesforecasts)


acf(kingstimeseriesforecasts$residuals, lag.max=20)
Box.test(kingstimeseriesforecasts$residuals, lag=20, type="Ljung-Box")

plot.ts(kingstimeseriesforecasts$residuals)             # make time plot of forecast errors
plotForecastErrors(kingstimeseriesforecasts$residuals)  # make a histogram 

volcanodustseriesarima <- arima(volcanodustseries, order=c(2 ,0,0))
volcanodustseriesarima


volcanodustseriesforecasts <- forecast.Arima(volcanodustseriesarima, h=31)
volcanodustseriesforecasts

plot.forecast(volcanodustseriesforecasts)

acf(volcanodustseriesforecasts$residuals, lag.max=20)
Box.test(volcanodustseriesforecasts$residuals, lag=20, typ e="Ljung-Box")


plot.ts(volcanodustseriesforecasts$residuals)             # make time plot of forecast errors 
plotForecastErrors(volcanodustseriesforecasts$residuals)  # make a histogram

mean(volcanodustseriesforecasts$residuals)