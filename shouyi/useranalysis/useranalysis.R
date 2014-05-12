###数据准备

library(ggplot2)
library(party)
#install.packages("party")
install.packages("rpart")
install.packages("lubridate")
library("rpart")
library("lubridate")


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
nrow(users[which(users$D15daycnt >7 ),])
nrow(users[which(users$D7daycnt >4 ),])



#决策树1
users_ctree <- ctree(userid ~ ., data=subuser)
print(users_ctree)
plot(users_ctree)



#决策树2
users_rpart <- rpart(userid ~ ., data=users[,-2],minsplit = 1000,cp = 0.01)
print(users_rpart)
printcp(users_rpart)

subuser <- users[which(users$D30daycnt >=3 ),-2]
dim(subuser)

users_rpart10 <- rpart(userid ~ ., data=users[which(users$D30daycnt >=3),-2],minsplit = 100,cp = 0.001)
print(users_rpart10)
printcp(users_rpart10)


#修剪
users_rpart101 <- prune(users_rpart10,cp =0.0002)
users_rpart101
plot(users_rpart101)
text(users_rpart101)





users_rpart11 <- rpart(userid ~ ., data=subuser,minsplit = 100,cp = 0.0001)
print(users_rpart11)
printcp(users_rpart11)


users_rpart1 <- rpart(userid ~ Totaldaycnt+Totalmsgcnt, data=subuser,minsplit = 500)
print(users_rpart1)

users_rpart2 <- rpart(userid ~ D60msgcnt + D60daycnt , data=subuser,minsplit = 500)
print(users_rpart2)

users_rpart3 <- rpart(userid ~ D30msgcnt + D30daycnt , data=subuser,minsplit = 500)
print(users_rpart3)

users_rpart4 <- rpart(userid ~ D15msgcnt + D15daycnt , data=subuser)
print(users_rpart4)

users_rpart5 <- rpart(userid ~ D7msgcnt + D7daycnt , data=subuser)
print(users_rpart5)

users_rpart6 <- rpart(userid ~ Totaldaycnt+D30daycnt+D15daycnt+D7daycnt, data=subuser,minsplit = 500)
print(users_rpart6)

subuser2 <- users[which(users$D30daycnt  >= 3 & users$Totaldaycnt >= 3 ),-2]
dim(subuser2)

users_rpart7 <- rpart(userid ~ Totaldaycnt+D30daycnt+D15daycnt+D7daycnt, data=subuser2,minsplit = 100)
print(users_rpart7)

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
