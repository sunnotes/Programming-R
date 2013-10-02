#connect data

library(RODBC)
conn <- odbcConnect('mysql_data')

kuaibao.usernumbase <- 506

###########fund data analysis
kuaibao.fund <- sqlQuery(conn,"SELECT DATE,profit,rate,updatetime FROM fund ORDER BY updatetime ASC")
dim(kuaibao.fund)
head(kuaibao.fund)
summary(kuaibao.fund)


###########follower data analysis
kuaibao.follower <- sqlQuery(conn , "SELECT  b.day,
    SUM(IF(b.type = \'subscribe\',b.num , 0)) AS newfollower,
    SUM(IF(b.type = \'unsubscribe\',b.num , 0)) AS unfollower 				
    FROM (SELECT DATE(msgtime) AS DAY ,type_detail AS TYPE ,COUNT(*) AS num FROM message a WHERE  msg_type = 5 GROUP BY DATE(a.msgtime),a.type_detail) b 
    GROUP BY b.day")
kuaibao.follower$addfollower <- kuaibao.follower$newfollower - kuaibao.follower$unfollower
dim(kuaibao.follower)
head(kuaibao.follower)
summary(kuaibao.follower)


###########messageS data analysis
kuaibao.messages <- sqlQuery(conn,'
    SELECT   id, userid, sex,create_time ,type_detail,content
    FROM 
  	message ',nullstring = NA_character_, na.strings = "NA")
dim(kuaibao.messages)
head(kuaibao.messages)
summary(kuaibao.messages)


save(kuaibao.follower,kuaibao.fund,kuaibao.messages,kuaibao.usernumbase,file ='kuaibao/kuaibao.RData')
