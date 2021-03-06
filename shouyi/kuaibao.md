

---
layout: post
title: "余额宝快报公众平台数据分析报告"
description: ""
category: statistics
tags: [ 余额宝 , 统计 ]
---
{% include JB/setup %}

摘要：

【余额宝快报】是基于微信，提供余额宝（天弘增利宝货币基金）收益播报，计算，查询及常见问题回答的微信公共平台。本文是对该平台后台数据的分析与挖据，主要内容包括：1.对基金每日收益进行分析；2.对用户及其订阅及取消订阅行为进行分析；3.对消息及其种类，发送时间等信息进行分析；4.对每日新增关注人数进行回归分析；5.对每日消息数进行挖据分析。本文使用R语言作为工具，使用ggplot2包进行绘图，使用knitr+markdown进行文档编辑。

观点：

 * 1.  快报男性用户是女性用户的2倍，男性更爱“理财”
 
 * 2.	很多用户通过向【快报】提问，获取余额宝相关的信息
 
 * 3.	【快报】每天的活跃用户数并没有随着用户的增加而增加，用户活跃度度相在降低


报告文档[下载]({{}}/adds/kuaibao/余额宝快报平台数据研究报告Ⅱ.pdf)


1 概述
-----------------------


### 1.1  报告所涉数据来源

本报告所涉主要数据均来自「余额宝快报」微信公共平台所收集的数据，时间范围为2013年7月23日起至2013年10月2日止。
  
「余额宝快报」微信公共平台于7月13号注册，后台开发于7月21日完成，从23日开始产生完整的信息数据记录，所以本报告以2013年7月23日起至2013年10月2日止，77个自然日的数据为样本。

### 1.2	为什么要做这样的报告分析

「余额宝快报」微信公共平台推出以来受到用户欢迎，目前累计用户超过8000，每天处理3000次左右的用户互动查询，但用户及每天互动的消息数增长速度并未达到预期。通过本报告，了解细化用户的需求，了解他们的活跃时间，推出个性化的内容及服务。

  
2 数据分析与可视化
-----------------------

### 2.1	整体概况

截至2013-10-2日，余额宝快报共有4913位用户，其中7月23日起至10月2日共新增用户4407名。

### 2.2 数据准备

为了便于分析,先将系统Mysql数据库的数据整理出，存在[本地](https://github.com/sunnotes/Programming-R/blob/master/kuaibao/kuaibao.RData)，通过```load(file =' ')```可以直接调用，从数据库加载到本地文件的代码详见我的[代码库](https://github.com/sunnotes/Programming-R/blob/master/kuaibao/dataobject.R)

安装并加载依赖的R库


```r

load(file = "shouyi/kuaibao.RData")
```

```
## Warning: cannot open compressed file 'shouyi/kuaibao.RData', probable
## reason 'No such file or directory'
```

```
## Error: cannot open the connection
```

```r
# install.packages('ggplot2') install.packages('timeDate')
library(ggplot2)
library(timeDate)
library(reshape2)
```



### 2.3 基金收益分析

#### 2.3.1 基金收益样例数据


```r
head(kuaibao.fund)
```

```
## Error: object 'kuaibao.fund' not found
```

 * day  是日期数据，一天一份，数据从2013-07-16开始
 * profit  是增利宝（余额宝基金公司）每日公布的每万份收益额
 * rate 是增利宝每日公布的七日年化收益率
 * updatetime 是该收益的更新时间

#### 2.3.2 基金收益数据分析：


```r
summary(kuaibao.fund)
```

```
## Error: object 'kuaibao.fund' not found
```

通过对基金的收益分析可以看出：1)系统的统计时（day）间为2013-07-16到 2013-10-02;
2)每日万份收益最小值为1.15，最大值为1.51，均值为1.25

下面对每日万份收益做详细的分析
* 每日万份收益 整体分析

```r
summary(kuaibao.fund$profit)
```

```
## Error: object 'kuaibao.fund' not found
```

 * 均值与方差


```r
mean(kuaibao.fund$profit)
```

