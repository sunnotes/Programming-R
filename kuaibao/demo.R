# --ggplot2--


#R代码如下：
# 加载所需扩展包
library(ggplot2)
library(gpclib)
library(maptools)
# 读取地理信息数据
load("CHN_adm1.RData")
# 人均水资源量
water <- c(1085,325,1473,3524,1079,2935,3989,2790,4147,358,2046,434
           ,1652,2490,451,3362,1467,871,2145,182,1000,12278,448,377,
           182,1221,3135,152,4976,10000,5298,2005)
# 将数据转为数据框
gpclibPermit()
china.map <- fortify(gadm,region='ID_1')
vals <- data.frame(id =unique(china.map$id),val=water)
# 用ggplot命令绘图
ggplot(vals, aes(map_id = id)) + 
  geom_map(aes(fill = val), map =china.map) +
  expand_limits(x = china.map$long, y = china.map$lat) +
  scale_fill_continuous(low = 'red2',high ='yellowgreen',
                        guide = "colorbar") + 
  opts(title='中国人均年水资源拥有量',
       axis.line=theme_blank(),axis.text.x=theme_blank(),
       axis.text.y=theme_blank(),axis.ticks=theme_blank(),
       axis.title.x=theme_blank(),
       axis.title.y=theme_blank()) +
  xlab("") + ylab("")



p <- ggplot(mpg, aes(displ, hwy))
p + geom_point()
p + geom_point(position = "jitter")

# Add aesthetic mappings
p + geom_jitter(aes(colour = cyl))

# Vary parameters
p + geom_jitter(position = position_jitter(width = .5))
p + geom_jitter(position = position_jitter(height = .5))

# Use qplot instead
qplot(displ, hwy, data = mpg, geom = "jitter")
qplot(class, hwy, data = mpg, geom = "jitter")
qplot(class, hwy, data = mpg, geom = c("boxplot", "jitter"))
qplot(class, hwy, data = mpg, geom = c("jitter", "boxplot"))








m <- ggplot(movies, aes(x=rating))
m + geom_histogram()
m + geom_histogram(aes(y = ..density..)) + geom_density()

m + geom_histogram(binwidth = 1)
m + geom_histogram(binwidth = 0.5)
m + geom_histogram(binwidth = 0.1)

# Add aesthetic mappings
m + geom_histogram(aes(weight = votes))
m + geom_histogram(aes(y = ..count..))
m + geom_histogram(aes(fill = ..count..))

# Change scales
m + geom_histogram(aes(fill = ..count..)) +
  scale_fill_gradient("Count", low = "green", high = "red")

# Often we don't want the height of the bar to represent the
# count of observations, but the sum of some other variable.
# For example, the following plot shows the number of movies
# in each rating.
qplot(rating, data=movies, geom="bar", binwidth = 0.1)
# If, however, we want to see the number of votes cast in each
# category, we need to weight by the votes variable
qplot(rating, data=movies, geom="bar", binwidth = 0.1,
      weight=votes, ylab = "votes")

m <- ggplot(movies, aes(x = votes))
# For transformed scales, binwidth applies to the transformed data.
# The bins have constant width on the transformed scale.
m + geom_histogram() + scale_x_log10()
m + geom_histogram(binwidth = 1) + scale_x_log10()
m + geom_histogram() + scale_x_sqrt()
m + geom_histogram(binwidth = 10) + scale_x_sqrt()


# box plots example
library(ggplot2)
mtcars$cylinder <- as.factor(mtcars$cyl)
qplot(cylinder, mpg, data=mtcars, geom=c("boxplot", "jitter"),
      fill=cylinder,
      main="Box plots with superimposed data points",
      xlab= "Number of Cylinders",
      ylab="Miles per Gallon")

# regression example
library(ggplot2)
transmission <- factor(mtcars$am, levels = c(0, 1), 
                       labels = c("Automatic", "Manual"))
qplot(wt, mpg, data = mtcars, 
      color = transmission, shape = transmission, 
      geom = c("point", "smooth"), 
      method = "lm", formula = y ~ x, 
      xlab = "Weight",  ylab = "Miles Per Gallon", 
      main = "Regression Example")

# bubble plot example
library(ggplot2)
mtcars$cyl <- factor(mtcars$cyl, levels = c(4, 6, 8), 
                     labels = c("4 cylinders", "6 cylinders", "8 cylinders"))
mtcars$am <- factor(mtcars$am, levels = c(0, 1), 
                    labels = c("Automatic", "Manual"))
qplot(wt, mpg, data = mtcars, facets = am ~ cyl, size = hp)

# density plot example
library(ggplot2)
data(singer, package = "lattice")
qplot(height, data = singer, geom = c("density"), 
      facets = voice.part ~ ., fill = voice.part)

