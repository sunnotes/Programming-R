##Creating Random Sales Data of the format CustomerId (unique to each customer), Sales.Date,Purchase.Value

sales=data.frame(sample(1000:1999,replace=T,size=10000),abs(round(rnorm(10000,28,13))))

names(sales)=c("CustomerId","Sales Value")

sales.dates <- as.Date("2010/1/1") + 700*sort(stats::runif(10000))

#generating random dates

sales=cbind(sales,sales.dates)

str(sales)

sales$recency=round(as.numeric(difftime(Sys.Date(),sales[,3],units="days")) )

install.packages('gregmisc')
library(gregmisc)

##if you have existing sales data you need to just shape it in this format

rename.vars(sales, from="Sales Value", to="Purchase.Value")#Renaming Variable Names

## Creating Total Sales(Monetization),Frequency, Last Purchase date for each customer

salesM=aggregate(sales[,2],list(sales$CustomerId),sum)

names(salesM)=c("CustomerId","Monetization")

salesF=aggregate(sales[,2],list(sales$CustomerId),length)

names(salesF)=c("CustomerId","Frequency")

salesR=aggregate(sales[,4],list(sales$CustomerId),min)

names(salesR)=c("CustomerId","Recency")

##Merging R,F,M


head(salesF)
head(salesR)
test1=merge(salesF,salesR,"CustomerId")

salesRFM=merge(salesM,test1,"CustomerId")

##Creating R,F,M levels 

salesRFM$rankR=cut(salesRFM$Recency, 5,labels=F) #rankR 1 is very recent while rankR 5 is least recent

salesRFM$rankF=cut(salesRFM$Frequency, 5,labels=F)#rankF 1 is least frequent while rankF 5 is most frequent

salesRFM$rankM=cut(salesRFM$Monetization, 5,labels=F)#rankM 1 is lowest sales while rankM 5 is highest sales

##Looking at RFM tables
table(salesRFM[,5:6])
table(salesRFM[,6:7])
table(salesRFM[,5:7])
