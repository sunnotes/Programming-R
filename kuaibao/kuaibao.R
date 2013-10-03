

#This file write for statistic and analysis data of Kuaibao

#install.packages("ggplot2")
library(ggplot2)
load(file ='kuaibao/kuaibao.RData')

opar <- par(no.readonly = TRUE)
par(mfrow=c(2,3))
par(opar)

#fund statistics


#每日收益分析
summary(kuaibao.fund$profit)
mean(kuaibao.fund$profit)
sd(kuaibao.fund$profit)
p <- ggplot(kuaibao.fund,aes(x=date,y=profit))+
  geom_point(colour = "green")+
  geom_boxplot(colour = "green",alpha = 0.1)+
  geom_smooth()
print(p)  

p <- ggplot(kuaibao.fund, aes(x=profit),) +  
  geom_histogram(binwidth = 0.01)+
  geom_density()
print(p)


###########follower data analysis
##

head(kuaibao.follower)
summary(kuaibao.follower)

#每日新增的用户
p<- ggplot(kuaibao.follower,aes(day,increasedfollower))+
  geom_line()
p

summary(kuaibao.follower$increasedfollower)
mean(kuaibao.follower$increasedfollower)
sd(kuaibao.follower$increasedfollower)

p <- ggplot(kuaibao.follower, aes(x=increasedfollower)) +  
  geom_histogram(aes(y = ..density..),binwidth = 10)+
  geom_density()
print(p)

#每日取消关注用户
summary(kuaibao.follower$unfollower)
mean(kuaibao.follower$unfollower)
sd(kuaibao.follower$unfollower)

p <- ggplot(kuaibao.follower, aes(x=unfollower)) +  
  geom_histogram(aes(y = ..density..),binwidth = 0.5)+
  geom_density()
print(p)


#新增用户

p <- ggplot(data=kuaibao.follower)+
  geom_point(aes(day,newfollower),colour = "green")+geom_line(aes(day,newfollower),color=I('GRAY'))+
  geom_point(aes(day,unfollower),colour = "red") +geom_line(aes(day,unfollower),color=I('GRAY'))
p + geom_rect(data = kuaibao.follower,aes(xmin = day, xmax =day+1 ,fill = isWeekend(day)),
            ymin = min(kuaibao.follower$unfollower), ymax =max(kuaibao.follower$newfollower),alpha=0.1)


isWeekend(kuaibao.follower$day)

#用户性别
cnt<-c(3164,1514,199);
gen<-c('man','woman','unkown')
kuaibao.follower.gender = data.frame(gen,cnt);
pct=round(cnt/sum(cnt)*100)
lab = paste(gen,' ',pct,'%')
pie(cnt,labels=lab,main="gender")

###########message data analysis

head(kuaibao.messages)
summary(kuaibao.messages)

#每天发送的消息数

p<- ggplot(kuaibao.messages,aes(day))+
  geom_bar(binwidth =0.5,position = "stack")+
  geom_rect(data = kuaibao.follower,aes(xmin = day, xmax =day+1 ,fill = isWeekend(day)),
            ymin = 0, ymax =2500,alpha=0.1)
p

#消息分类
p<- ggplot(kuaibao.messages,aes(day))+
  geom_bar(binwidth = 0.5,position = "stack")+
  facet_grid(type_detail ~ .)
p

#消息按发送时间

p<-ggplot(kuaibao.messages,aes(day,hour),alpha = 0.001)+
  geom_point(stat = "identity", position = "jitter",color=I("green"))+
  scale_fill_gradient("Count", low = "green", high = "red")
p  
qplot(day,hour,data=kuaibao.messages,alpha = 0.001,geom='jitter',color=type_detail)


table(kuaibao.messages$day,kuaibao.messages$hour,kuaibao.messages$type_detail)

kuaibao.messages2 <- kuaibao.messages[kuaibao.messages$type_detail== 'query'||kuaibao.messages$type_detail== 'compute',]
dim(kuaibao.messages2)


kuaibao.messages3 <- kuaibao.messages[kuaibao.messages$type_detail== 'query',]
dim(kuaibao.messages3)



#数据挖掘



p <- ggplot()+
  geom_point(data=kuaibao.follower,aes(day,newfollower),colour = "green")+
  geom_line(data=kuaibao.follower,aes(day,newfollower),color=I('GRAY'))+
  geom_point(data=kuaibao.fund,aes(date,profit*100),colour = "red") +
  geom_line(data=kuaibao.fund,aes(date,profit*100),color=I('GRAY'))
p + geom_rect(data = kuaibao.follower,aes(xmin = day, xmax =day+1 ,fill = isWeekend(day)),
              ymin = min(kuaibao.follower$unfollower), ymax =max(kuaibao.follower$newfollower),alpha=0.1)






