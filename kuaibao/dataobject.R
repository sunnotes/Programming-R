#connect data

library(RODBC)
conn <- odbcConnect('mysql_data')

kuaibao.followersbase <- 506

###########fund data analysis
kuaibao.fund <- sqlQuery(conn,"SELECT date,profit,rate,updatetime FROM fund ORDER BY updatetime ASC")
dim(kuaibao.fund)
head(kuaibao.fund)
summary(kuaibao.fund)


###########follower data analysis
kuaibao.follower <- sqlQuery(conn , "SELECT  b.day,
    SUM(IF(b.type = \'subscribe\',b.num , 0)) AS newfollower,
    SUM(IF(b.type = \'unsubscribe\',b.num , 0)) AS unfollower 				
    FROM (SELECT DATE(msgtime) AS DAY ,type_detail AS TYPE ,COUNT(*) AS num FROM message a WHERE  msg_type = 5 GROUP BY DATE(a.msgtime),a.type_detail) b 
    GROUP BY b.day")
kuaibao.follower$increasedfollower <- kuaibao.follower$newfollower - kuaibao.follower$unfollower
kuaibao.follower$totalfollower <- cumsum(kuaibao.follower$increasedfollower) + kuaibao.followersbase;
dim(kuaibao.follower)
head(kuaibao.follower)
summary(kuaibao.follower)


###########messages data analysis
kuaibao.messages <- sqlQuery(conn,'
    SELECT   id, userid, sex,msgtime ,date(msgtime) as day,hour(msgtime) as hour,msg_type,type_detail,content
  FROM 
	message WHERE DATE(msgtime)>\'2013-07-22\' ',nullstring = NA_character_, na.strings = "NA")
dim(kuaibao.messages)
head(kuaibao.messages)
summary(kuaibao.messages)


save(kuaibao.follower,kuaibao.fund,kuaibao.messages,file ='kuaibao/kuaibao.RData')
