install.packages("xts")
library(xts)
library(zoo)

data(sample_matrix)
head(sample_matrix)


sample.xts <- as.xts(sample_matrix, descr='my new xts object')
class(sample.xts)

str(sample.xts)

attr(sample.xts,'descr')

head(sample.xts['2007'])

head(sample.xts['2007-03/'])

head(sample.xts['2007-03-06/2007'])

sample.xts['2007-01-03']


data(sample_matrix)
plot(sample_matrix)
plot(as.xts(sample_matrix))

plot(as.xts(sample_matrix), type='candles')

firstof(2000)

firstof(2005,01,01)

lastof(2007)

lastof(2007,10)

.parseISO8601('2000')

.parseISO8601('2000-05/2001-02')

.parseISO8601('2000-01/02')

.parseISO8601('T08:30/T15:00')

#取索引类型
x <- timeBasedSeq('2010-01-01/2010-01-02 12:00')
x <- xts(1:length(x), x)

head(x)

indexClass(x)

#索引时间格式化

indexFormat(x) <- "%Y-%b-%d %H:%M:%OS3"
head(x)
#取索引时间

.indexhour(head(x))

.indexmin(head(x))



#xts数据处理
#数据对齐
 x <- Sys.time() + 1:30
align.time(x, 10)
#整60秒对齐
align.time(x, 60)

#按时间分割数据，并计算
xts.ts <- xts(rnorm(231),as.Date(13514:13744,origin="1970-01-01"))
apply.monthly(xts.ts,mean)

apply.monthly(xts.ts,function(x) var(x))

apply.quarterly(xts.ts,mean)

apply.yearly(xts.ts,mean)