#-------------------------------------------------------------#
# R in Action: Chapter 15                                     #
# requires that the VIM and mice packages have been installed #
# install.packages(c('VIM', 'mice'))                          #
#-------------------------------------------------------------#

# pause on each graph
par(ask = TRUE)

# load the dataset
data(sleep, package = "VIM")

# list the rows that do not have missing values
sleep[complete.cases(sleep), ]

# list the rows that have one or more missing values
sleep[!complete.cases(sleep), ]

# number of missing values on Dream
sum(is.na(sleep$Dream))

# percent of cases with missing values on Dream
mean(is.na(sleep$Dream))

# percent of cases with one or missing values
mean(!complete.cases(sleep))

# tabulate missing values patters
library(mice)
md.pattern(sleep)

# plot missing values patterns
library("VIM")
# close GUI window
aggr(sleep, prop = FALSE, numbers = TRUE)
matrixplot(sleep) # use mouse to sort columns, STOP to move on
marginplot(sleep[c("Gest", "Dream")], pch = c(20), 
    col = c("darkgray", "red", "blue"))

# use correlations to explore missing values
x <- as.data.frame(abs(is.na(sleep)))
head(sleep, n=5)
head(x, n=5)
y <- x[which(sd(x) > 0)]
cor(y)
cor(sleep, y, use = "pairwise.complete.obs")

# complete case analysis (listwise deletion)
cor(na.omit(sleep))
fit <- lm(Dream ~ Span + Gest, data = na.omit(sleep))
summary(fit)

# multiple imputation
library(mice)
data(sleep, package = "VIM")
imp <- mice(sleep, seed = 1234)
fit <- with(imp, lm(Dream ~ Span + Gest))
pooled <- pool(fit)
summary(pooled)
imp
dataset3 <- complete(imp, action=3)
dataset3

# pairwise deletion
cor(sleep, use="pairwise.complete.obs")