```
## Error: object 'kuaibao.fund' not found
```

```r
sd(kuaibao.fund$profit)
```

```
## Error: object 'kuaibao.fund' not found
```


判断收益是否符合正态分布

```r
shapiro.test(kuaibao.fund$profit)
```

```
## Error: object 'kuaibao.fund' not found
```

p值明显小于0.05，表明数据不符合正态分布。

 * 每日万份收益统计时间序列图


```r
ggplot(kuaibao.fund, aes(x = day, y = profit)) + geom_point(color = "#009E73") + 
    geom_smooth(method = "loess", color = "#D55E00") + scale_x_date() + xlab("") + 
    ylab("profit")
```

```
## Error: object 'kuaibao.fund' not found
```

由上图可以看出，通过loess（局部加权回归散点平滑法locally weighted scatterplot smoothing，LOWESS或LOESS）回归拟合，在8月25日-9月25日拟合较差，这期间收益涨跌幅度较大。

 * 每日万份收益统计箱须图


```r
ggplot(kuaibao.fund, aes(x = day, y = profit)) + geom_point(color = "#009E73") + 
    geom_boxplot(colour = "#56B4E9", alpha = 0.1)
```

```
## Error: object 'kuaibao.fund' not found
```


* 每日万份收益统计直方图

```r
ggplot(kuaibao.fund, aes(x = profit)) + geom_histogram(aes(y = ..count..), binwidth = 0.02, 
    colour = "black", fill = "white") + geom_density(alpha = 0.2, fill = "#FF6666")
```

```
## Error: object 'kuaibao.fund' not found
```


通过对万份收益数据的分布拟合，也表明样本数据不符合正态分布。


### 2.4用户分析


#### 2.4.1 用户样例数据


```r
head(kuaibao.user)
```

```
## Error: object 'kuaibao.user' not found
```

其中，

 * day  是日期数据，一天一份，数据从2013-07-23开始
 * subscribe 表示每日新关注人数
 * unsubscribe 表示每日取消关注人数
 * newuser 表示净增关注人数
 * newuser totaluser表示累计关注人数

#### 2.4.2 用户数据统计分析

```r
summary(kuaibao.user)
```

```
## Error: object 'kuaibao.user' not found
```


* 对数据进行重塑

通过melt融合数据,为使统计更直观，暂时取消,newuser,totaluser数据

```r
kuaibao.user.melt <- melt(kuaibao.user[, 1:3], id = "day", variable.name = "type", 
    value.name = "cnt")
```

```
## Error: object 'kuaibao.user' not found
```


融合后代数据样例


```r
head(kuaibao.user.melt)
```

```
## Error: object 'kuaibao.user.melt' not found
```


* 用户每日时间序列图


```r
ggplot(kuaibao.user.melt, aes(day, cnt, group = type, colour = type)) + geom_line() + 
    geom_point() + geom_smooth(method = "loess") + scale_x_date() + xlab("") + 
    ylab("")
```

```
## Error: object 'kuaibao.user.melt' not found
```


由上图可以大致看出，每日新增关注人数和每日取消关注人数有一定的关联关系，当新增用户数增加时，取消关注的人数也会增加。


```r
subscribe.scaled = scale(kuaibao.user$subscribe)
```

```
## Error: object 'kuaibao.user' not found
```

```r
unsubscribe.scaled = scale(kuaibao.user$unsubscribe)
```

```
## Error: object 'kuaibao.user' not found
```

```r
user.scaled = data.frame(kuaibao.user$day, subscribe.scaled, unsubscribe.scaled)
```

```
## Error: object 'kuaibao.user' not found
```

```r
user.scaled.melt = melt(user.scaled, id = "kuaibao.user.day", variable.name = "type", 
    value.name = "cnt")
```

```
## Error: object 'user.scaled' not found
```

```r
ggplot(user.scaled.melt, aes(kuaibao.user.day, cnt, group = type, colour = type)) + 
    geom_line() + geom_point() + geom_smooth() + scale_x_date() + xlab("") + 
    ylab("User cnt")
```

