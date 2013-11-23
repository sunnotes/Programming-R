###数据准备



load(file ='kuaibao/data/messages.RData')
dim(messages)
head(messages)


load(file ='kuaibao/data/users.RData')
dim(users)
head(users)

plotusers$userid <- as.factor(users$userid)
nlevels(users$userid)

mode(users$subscribeday)

plot(x=users$Totaldaycnt,y=scale(users$Totalmsgcnt))