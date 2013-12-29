###数据准备



load(file ='kuaibao/data/users.RData')
dim(users)
head(users)

#RFM

subusers <- users[!is.na(users$lastday),c('userid','subscribeday','D30msgcnt','D30daycnt')]

subusers <- subset(users,!(is.na(lastday)|is.na(subscribeday)),
                           select=c('userid','subscribeday','D30msgcnt','D30daycnt'))

dim(subusers)
head(subusers)

usersR <- round(as.numeric(difftime('2013-11-23',subusers[,2],units="days")) )
usersF <- subusers$D30daycnt;
usersM <- subusers$D30msgcnt;

##Merging R,F,M
usersRFM <- as.data.frame(cbind(subusers$userid,usersR,usersF,usersM))
usersRFM[is.na(usersRFM)] <- 0
colnames(usersRFM) <- c('Userid','Recency','Frequency','Monetization')


dim(usersRFM)
head(usersRFM)

#str(usersRFM)


##Creating R,F,M levels 

#通过KM对各个维度进行分类


km1 <-  kmeans(scale(usersRFM$Recency),3)
km2 <-  kmeans(scale(usersRFM$Frequency),3)
km3 <-  kmeans(scale(usersRFM$Monetization),3)

#查看各个分类的区间
range(usersRFM[which(km1$cluster == 1),'Recency'])
range(usersRFM[which(km1$cluster == 2),'Recency'])
range(usersRFM[which(km1$cluster == 3),'Recency'])

#为各分区赋值
usersRFM$rankR <-0
usersRFM[which(km1$cluster == 1),]$rankR <- 'HIGH'
usersRFM[which(km1$cluster == 2),]$rankR <- 'LOW'
usersRFM[which(km1$cluster == 3),]$rankR <- 'MEDIUM'

#查看各个分类的区间
range(usersRFM[which(km2$cluster == 1),'Frequency'])
range(usersRFM[which(km2$cluster == 2),'Frequency'])
range(usersRFM[which(km2$cluster == 3),'Frequency'])

#为各分区赋值
usersRFM$rankF <-0
usersRFM[which(km2$cluster == 1),]$rankF <- 'LOW'
usersRFM[which(km2$cluster == 2),]$rankF <- 'MEDIUM'
usersRFM[which(km2$cluster == 3),]$rankF <- 'HIGH'

# 查看各个分类的区间
range(usersRFM[which(km3$cluster == 1),'Monetization'])
range(usersRFM[which(km3$cluster == 2),'Monetization'])
range(usersRFM[which(km3$cluster == 3),'Monetization'])

#为各分区赋值
usersRFM$rankM <-0
usersRFM[which(km3$cluster == 1),]$rankM <- 'MEDIUM'
usersRFM[which(km3$cluster == 2),]$rankM <- 'LOW'
usersRFM[which(km3$cluster == 3),]$rankM <- 'HIGH'

#抽取结果
head(usersRFM)
