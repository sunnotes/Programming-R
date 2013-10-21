# 输入体重
X1<-c(35, 40, 40, 42, 37, 45, 43, 37, 44, 42, 41, 39)

# 计算体重的均值和标准差
mu1<-mean(X1); sigma1<-sd(X1) 

# 输入胸围
X2<-c(60, 74, 64, 71, 72, 68, 78, 66, 70, 65, 73, 75)

# 计算胸围的均值和标准差
mu2<-mean(X2); sigma2<-sd(X2);

hist(X1) # 绘出体重的直方图

hist(X1, probability = TRUE,
    main = paste("Histogram of" , "weight"), 
    xlab = "weight")
lines(density(X1))

student.list<-list(weight=X1, height=X2); student.list

student.df<-data.frame(weight=X1, height=X2); student.df

