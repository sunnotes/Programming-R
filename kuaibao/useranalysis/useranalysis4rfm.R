###数据准备

library(ggplot2)
library("party")
#install.packages("party")
install.packages("rpart")
library("rpart")


load(file ='kuaibao/data/users4rfm.RData')
dim(users)
head(users)

#RFM

subuser <- users[!is.na(users$recency),c('userid','subscribeday','recency','D30msgcnt','D30daycnt')]


users[!is.na(users$recency),]




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

histogram(D15day)