install.packages('openair')
library('openair')
library(reshape2)

head(airquality)


head(melt(airquality, id=c("month", "day")))