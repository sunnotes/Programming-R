#源自：http://cos.name/2014/01/showtext-interesting-fonts-and-graphs/
#
#问题参考https://groups.google.com/forum/#!topic/rapache/35lY7B6Wwrk
#       http://cairographics.org/download/

#install.packages('showtext');
#install.packages('sysfonts');
# showtext会自动加载sysfonts包


oldwd <- getwd();
setwd('/mnt/hgfs/WorkSpaces/Programming-R/tutorial/showtext/');


library(showtext);
# 导入楷体
font.add("kaishu", "simkai.ttf");


#install.packages('Cairo');
library(Cairo);
# 打开图形设备
CairoPNG("chinese-char.png", 600, 600);
# 开始使用showtext
showtext.begin();
# 一系列绘图命令
set.seed(123);
plot(1, xlim = c(-3, 3), ylim = c(-3, 3), type = "n");
text(runif(100, -3, 3), runif(100, -3, 3),
     intToUtf8(round(runif(100, 19968, 40869)), multiple = TRUE),
     col = rgb(runif(100), runif(100), runif(100), 0.5 + runif(100)/2),
     cex = 2, family = "kaishu");    # 指定kaishu字体
title("随机汉字", family = "wqy");   # 指定wqy字体
# 停止使用showtext
showtext.end();
# 关闭图形设备
dev.off();




==================
  
  
link = "http://img.dafont.com/dl/?f=wm_people_1";
download.file(link, "wmpeople1.zip", mode = "wb");
unzip("wmpeople1.zip");

library(showtext);
font.add("wmpeople1", "wmpeople1.TTF");

install.packages('ggplot2');



library(ggplot2);
library(plyr);
library(Cairo);

dat = read.csv(textConnection('
                              edu,educode,gender,population
                              未上过学,1,m,17464
                              未上过学,1,f,41268
                              小  学,2,m,139378
                              小  学,2,f,154854
                              初  中,3,m,236369
                              初  中,3,f,205537
                              高  中,4,m,94528
                              高  中,4,f,70521
                              大专及以上,5,m,57013
                              大专及以上,5,f,50334
                              '));

dat$int = round(dat$population / 10000);
gdat = ddply(dat, "educode", function(d) {
  male = d$int[d$gender == "m"];
  female = d$int[d$gender == "f"];
  data.frame(gender = c(rep("m", male), rep("f", female)),
             x = 1:(male + female));
});
gdat$char = ifelse(gdat$gender == "m", "p", "u");

CairoPNG("edu-stat.png", 600, 300);
showtext.begin();
theme_set(theme_grey(base_size = 15));
ggplot(gdat, aes(x = x, y = educode)) +
  geom_text(aes(label = char, colour = gender),
            family = "wmpeople1", size = 8) +
  scale_x_continuous("人数（千万）") +
  scale_y_discrete("受教育程度",
                   labels = unique(dat$edu[order(dat$educode)])) +
  scale_colour_hue(guide = FALSE) +
  ggtitle("2012年人口统计数据");
showtext.end();
dev.off();