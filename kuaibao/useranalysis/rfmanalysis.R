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
usersRFM[12000:13000,]

str(usersRFM)


##Creating R,F,M levels 


#usersRFM$rankR=cut(usersRFM$Recency, 3,labels=F) #rankR 1 is very recent while rankR 3 is least recent

#usersRFM$rankF=cut(usersRFM$Frequency, 3,labels=F)#rankF 1 is least frequent while rankF 3 is most frequent

#usersRFM$rankM=cut(usersRFM$Monetization, 3,labels=F)#rankM 1 is lowest sales while rankM 3 is highest sales

#usersRFM$rankR=km1$cluster
#usersRFM$rankF=km2$cluster
#usersRFM$rankM=km3$cluster

#

km1 <-  kmeans(scale(usersRFM$Recency),3)
km2 <-  kmeans(scale(usersRFM$Frequency),3)
km3 <-  kmeans(scale(usersRFM$Monetization),3)

range(usersRFM[which(km1$cluster == 1),'Recency'])
range(usersRFM[which(km1$cluster == 2),'Recency'])
range(usersRFM[which(km1$cluster == 3),'Recency'])

usersRFM[which(km1$cluster == 1),]$rankR <- 'HIGH'
usersRFM[which(km1$cluster == 2),]$rankR <- 'LOW'
usersRFM[which(km1$cluster == 3),]$rankR <- 'MEDIUM'

#
range(usersRFM[which(km2$cluster == 1),'Frequency'])
range(usersRFM[which(km2$cluster == 2),'Frequency'])
range(usersRFM[which(km2$cluster == 3),'Frequency'])

usersRFM[which(km2$cluster == 1),]$rankF <- 'LOW'
usersRFM[which(km2$cluster == 2),]$rankF <- 'MEDIUM'
usersRFM[which(km2$cluster == 3),]$rankF <- 'HIGH'

#
range(usersRFM[which(km3$cluster == 1),'Monetization'])
range(usersRFM[which(km3$cluster == 2),'Monetization'])
range(usersRFM[which(km3$cluster == 3),'Monetization'])

usersRFM[which(km3$cluster == 1),]$rankM <- 'MEDIUM'
usersRFM[which(km3$cluster == 2),]$rankM <- 'LOW'
usersRFM[which(km3$cluster == 3),]$rankM <- 'HIGH'


##Looking at RFM tables
table(usersRFM[,5:7])