```
## Error: object 'user.scaled.melt' not found
```

上图图为将数据进行标准正态化后的比较，二者的关联关系较为明显。

#### 2.3.4  每日累计用户数时间序列图

```r

ggplot(kuaibao.user, aes(day, totaluser)) + geom_line() + geom_point() + geom_smooth() + 
    scale_x_date() + xlab("") + ylab("")
```

```
## Error: object 'kuaibao.user' not found
```


可以看出，每天


#### 2.3.5 重点研究每日净新增的用户人数



```r
summary(kuaibao.user$newuser)
```

```
## Error: object 'kuaibao.user' not found
```



```r
ggplot(kuaibao.user, aes(x = day, y = newuser)) + geom_point(color = "#009E73") + 
    geom_smooth(method = "loess", color = "#D55E00") + scale_x_date() + xlab("") + 
    ylab("cnt")
```

```
## Error: object 'kuaibao.user' not found
```

通过loess拟合，没发现数据的规律。

#### 2.3.6 用户性别分析


```r
cnt <- c(3164, 1514, 199)
gen = c("男性", "女性", "未知")
pct = round(cnt/sum(cnt) * 100)
lab = paste(gen, " ", pct, "%")
```


由于系统后台无法采集完整的性别数据，该数据直接取自微信公众号后台。

所有关注者中，男性3164名，女性1514名，性别未知199名。

男女比例为2.1：1

详见下图：

```r
colors <- c("#56B4E9", "#009E73", "#D55E00")
pie(cnt, labels = lab, col = colors, main = "订阅用户性别比例图")
```

```
## Warning: conversion failure on '男性   65 %' in 'mbcsToSbcs': dot substituted for <e7>
## Warning: conversion failure on '男性   65 %' in 'mbcsToSbcs': dot substituted for <94>
## Warning: conversion failure on '男性   65 %' in 'mbcsToSbcs': dot substituted for <b7>
## Warning: conversion failure on '男性   65 %' in 'mbcsToSbcs': dot substituted for <e6>
## Warning: conversion failure on '男性   65 %' in 'mbcsToSbcs': dot substituted for <80>
## Warning: conversion failure on '男性   65 %' in 'mbcsToSbcs': dot substituted for <a7>
## Warning: font metrics unknown for Unicode character U+7537
## Warning: font metrics unknown for Unicode character U+6027
## Warning: conversion failure on '女性   31 %' in 'mbcsToSbcs': dot substituted for <e5>
## Warning: conversion failure on '女性   31 %' in 'mbcsToSbcs': dot substituted for <a5>
## Warning: conversion failure on '女性   31 %' in 'mbcsToSbcs': dot substituted for <b3>
## Warning: conversion failure on '女性   31 %' in 'mbcsToSbcs': dot substituted for <e6>
## Warning: conversion failure on '女性   31 %' in 'mbcsToSbcs': dot substituted for <80>
## Warning: conversion failure on '女性   31 %' in 'mbcsToSbcs': dot substituted for <a7>
## Warning: font metrics unknown for Unicode character U+5973
## Warning: font metrics unknown for Unicode character U+6027
## Warning: conversion failure on '未知   4 %' in 'mbcsToSbcs': dot substituted for <e6>
## Warning: conversion failure on '未知   4 %' in 'mbcsToSbcs': dot substituted for <9c>
## Warning: conversion failure on '未知   4 %' in 'mbcsToSbcs': dot substituted for <aa>
## Warning: conversion failure on '未知   4 %' in 'mbcsToSbcs': dot substituted for <e7>
## Warning: conversion failure on '未知   4 %' in 'mbcsToSbcs': dot substituted for <9f>
## Warning: conversion failure on '未知   4 %' in 'mbcsToSbcs': dot substituted for <a5>
## Warning: font metrics unknown for Unicode character U+672a
## Warning: font metrics unknown for Unicode character U+77e5
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <e8>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <ae>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <a2>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <e9>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <98>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <85>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <e7>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <94>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <a8>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <e6>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <88>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <b7>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <e6>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <80>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <a7>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <e5>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <88>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <ab>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <e6>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <af>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <94>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <e4>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <be>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <8b>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <e5>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <9b>
## Warning: conversion failure on '订阅用户性别比例图' in 'mbcsToSbcs': dot substituted for <be>
```

