

#This file write for statistic and analysis data of Kuaibao

#install.packages("ggplot2")
library(ggplot2)
library(timeDate)
load(file ='kuaibao/kuaibao.RData')

# The palette with grey:
cbPalette <- c("#999999", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# To use for fills, add
scale_fill_manual(values=cbPalette)

# To use for line and point colors, add
scale_colour_manual(values=cbPalette)


opar <- par(no.readonly = TRUE)
par(mfrow=c(2,3))
par(opar)

###############fund statistics


#每日收益分析
summary(kuaibao.fund$profit)
mean(kuaibao.fund$profit)
sd(kuaibao.fund$profit)

#每日收益统计

#散点图
ggplot(kuaibao.fund,aes(x=day,y=profit))+
  geom_point(color='#009E73')+
  geom_smooth(color='#D55E00')

#箱须图
ggplot(kuaibao.fund,aes(x=day,y=profit))+
  geom_point(color='#009E73')+
  geom_boxplot(colour = "#56B4E9",alpha=.1)

#直方图
ggplot(kuaibao.fund, aes(x=profit)) + 
  geom_histogram(aes(y=..count..),      # Histogram with density instead of count on y-axis
                 binwidth=.02,
                 colour="black", fill="white") +
  geom_density(alpha=.2, fill="#FF6666") 



###########follower data analysis
##

head(kuaibao.user)
summary(kuaibao.user)

#每日新增的用户

ggplot(data=df, aes(x=time, y=total_bill, group=1)) + 
  geom_line(colour="red", linetype="dotted", size=1.5) + 
  geom_point(colour="red", size=4, shape=21, fill="white")

ggplot(kuaibao.user,aes(day,newuser))+
  geom_point(colour="#009E73")+
  geom_line(colour="#009E73", linetype="dotted", size=1)


#每日关注用户数
head(kuaibao.user$subscribe)
scale.subscrible<-scale(kuaibao.user$subscribe)
scale.profit<-scale(kuaibao.fund$profit)

ggplot()+ 
geom_point(aes(kuaibao.user$day,scale.subscrible),colour="#009E73")+
  geom_line(aes(kuaibao.user$day,scale.subscrible),colour="#009E73", linetype="dotted", size=1)+
  
ggplot(kuaibao.user)+  
  geom_point(aes(kuaibao.user$day,scale.profit),colour="#FF9999")+
  geom_line(aes(kuaibao.user$day,scale.profit),colour="#FF9999", linetype="dotted", size=1) 

summary(kuaibao.user$newuser)
mean(kuaibao.user$newuser)
sd(kuaibao.user$newuser)

p <- ggplot(kuaibao.user, aes(x=newuser)) +  
  geom_histogram(aes(y = ..density..),binwidth = 10)+
  geom_density()
print(p)

#每日取消关注用户
summary(kuaibao.user$unfollower)
mean(kuaibao.user$unfollower)
sd(kuaibao.user$unfollower)

p <- ggplot(kuaibao.user, aes(x=unfollower)) +  
  geom_histogram(aes(y = ..density..),binwidth = 0.5)+
  geom_density()
print(p)


#新增用户

p <- ggplot(data=kuaibao.user)+
  geom_point(aes(day,newfollower),colour = "green")+geom_line(aes(day,newfollower),color=I('GRAY'))+
  geom_point(aes(day,unfollower),colour = "red") +geom_line(aes(day,unfollower),color=I('GRAY'))
p + geom_rect(data = kuaibao.user,aes(xmin = day, xmax =day+1 ,fill = isWeekend(day)),
            ymin = min(kuaibao.user$unfollower), ymax =max(kuaibao.user$newfollower),alpha=0.1)


isWeekend(kuaibao.user$day)

#用户性别
cnt<-c(3164,1514,199);
gen=c("MALE","FEMALE","UNKOWN")
pct=round(cnt/sum(cnt)*100)
lab = paste(gen,' ',pct,'%')
kuaibao.user.gender = data.frame(pct,gen,lab);

ggplot(kuaibao.user.gender, aes(x = "" ,y = pct, fill = gen)) +  
  geom_bar(width = 3)  + 
  coord_polar("y")+ 
  xlab('') + ylab('') + 
  labs(fill="gender")


###########message data analysis

head(kuaibao.messages)
dim(kuaibao.messages)
summary(kuaibao.messages)

#每天发送的消息数
ggplot(kuaibao.messages,aes(day))+
  geom_bar(binwidth =.5,position = "stack")+
  geom_rect(data = kuaibao.user,aes(xmin = day, xmax =day+1 ,fill = isWeekend(day)),
            ymin = 0, ymax =2500,alpha=0.1)+
  geom_density() 

#消息分类
ggplot(kuaibao.messages,aes(day))+
  geom_bar(binwidth = 0.5,position = "stack")+
  facet_grid(type_detail ~ .)


#消息按发送时间

ggplot(kuaibao.messages,aes(day,hour),alpha = 0.001)+
  geom_point(stat = "identity", position = "jitter",color=I("green"))+
  scale_fill_gradient("Count", low = "green", high = "red")
 
qplot(day,hour,data=kuaibao.messages,alpha = 0.001,geom='jitter',color=type_detail)


table(kuaibao.messages$day,kuaibao.messages$hour,kuaibao.messages$type_detail)

kuaibao.messages2 <- kuaibao.messages[kuaibao.messages$type_detail== 'query'||kuaibao.messages$type_detail== 'compute',]
dim(kuaibao.messages2)


kuaibao.messages3 <- kuaibao.messages[kuaibao.messages$type_detail== 'query',]
dim(kuaibao.messages3)





#数据挖掘



ggplot()+
  geom_point(data=kuaibao.user,aes(day,subscribe),colour = "green")+
  geom_line(data=kuaibao.user,aes(day,subscribe),color=I('GRAY'))+
  geom_point(data=kuaibao.fund,aes(day,profit*100),colour = "red") +
  geom_line(data=kuaibao.fund,aes(day,profit*100),color=I('GRAY'))

geom_rect(data = kuaibao.user,aes(xmin = day, xmax =day+1 ,fill = isWeekend(day)),
              ymin = min(kuaibao.user$unsubscribe), ymax =max(kuaibao.user$subscribe),alpha=0.1) + 
  geom_rect(data = kuaibao.user,aes(xmin = day, xmax =day+1 ,fill = isWeekend(day)),
              ymin = min(kuaibao.user$unsubscribe), ymax =max(kuaibao.user$subscribe),alpha=0.1)






