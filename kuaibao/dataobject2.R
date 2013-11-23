#connect data

library(RODBC)
conn <- odbcConnect('kuaibao')

kuaibao.userbase <- 506

###########fund data analysis
kuaibao.fund <- sqlQuery(conn,"SELECT date as day,profit,rate,updatetime FROM fund ORDER BY updatetime ASC")
dim(kuaibao.fund)
head(kuaibao.fund)


###########user data analysis
kuaibao.user <- sqlQuery(conn , "SELECT  b.day as day,
    SUM(IF(b.type = \'subscribe\',b.num , 0)) AS subscribe,
    SUM(IF(b.type = \'unsubscribe\',b.num , 0)) AS unsubscribe 				
    FROM (SELECT DATE(msgtime) AS day ,type_detail AS type ,COUNT(*) AS num FROM message a WHERE  msg_type = 5 GROUP BY DATE(a.msgtime),a.type_detail) b 
    GROUP BY b.day")
kuaibao.user$newuser <- kuaibao.user$subscribe - kuaibao.user$unsubscribe
kuaibao.user$totaluser<- cumsum(kuaibao.user$newuser) + kuaibao.userbase
kuaibao.user$activeuser <- sqlQuery(conn , "SELECT COUNT(DISTINCT(fromuser)) as activeuser FROM  message WHERE DATE(msgtime)>\'2013-07-22\' GROUP BY DATE(msgtime)" )
dim(kuaibao.user)
head(kuaibao.user)


###########messages data analysis
kuaibao.messages <- sqlQuery(conn,'
   SELECT  userid,msgtime ,msg_type,type_detail,content
  FROM message WHERE msgtime IS NOT  NULL AND msgtime  ORDER BY msgtime  ',nullstring = NA_character_, na.strings = "NA")
dim(kuaibao.messages)
head(kuaibao.messages)


save(kuaibao.user,kuaibao.fund,kuaibao.messages,file ='kuaibao/kuaibao.RData')
