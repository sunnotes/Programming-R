

#This file write for statistic and analysis data of Kuaibao

install.packages("ggplot2")

userbase <- 373


#connect data

library(RODBC)
detach('packages:RODBC')
conn <- odbcConnect('mysql_data')

#messagenum
message <- sqlQuery(conn,'SELECT DATE(msgtime) as date ,COUNT(*) as messagenum 
                    FROM message GROUP BY DATE(msgtime)')
message


#user
useractive <- sqlQuery(conn,'SELECT DATE(msgtime) as date ,
                      COUNT(DISTINCT(fakeid)) as activeuser
                       FROM  message GROUP BY DATE(msgtime)')
useractive

plot(useractive$date,useractive$activeuser)


#fund
fund <- sqlQuery(conn,"select date,profit,rate FROM fund order by updatetime asc")
fund

##subscribe
subscribe <- sqlQuery(conn, 'SELECT DATE(msgtime) AS date,COUNT(*) AS subscribe  
                      FROM message WHERE event =\'subscribe\'  GROUP BY DATE(msgtime)')
subscribe

##unsubscribe
unsubscribe <- sqlQuery(conn, 'SELECT DATE(msgtime) AS date,COUNT(*) AS unsubscribe 
                        FROM message WHERE event =\'unsubscribe\'  GROUP BY DATE(msgtime)')
unsubscribe

##userincrease
userincrease <- subscribe$subscribe -unsubscribe$unsubscribe
userincrease

#usertotal
usertotal <- cumsum(userincrease) + userbase;
usertotal

usermerge <- merge(merge(subscribe,unsubscribe,c('date')),useractive,c('date'))
usermerge

useractiverate <- useractive[2] / usertotal
useractiverate

#user
user <- cbind2(usermerge,usertotal,useractiverate)
user
summary(user)

##fund 
fund$date
summary(fund)

plot(fund$date, fund$profit,type='b')

plot( user$useractiverate,user$date,type='b')

boxplot(fund$profit)
hist(fund$profit)

fund.profit <- scale(fund$profit)
fund.profit
plot(fund.profit)






chinese <-'中文'
chinese