##install.packages("maps")

library(maps)

map('world', fill = TRUE,col=colors( ))

library(ggplot2)
library(maps) # For map data
# Get map data for world
world_map <- map_data("world")
ggplot(world_map, aes(x=long, y=lat, group=group)) +
  geom_polygon(fill="white", colour="black")


# geom_path (no fill) 
ggplot(world_map, aes(x=long, y=lat, group=group)) +
  geom_path()


#利用这个world数据集，也可以画区域地图：

east_asia <- map_data("world", region=c("Japan", "China", "North Korea",
                                        "South Korea"))
# Map region to fill color
ggplot(east_asia, aes(x=long, y=lat, group=group, fill=region)) +
  geom_polygon(colour="black") +
  scale_fill_brewer(palette="Set1")


#在统计之都的这篇博客http://cos.name/2009/07/drawing-china-map-using-r/
#  下载中国地图的GIS数据，这是一个压缩包，完全解压后包含三个文件（bou2_4p.dbf、bou2_4p.shp和bou2_4p.shx）。

library(maptools)
china_map<-readShapePoly("tutorial/bou2_4p.shp")
plot(china_map)

ggplot(china_map, aes(x = long, y = lat, group = group)) + 
  geom_polygon(fill = "beige") + 
  geom_path(colour = "grey40")

#了解这个数据集的信息
x<-china_map@data
head(x)


#了解省的名称：
as.character(na.omit(unique(china_map@data$NAME)))
#或者
attributes(china_map@data[,7])



#书接上文，继续利用shapefile数据结合ggplot2和maptools包来画地图
#shapefile数据的复杂之处在于，用readShapePoly读入以后并非普通的数据框，可用str( )看看里边的内容，这个数据集包含了全部的地理信息，R按顺序把其中包含的925个多边形区域依次画出。处理不慎损失信息的话，地图可能会画成很奇怪的样子。所以我们需要先把读入的数据转化为一个dataframe，这用到了ggplot2包的fortify函数。

library(maptools)
china_map<-readShapePoly("tutorial/bou2_4p.shp")

x<-china_map@data
xs<-data.frame(x,id=seq(0:924)-1)

library(ggplot2)
china_map1<-fortify(china_map) #转化为数据框

#看一下这个数据框的内容
head(china_map1)


#没有行政区域的信息啊，这就需要前面的那个数据框xs了。


library(plyr)
china_mapdata<-join(china_map1, xs, type = "full") #合并两个数据框

#再看看
head(china_mapdata)

china_mapdata$NAME<-iconv(china_mapdata[[14]], from = "gbk", to = "utf-8")

#下面用这个新的数据框来画中国地图
ggplot(china_mapdata, aes(x = long, y = lat, group = group,fill=NAME))+
  geom_polygon( )+
  geom_path(colour = "grey40")+
  scale_fill_manual(values=colours(),guide=FALSE)





#也可以利用它来区域地图

zhejiang<-subset(china_mapdata,NAME=="浙江省")

ggplot(zhejiang, aes(x = long, y = lat, group = group,fill=NAME))+
  geom_polygon(fill="beige" )+
  geom_path(colour = "grey40")+
  ggtitle("中华人民共和国浙江省")+
  geom_point(x=120.12,y=30.16,fill=FALSE)+
  annotate("text",x=120.3,y=30,label="杭州市")



#在复杂一点，来画中国人口地图，各省的人口数据来自国家统计局2010年人口普查数据，台湾和香港的数据来自百度（没有澳门，上一篇讨论过这个数据集没有澳门的区域）

NAME<-c("北京市","天津市","河北省","山西省","内蒙古自治区","辽宁省","吉林省",
        "黑龙江省","上海市","江苏省","浙江省","安徽省","福建省", "江西省","山东省","河南省",
        "湖北省", "湖南省","广东省", "广西壮族自治区","海南省", "重庆市","四川省", "贵州省",
        "云南省","西藏自治区","陕西省","甘肃省","青海省","宁夏回族自治区","新疆维吾尔自治区", 
        "台湾省","香港特别行政区")

pop<-c(244,2,118,86,61,205,22,74,321,434,393,110,182,77,232,198,
       183,101,624,78,30,80,152,21,
       73,0,42,24,3,10,20,3,0)

pops<-data.frame(NAME,pop)
head(pops)

#把人口信息和行政区域地图结合起来有几种办法，下面的是一种偷懒的方法，把人口数据和行政地图合并。

china_pop<-join(china_mapdata, pops, by = 'NAME', type = "full")

head(china_pop)
sum(china_pop$pop, na.rm = TRUE)

ggplot(china_pop, aes(x = long, y = lat, group = group,fill=pop))+
  geom_polygon()+
  geom_path(colour = "grey40")+
  scale_fill_continuous(low = 'yellowgreen',high ='red2',
                      guide = "colorbar")
+
  scale_fill_manual(values=colours(),guide=FALSE)



ggplot(china_pop, aes(map_id = id)) + 
  geom_map(aes(fill = pop), map =china_pop) +
  expand_limits(x = china_pop$long, y = china_pop$lat) +
  scale_fill_continuous(low = 'red2',high ='yellowgreen',
                        guide = "colorbar") + 
  theme(title='中国人均年水资源拥有量',
       axis.line=theme_blank(),axis.text.x=theme_blank(),
       axis.text.y=theme_blank(),axis.ticks=theme_blank(),
       axis.title.x=theme_blank(),
       axis.title.y=theme_blank()) +
  xlab("") + ylab("")




ggplot(china_mapdata, aes(x = long, y = lat, group = group,fill=NAME))+
  geom_polygon( )+
  geom_path(colour = "grey40")+
  scale_fill_manual(values=colours(),guide=FALSE)

#图上浅色部分即为几个人口大省。

#####
##说明一下（1）这一篇的图用plot( )都可以完成，我这里使用ggplot2的原因是ggplot2潜在的美观上的可扩展性。
#（2）个人体会，画地图的难点不在如何绘图，而在如何整理数据以供绘图之用。