<img src="figure/kuaibao_user_gender.png" title="plot of chunk user gender" alt="plot of chunk user gender" style="display: block; margin: auto;" />

```r

# ggplot(kuaibao.user.gender, aes(x = '' ,y = pct, fill = gen),stat = 'bin')
# + geom_bar(width = 3) + coord_polar('y')+ xlab('') + ylab('') +
# labs(fill='lab')
```


#### 2.3.7 用户活跃度分析

```r
rate <- round(kuaibao.user$activeuser/kuaibao.user$totaluser, 2)
```

```
## Error: object 'kuaibao.user' not found
```

```r
active <- data.frame(kuaibao.user$day, rate)
```

```
## Error: object 'kuaibao.user' not found
```

```r
colnames(active) <- c("day", "rate")
```

```
## Error: object 'active' not found
```

```r
ggplot(active, aes(x = day, y = rate)) + geom_point(color = "#009E73") + geom_smooth(method = "loess", 
    color = "#D55E00") + scale_x_date() + xlab("") + ylab("")
```

```
## Error: object 'active' not found
```


### 2.4 消息统计分析

#### 2.4.1 消息样例数据

```r
head(kuaibao.messages, 10)
```

```
## Error: object 'kuaibao.messages' not found
```

#### 2.4.2 消息总体分析

```r
dim(kuaibao.messages)
```

```
## Error: object 'kuaibao.messages' not found
```

```r

summary(kuaibao.messages)
```

```
## Error: object 'kuaibao.messages' not found
```


共有70869条数据记录

#### 2.4.3 不同消息数量对比


```r
library(scales)
ggplot(kuaibao.messages, aes(x = type_detail, color = type_detail, fill = type_detail)) + 
    geom_histogram() + scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), 
    labels = trans_format("log10", math_format(10^.x))) + xlab("") + ylab("")
```

```
## Error: object 'kuaibao.messages' not found
```


#### 2.4.4 每天的消息数比较

```r
ggplot(kuaibao.messages, aes(x = day)) + geom_histogram(aes(y = ..count..), 
    binwidth = 0.5) + geom_rect(data = kuaibao.messages, aes(xmin = day, xmax = day + 
    1, fill = isWeekend(day)), ymin = 0, ymax = 2500, alpha = 0.005) + xlab("") + 
    ylab("")
```

```
## Error: object 'kuaibao.messages' not found
```

蓝色背景表示当天是周末，可以看到一般在周末，消息数量就会较少。

每天不同类型的消息比较

```r
ggplot(kuaibao.messages, aes(x = day, fill = type_detail)) + geom_histogram(aes(y = ..count..), 
    binwidth = 0.5) + xlab("") + ylab("")
```

```
## Error: object 'kuaibao.messages' not found
```




3  数据挖掘分析
-------------


### 3.1 每日新增关注人数

通过前面的分析,可以大致的看出,每日新增人数和每日万份收益,是否是周末有一定的关系.通过对数据做正态标准化,详见下图



```r

fund.profits = kuaibao.fund[-(1:7), ]
```

```
## Error: object 'kuaibao.fund' not found
```

```r
# dim(fund.profits) head(fund.profits) head(kuaibao.user) dim(kuaibao.user)
subscribeanalysis = data.frame(fund.profits$day, fund.profits$profit, kuaibao.user$subscribe, 
    isWeekend(fund.profits$day))
```

```
## Error: object 'fund.profits' not found
```

```r
colnames(subscribeanalysis) <- c("day", "profit", "subscribe", "isweekend")
```

```
## Error: object 'subscribeanalysis' not found
```

```r
head(subscribeanalysis)
```

```
## Error: object 'subscribeanalysis' not found
```

```r

scalesubscribeanalysis = scale(subscribeanalysis[, 2:3])
```

