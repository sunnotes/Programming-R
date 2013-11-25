###数据准备

library(ggplot2)
library("party")
#install.packages("party")
install.packages("rpart")
library("rpart")

load(file ='kuaibao/data/messages.RData')
dim(messages)
head(messages)


load(file ='kuaibao/data/users.RData')

dim(users)
head(users)



#每日新增关注人数
newuser <- aggregate(users[,1],list(users$subscribeday),length)
colnames(newuser) <-c('date','usercnt')
newuser$date <- as.Date(newuser$date)
head(newuser)
mode(newuser$date)
ggplot(newuser, aes(date, usercnt)) + geom_line(color='#009E73') + 
  geom_point(color='#009E73') + 
  geom_smooth(method = "loess",color='#D55E00') + 
  scale_x_date() + xlab("日期") + 
  ylab("每日新增关注人数")

#每日消息数
mode(messages$msgtime)
as.Date(messages$msgtime)
msgdaily <- aggregate(messages[,1],list(as.Date(messages$msgtime)),length)
colnames(msgdaily) <-c('date','msgcnt')
newuser$date <- as.Date(newuser$date)
head(msgdaily)
ggplot(msgdaily, aes(date, msgcnt)) + geom_line(color='#009E73') + 
  geom_point(color='#009E73') + 
  geom_smooth(method = "loess",color='#D55E00') + 
  scale_x_date() + xlab("日期") + 
  ylab("每日消息数")



plot(newuser)


#近期有消息的人数
nrow(users[users$Totaldaycnt!=0,])
nrow(users[users$D60daycnt!=0,])
nrow(users[users$D30daycnt!=0,])
nrow(users[users$D15daycnt!=0,])
nrow(users[users$D7daycnt!=0,])



D30day <-users[users$D30daycnt!=0,]
D15day <-users[users$D15daycnt!=0,]
D7day <-users[users$D7daycnt!=0,]


summary(D30day)
qplot(D30daycnt, data = D30day, geom = "histogram", binwidth = 0.5,
      xlim = c(0,30))
qplot(D15daycnt, data = D15day, geom = "histogram", binwidth = 0.5,
      xlim = c(0,15))
qplot(D7daycnt, data = D7day, geom = "histogram", binwidth = 0.5,
      xlim = c(0,7))

nrow(users[which(users$D30daycnt >10 ),])
nrow(users[which(users$D15daycnt >5 ),])
nrow(users[which(users$D7daycnt >5 ),])


##取子集
subuser <- users[which(users$D30daycnt !=0 ),-2]
head(subuser)

#决策树1
users_ctree <- ctree(userid ~ ., data=subuser)
print(users_ctree)
plot(users_ctree)

#决策树2
users_rpart <- rpart(userid ~ ., data=subuser,minsplit = 500, maxdepth=40)
print(users_rpart)
plot(users_rpart)
text(users_rpart)



km <- kmeans(scale(subuser),5)
km$cluster
km$size

users[which(km$cluster == 1),]
users[which(km$cluster == 2),]



plotusers$userid <- as.factor(users$userid)
nlevels(users$userid)

mode(users$subscribeday)

plot(data=users[users$D15daycnt!=0,],x=users$D15daycnt,y=scale(users$D15msgcnt))



D15day <-users[users$D15daycnt!=0,]$D15daycnt
dim(D15day)
summary(D15day)
var(D15day)

histogram(D15day)