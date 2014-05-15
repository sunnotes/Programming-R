#引用plyr包
#install.packages('plyr')
library(plyr)

#读取数据集
train<-read.csv(file="RHadoop/small.csv",header=FALSE)
names(train)<-c("user","item","pref") 

train


#计算用户列表
usersUnique<-function(){
  users<-unique(train$user)
  users[order(users)]
}

#计算商品列表方法
itemsUnique<-function(){
  items<-unique(train$item)
  items[order(items)]
}

# 用户列表
users<-usersUnique() 


# 商品列表
items<-itemsUnique() 


#建立商品列表索引
index<-function(x) which(items %in% x)
data<-ddply(train,.(user,item,pref),summarize,idx=index(item)) 

data


#同现矩阵
cooccurrence<-function(data){
  n<-length(items)
  co<-matrix(rep(0,n*n),nrow=n)
  for(u in users){
    idx<-index(data$item[which(data$user==u)])
    m<-merge(idx,idx)
    for(i in 1:nrow(m)){
      co[m$x[i],m$y[i]]=co[m$x[i],m$y[i]]+1
    }
  }
  return(co)
}

#推荐算法
recommend<-function(udata=udata,co=coMatrix,num=0){
  n<-length(items)
  
  # all of pref
  pref<-rep(0,n)
  pref[udata$idx]<-udata$pref
  
  # 用户评分矩阵
  userx<-matrix(pref,nrow=n)
  
  # 同现矩阵*评分矩阵
  r<-co %*% userx
  
  # 推荐结果排序
  r[udata$idx]<-0
  idx<-order(r,decreasing=TRUE)
  topn<-data.frame(user=rep(udata$user[1],length(idx)),item=items[idx],val=r[idx])
  topn<-topn[which(topn$val>0),]
  
  # 推荐结果取前num个
  if(num>0){
    topn<-head(topn,num)
  }
  
  #返回结果
  return(topn)
}

#生成同现矩阵
co<-cooccurrence(data) 
co


#计算推荐结果
recommendation<-data.frame()
for(i in 1:length(users)){
  udata<-data[which(data$user==users[i]),]
  recommendation<-rbind(recommendation,recommend(udata,co,0)) 
} 

recommendation
