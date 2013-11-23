#connect data

library(RODBC)
conn <- odbcConnect('kuaibao')



###########messages data analysis
messages <- sqlQuery(conn,'
   SELECT  userid,msgtime ,msg_type,type_detail,content
  FROM message WHERE msgtime IS NOT  NULL AND msgtime  ORDER BY msgtime  ',nullstring = NA_character_, na.strings = "NA")
dim(messages)
head(messages)


save(messages,file ='kuaibao/data/messages.RData')


user1 <- sqlQuery(conn,' SELECT id as userid ,date(subscribe_time) as subscribeday
  FROM USER ORDER BY subscribe_time  ',nullstring = NA_character_, na.strings = "NA")
dim(user1)
head(user1)


##所有
Total <- sqlQuery(conn,' 
SELECT  userid, COUNT(*) AS Totalmsgcnt ,  COUNT(DISTINCT(DATE(msgtime))) AS Totaldaycnt  FROM message WHERE DATE(msgtime) >= \'2013-07-23\' AND userid <>0   GROUP BY userid   ORDER BY userid  ',nullstring = NA_character_, na.strings = "NA")
dim(Total)
head(Total)



##近60天
D60 <- sqlQuery(conn,' 
SELECT  userid, COUNT(*) AS D60msgcnt ,  COUNT(DISTINCT(DATE(msgtime))) AS D60daycnt  FROM message WHERE DATE(msgtime) >= \'2013-09-23\' AND userid <>0   GROUP BY userid   ORDER BY userid  ',nullstring = NA_character_, na.strings = "NA")
dim(D60)
head(D60)



##近30天
D30 <- sqlQuery(conn,' 
SELECT  userid, COUNT(*) AS D30msgcnt ,  COUNT(DISTINCT(DATE(msgtime))) AS D30daycnt  FROM message WHERE DATE(msgtime) >= \'2013-10-23\' AND userid <>0   GROUP BY userid   ORDER BY userid ',nullstring = NA_character_, na.strings = "NA")
dim(D30)
head(D30)



##近15天
D15 <- sqlQuery(conn,' 
SELECT  userid, COUNT(*) AS D15msgcnt ,  COUNT(DISTINCT(DATE(msgtime))) AS D15daycnt  FROM message WHERE DATE(msgtime) >= \'2013-11-08\' AND userid <>0   GROUP BY userid   ORDER BY userid  ',nullstring = NA_character_, na.strings = "NA")
dim(D15)
head(D15)



##近7天
D7 <- sqlQuery(conn,' 
SELECT  userid, COUNT(*) AS D7msgcnt ,  COUNT(DISTINCT(DATE(msgtime))) AS D7daycnt  FROM message WHERE DATE(msgtime) >= \'2013-11-15\' AND userid <>0   GROUP BY userid   ORDER BY userid  ',nullstring = NA_character_, na.strings = "NA")
dim(D7)
head(D7)


users<-merge(merge(merge(merge(merge(user1,Total,all=TRUE),D60,all=TRUE),D30,all=TRUE),D15,all=TRUE),D7,all=TRUE)

users[1:50,]
users$subscribeday[is.na(users$subscribeday)]<-'2013-07-21'
users[is.na(users)] <- 0
users[1:50,]
users[10000:10050,]

save(users,file ='kuaibao/data/users.RData')
