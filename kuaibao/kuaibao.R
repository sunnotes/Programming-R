

#This file write for statistic and analysis data of Kuaibao

#install.packages("ggplot2")
library(ggplot2)
userbase <- 373


#connect data

library(RODBC)
detach('packages:RODBC')
conn <- odbcConnect('mysql_data')





#fund data analysis
fund <- sqlQuery(conn,"select date,profit, FROM fund order by updatetime asc")
fund

#statistics
plot(fund$date, fund$profit,type='b')

p <- ggplot()+
  geom_point(data=fund,mapping=aes(x=date,y=profit),colour = "green")+
  geom_point(data=fund,mapping=aes(x=date,y=rate),colour = "red")
print(p)  

p <- ggplot()+
  geom_point(data=fund,mapping=aes(x=date,y=profit),colour = "green")
print(p) 

p <- ggplot()+
  geom_boxplot(data=fund,mapping=aes(x=date,y=profit),colour = "green")
print(p) 


###########user data analysis
##subscribe
subscribe <- sqlQuery(conn, 'SELECT DATE(msgtime) AS date,COUNT(*) AS subscribe  
                      FROM message WHERE event =\'subscribe\'  GROUP BY DATE(msgtime)')
subscribe

user <- as.data.frame(subscribe)
user
##unsubscribe
unsubscribe <- sqlQuery(conn, 'SELECT DATE(msgtime) AS date,COUNT(*) AS unsubscribe 
                        FROM message WHERE event =\'unsubscribe\'  GROUP BY DATE(msgtime)')
unsubscribe

user$unsubscribe <- unsubscribe$unsubscribe
user

##userincrease
userincrease <- subscribe$subscribe -unsubscribe$unsubscribe
user$userincrease <-userincrease
user

#usertotal
usertotal <- cumsum(userincrease) + userbase;
user$usertotal <-usertotal
user


#statistics
qplot(unsubscribe$date,unsubscribe$unsubscribe)

##way1
p <- ggplot(data=unsubscribe,mapping=aes(x=date,y=unsubscribe))
p + geom_point()
p + geom_point()+stat_smooth()

##way2
p <- ggplot()+
  geom_point(data=subscribe,mapping=aes(x=date,y=subscribe))+
  stat_smooth(data=subscribe,mapping=aes(x=date,y=subscribe))
print(p)


p <- ggplot()+
  geom_point(data=subscribe,mapping=aes(x=date,y=subscribe),colour = "green")+
  geom_point(data=unsubscribe,mapping=aes(x=date,y=unsubscribe),colour = "red")
 
print(p)  


summary(user)







###########message data analysis
#messagenum
message <- sqlQuery(conn,'SELECT DATE(msgtime) as date ,COUNT(*) as messagenum 
                    FROM message GROUP BY DATE(msgtime)')
message
