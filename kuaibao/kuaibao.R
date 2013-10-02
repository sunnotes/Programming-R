

#This file write for statistic and analysis data of Kuaibao

#install.packages("ggplot2")
library(ggplot2)
load(file ='kuaibao/kuaibao.RData')


opar <- par(no.readonly = TRUE)
par(mfrow=c(2,3))
par(opar)

#fund statistics
plot(kuaibao.fund$date, kuaibao.fund$profit,type='b')

p <- ggplot(kuaibao.fund,aes(x=date,y=rate))+
  geom_point(colour = "red")+
  geom_smooth()
print(p)  

p <- ggplot(kuaibao.fund,aes(x=date,y=profit))+
  geom_point(colour = "green")+
  geom_smooth()
print(p) 

p <- ggplot(kuaibao.fund,aes(x=date,y=profit))+
  geom_boxplot(colour = "green")
print(p) 


###########follower data analysis
##

head(kuaibao.follower)
summary(kuaibao.follower)


p <- ggplot()+
  geom_point(data=kuaibao.follower,mapping=aes(x=kuaibao.follower$day,y=kuaibao.follower$newfollower),colour = "green")+
  geom_point(data=kuaibao.follower,mapping=aes(x=kuaibao.follower$day,y=kuaibao.follower$increasedfollower),colour = "red") 
print(p)  


###########message data analysis

head(kuaibao.messages)
class(kuaibao.messages$msgtime)
summary(kuaibao.messages$day)

p<- ggplot(kuaibao.messages,aes(day))+
  geom_bar(binwidth = 0.5,position = "stack")+
  facet_grid(type_detail ~ .)
p
p<- ggplot(kuaibao.messages,aes(day))+
  geom_bar(binwidth = 0.5,position = "stack")
p


kuaibao.messages2 <- kuaibao.messages[kuaibao.messages$type_detail== 'query'||kuaibao.messages$type_detail== 'compute',]
dim(kuaibao.messages2)


kuaibao.messages3 <- kuaibao.messages[kuaibao.messages$type_detail== 'query',]
dim(kuaibao.messages3)

qplot(day,hour,data=kuaibao.messages,facet=factor(type_detail)~.,alpha = 0.01,geom='jitter')


table(kuaibao.messages$day,kuaibao.messages$hour,kuaibao.messages$type_detail)







z <- Sys.time()
unclass(z)$hour
mode(z)
class(z)
months(z)