```
## Error: object 'subscribeanalysis' not found
```

```r
head(scalesubscribeanalysis)
```

```
## Error: object 'scalesubscribeanalysis' not found
```

```r

meltsubscribeanalysis <- melt(scalesubscribeanalysis, id = "day", variable.name = c("day", 
    "type"))
```

```
## Error: object 'scalesubscribeanalysis' not found
```

```r


ggplot(meltsubscribeanalysis, aes(Var1, value, group = Var2, colour = Var2)) + 
    geom_line() + geom_point() + geom_smooth(method = "loess") + scale_x_date() + 
    xlab("") + ylab("")
```

```
## Error: object 'meltsubscribeanalysis' not found
```


对


```r
fm <- lm(formula = subscribe ~ profit + isweekend, data = subscribeanalysis)
```

```
## Error: object 'subscribeanalysis' not found
```

```r

summary(fm)
```

```
## Error: object 'fm' not found
```

```r
plot(fm$residuals)
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'fm' not found
```

```r

```



```r
subscribeanalysis2 <- subscribeanalysis
```

```
## Error: object 'subscribeanalysis' not found
```

```r
sa <- subset(subscribeanalysis2, day != "2013-08-21")
```

```
## Error: object 'subscribeanalysis2' not found
```

```r
sa <- subset(sa, day != "2013-09-06")
```

```
## Error: object 'sa' not found
```

```r
sa <- subset(sa, day != "2013-09-24")
```

```
## Error: object 'sa' not found
```

```r
dim(sa)
```

```
## Error: object 'sa' not found
```

```r
fm2 <- lm(formula = subscribe ~ profit + isweekend, data = sa)
```

```
## Error: object 'sa' not found
```

```r
summary(fm2)
```

```
## Error: object 'fm2' not found
```

```r

fm3 <- lm(formula = subscribe ~ profit, data = sa)
```

```
## Error: object 'sa' not found
```

```r
summary(fm3)
```

```
## Error: object 'fm3' not found
```

```r

```


通过线性回归可以看出，和是否是周末没有太大的关系
绘图展示

```r
ggplot(subscribeanalysis, aes(x = profit, y = subscribe)) + geom_point(color = "#009E73") + 
    geom_smooth(method = "lm", color = "#D55E00", lwd = 2) + xlab("profit") + 
    ylab("subscribe")
```

```
## Error: object 'subscribeanalysis' not found
```

```r


ggplot(subscribeanalysis, aes(x = profit, y = subscribe)) + geom_point(color = "#009E73") + 
    geom_smooth(method = "loess", color = "#CC79A7", lwd = 2) + xlab("profit") + 
    ylab("subscribe")
```

```
## Error: object 'subscribeanalysis' not found
```

```r

loess.subscribeanalysis <- loess(subscribe ~ profit, data = subscribeanalysis2)
```

```
## Error: object 'subscribeanalysis2' not found
```

```r
summary(loess.subscribeanalysis)
```

```
## Error: object 'loess.subscribeanalysis' not found
```






### 3.2 每天消息数做分析


```r
head(kuaibao.messages)
```

```
## Error: object 'kuaibao.messages' not found
```

```r
dim(kuaibao.messages)
```

```
## Error: object 'kuaibao.messages' not found
```

```r

messagesperday <- tapply(kuaibao.messages$id, kuaibao.messages$day, length)
```

```
## Error: object 'kuaibao.messages' not found
```

```r
# head(messagesperday) dim(messagesperday) class(messagesperday)
msgana <- data.frame(kuaibao.fund[-(1:7), ]$day, kuaibao.fund[-(1:7), ]$profit, 
    kuaibao.user$subscribe, messagesperday, isWeekend(kuaibao.fund[-(1:7), ]$day))
```

```
## Error: object 'kuaibao.fund' not found
```

```r
colnames(msgana) <- c("day", "profit", "subscribe", "message", "isweekend")
```

```
## Error: object 'msgana' not found
```

```r
head(msgana)
```

