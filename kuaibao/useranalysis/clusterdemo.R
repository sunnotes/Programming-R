install.packages("rattle")
install.packages("amap")
install.packages("fpc")
install.packages("cba")

# 产生数据集
x<-c(rnorm(200,30,1),rnorm(200,10,1.5),rnorm(100,5,0.5))
y<-c(rnorm(200,30,1),rnorm(200,10,1.5),rnorm(100,5,0.5))
data<-data.frame(x,y)

plot(data)
# 彩色空间
library(colorspace)
# 显示数据集的结构
str(data)

# 系统聚类
# 聚类的一些必要的函数
library(cluster)
library(rattle)
#系统聚类函数在包amap中
require(amap, quietly=TRUE)
#聚类结果有包fpc提供
require(fpc, quietly=TRUE)
#绘图 需cba包
require(cba, quietly=TRUE)

chcluster <- hclusterpar(na.omit(data[,c(1:2)]), method="manhattan", link="ward", nbproc=2)
chcluster 
# 聚类中心
centers.hclust(na.omit(data[,c(1:2)]), chcluster, 3)

#产生树形图 用矩形显示聚类结果

par(bg="grey")
plot(chcluster, main="", sub="", xlab="", labels=FALSE, hang=0)
rect.hclust(chcluster, k=3)
title(main="HCluster_Dendrogram_data", sub=paste("R", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#类与类之间的相关性

par(bg="yellow")
plotcluster(na.omit(data[,c(1:2)]),  cutree(chcluster, 3))
title(main="Discriminant Coordinates data", sub=paste("R", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#数据集的聚类效果图
plot(data[,c(1:2)], col=cutree(chcluster, 3))
title(main="", sub=paste("R", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#验证聚类结果的基本统计信息
cluster.stats(dist(na.omit(data[,c(1:2)])), cutree(chcluster, 3))

library(rattle)
library(colorspace)
require(fpc, quietly=TRUE)
str(data)

# KMEANS CLUSTER

# Set the seed to get the same clusters each time.

set.seed(252964)

# Generate a kmeans cluster of size 3.

kmeans <- kmeans(na.omit(data[,c(1:2)]), 3)

## REPORT ON CLUSTER CHARACTERISTICS
kmeans 
# Cluster sizes:

paste(kmeans$size, collapse=' ')

# Cluster centers:

kmeans$centers

# Within cluster sum of squares:

kmeans$withinss

# Generate a data plot.

par(bg="orange")
plot(na.omit(data[,c(1:2)]), col=kmeans$cluster)
title(main="", sub=paste("R", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

# Generate a discriminant coordinates plot.

par(bg="grey")
plotcluster(na.omit(data[,c(1:2)]), kmeans$cluster)
title(main="Discriminant Coordinates data", sub=paste("R", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

cluster.stats(dist(na.omit(data[,c(1:2)])), kmeans$cluster)