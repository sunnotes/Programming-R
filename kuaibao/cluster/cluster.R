###数据准备

library(ggplot2)

load(file ='kuaibao/data/messages.RData')
dim(messages)
head(messages)


load(file ='kuaibao/data/users.RData')
dim(users)
head(users)

#近期有消息的认识
nrow(users[users$Totaldaycnt!=0,])
nrow(users[users$D60daycnt!=0,])
nrow(users[users$D30daycnt!=0,])
nrow(users[users$D15daycnt!=0,])
nrow(users[users$D7daycnt!=0,])



D30day <-users[users$D30daycnt!=0,]
D15day <-users[users$D15daycnt!=0,]
D7day <-users[users$D7daycnt!=0,]


qplot(D30daycnt, data = D30day, geom = "histogram", binwidth = 0.5,
      xlim = c(0,30))

qplot(D15daycnt, data = D15day, geom = "histogram", binwidth = 0.5,
      xlim = c(0,15))

qplot(D7daycnt, data = D7day, geom = "histogram", binwidth = 0.5,
      xlim = c(0,7))

nrow(users[which(users$D30daycnt >10 ),])


nrow(users[which(users$D15daycnt >5 ),])


nrow(users[which(users$D7daycnt >5 ),])





subuser <- users[which(users$D30daycnt !=0 ),3:12]

dim(subuser)
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