```
## Error: object 'msgana' not found
```


#### 3.2.1 时间序列分析

```r

messagestimeseries <- ts(msgana$message)
```

```
## Error: object 'msgana' not found
```

```r
plot.ts(messagestimeseries)
```

```
## Error: object 'messagestimeseries' not found
```

```r
messagestimeseriesSMA3 <- SMA(messagestimeseries, n = 5)
```

```
## Error: could not find function "SMA"
```

```r
plot.ts(messagestimeseriesSMA3)
```

```
## Error: object 'messagestimeseriesSMA3' not found
```


#### 3.2.2 多元线性回归

```r
lm.msgana <- lm(message ~ profit + subscribe + isweekend, data = msgana)
```

```
## Error: object 'msgana' not found
```

```r
summary(lm.msgana)
```

```
## Error: object 'lm.msgana' not found
```

```r

anova(lm.msgana)
```

```
## Error: object 'lm.msgana' not found
```

```r

lm2.msgana <- lm(message ~ profit + subscribe, data = msgana)
```

```
## Error: object 'msgana' not found
```

```r
summary(lm2.msgana)
```

```
## Error: object 'lm2.msgana' not found
```

```r

anova(lm.msgana, lm2.msgana)
```

```
## Error: object 'lm.msgana' not found
```

```r

final.lm.msgana <- step(lm.msgana)
```

```
## Error: object 'lm.msgana' not found
```

```r
plot(lm.msgana)
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'lm.msgana' not found
```

```r

final.lm.msgana.predictions <- predict(final.lm.msgana, msgana)
```

```
## Error: object 'final.lm.msgana' not found
```

```r

plot(final.lm.msgana.predictions, msgana$message)
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'final.lm.msgana.predictions' not found
```

```r
abline(0, 1, lty = 2)
```

```
## Error: plot.new has not been called yet
```

```r

shapiro.test(msgana$subscribe)
```

```
## Error: object 'msgana' not found
```

```r

glm.msgana <- glm(message ~ profit + subscribe, family = gaussian, data = msgana)
```

```
## Error: object 'msgana' not found
```

```r

summary(glm.msgana)
```

```
## Error: object 'glm.msgana' not found
```

```r
plot(glm.msgana)
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'glm.msgana' not found
```

#### 3.2.3 loess回归分析

```r
loess.msgana <- loess(message ~ profit + subscribe, data = msgana)
```

```
## Error: object 'msgana' not found
```

```r
summary(loess.msgana)
```

```
## Error: object 'loess.msgana' not found
```

```r

anova(lm.msgana, loess.msgana)
```

```
## Error: object 'lm.msgana' not found
```

```r

lm2.msgana <- lm(message ~ profit + subscribe, data = msgana)
```

```
## Error: object 'msgana' not found
```

```r
summary(lm2.msgana)
```

```
## Error: object 'lm2.msgana' not found
```

```r

anova(lm.msgana, lm2.msgana)
```

```
## Error: object 'lm.msgana' not found
```

```r

final.lm.msgana <- step(lm.msgana)
```

```
## Error: object 'lm.msgana' not found
```

```r
plot(lm.msgana)
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'lm.msgana' not found
```

```r

final.lm.msgana.predictions <- predict(final.lm.msgana, msgana)
```

```
## Error: object 'final.lm.msgana' not found
```

```r

plot(final.lm.msgana.predictions, msgana$message)
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'final.lm.msgana.predictions' not found
```

```r
abline(0, 1, lty = 2)
```

```
## Error: plot.new has not been called yet
```

```r

shapiro.test(msgana$subscribe)
```

```
## Error: object 'msgana' not found
```

```r

glm.msgana <- glm(message ~ profit + subscribe, family = gaussian, data = msgana)
```

```
## Error: object 'msgana' not found
```

```r

summary(glm.msgana)
```

```
## Error: object 'glm.msgana' not found
```

```r
plot(glm.msgana)
```

```
## Error: error in evaluating the argument 'x' in selecting a method for function 'plot': Error: object 'glm.msgana' not found
```




