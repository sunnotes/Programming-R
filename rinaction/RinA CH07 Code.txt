#--------------------------------------------------------------------#
# R in Action: Chapter 7                                             #
# requires that the npmc, ggm, gmodels, vcd, Hmisc,                  #
# pastecs, psych, doBy, and reshape packages have been installed     #
# install.packages(c('npmc', 'ggm', 'gmodels', 'vcd', 'Hmisc',       #
#     'pastecs', 'psych', 'doBy', 'reshape'))                        #
#---------------------------------------------------------------------

vars <- c("mpg", "hp", "wt")
head(mtcars[vars])

# Listing 7.1 - descriptive stats via summary

summary(mtcars[vars])

# Listing 7.2 - descriptive stats via sapply()

mystats <- function(x, na.omit = FALSE) {
    if (na.omit) 
        x <- x[!is.na(x)]
    m <- mean(x)
    n <- length(x)
    s <- sd(x)
    skew <- sum((x - m)^3/s^3)/n
    kurt <- sum((x - m)^4/s^4)/n - 3
    return(c(n = n, mean = m, stdev = s, skew = skew, kurtosis = kurt))
}

sapply(mtcars[vars], mystats)

# Listing 7.3 - Descriptive statistics (Hmisc package)

library(Hmisc)
describe(mtcars[vars])

# Listing 7.4 - Descriptive statistics (pastecs package)

library(pastecs)
stat.desc(mtcars[vars])

# Listing 7.5 - Descriptive statistics (psych package)

library(psych)
describe(mtcars[vars])

# Listing 7.6 - Descriptive statistics by group with aggregate()

aggregate(mtcars[vars], by = list(am = mtcars$am), mean)
aggregate(mtcars[vars], by = list(am = mtcars$am), sd)

# Listing 7.7 - Descriptive statistics by group via by()

dstats <- function(x)(c(mean=mean(x), sd=sd(x)))
by(mtcars[vars], mtcars$am, dstats)

# Listing 7.8 Summary statists by group (doBy package)

library(doBy)
summaryBy(mpg + hp + wt ~ am, data = mtcars, FUN = mystats)

# Listing 7.9 - Summary statistics by group (psych package)

library(psych)
describe.by(mtcars[vars], mtcars$am)

# Listing 1.10 Summary statistics by group (reshape package)

library(reshape)
dstats <- function(x) (c(n = length(x), mean = mean(x), 
    sd = sd(x)))
dfm <- melt(mtcars, measure.vars = c("mpg", "hp", 
    "wt"), id.vars = c("am", "cyl"))
cast(dfm, am + cyl + variable ~ ., dstats)

# Section --7.2--

# get Arthritis data
library(vcd)

# one way table

mytable <- with(Arthritis, table(Improved))
mytable
prop.table(mytable)
prop.table(mytable)*100


# two way table

mytable <- xtabs(~ Treatment+Improved, data=Arthritis)
mytable
margin.table(mytable, 1)
prop.table(mytable, 1)
margin.table(mytable, 2)
prop.table(mytable, 2)
prop.table(mytable)
addmargins(mytable)
admargins(prop.table(mytable))
addmargins(prop.table(mytable, 1), 2)
addmargins(prop.table(mytable, 2, 1)

# Listing 7.11 - Two-way table using CrossTable

library(gmodels)
CrossTable(Arthritis$Treatment, Arthritis$Improved)

# Listing 7.12 - Three-way contingency table

mytable <- xtabs(~ Treatment+Sex+Improved, data=Arthritis)
mytable
ftable(mytable)
margin.table(mytable, 1)
margin.table(mytable, 2)
margin.table(mytable, 3)
margin.table(mytable, c(1,3))
ftable(prop.table(mytable, c(1, 2)))
ftable(addmargins(prop.table(mytable, c(1, 2)), 3))

gtable(addmargins(prop.table(mytable, c(1, 2)), 3)) * 100

# Listing 7.13 - Chis-square test of independence

library(vcd)
mytable <- xtabs(~Treatment+Improved, data=Arthritis)
chisq.test(mytable)
mytable <- xtabs(~Improved+Sex, data=Arthritis)
chisq.test(mytable)

# Fisher's exact test

mytable <- xtabs(~Treatment+Improved, data=Arthritis)
fisher.test(mytable)

# Chochran-Mantel-Haenszel test

mytable <- xtabs(~Treatment+Improved+Sex, data=Arthritis)
mantelhaen.test(mytable)

# Listing 7.14 - Measures of association for a two-way table

library(vcd)
mytable <- xtabs(~Treatment+Improved, data=Arthritis)
assocstats(mytable)


# Listing 7.15 - converting a table into a flat file via table2flat

table2flat <- function(mytable) {
    df <- as.data.frame(mytable)
    rows <- dim(df)[1]
    cols <- dim(df)[2]
    x <- NULL
    for (i in 1:rows) {
        for (j in 1:df$Freq[i]) {
            row <- df[i, c(1:(cols - 1))]
            x <- rbind(x, row)
        }
    }
    row.names(x) <- c(1:dim(x)[1])
    return(x)
}

# Listing 7.16 - Using table2flat with published data

treatment <- rep(c("Placebo", "Treated"), 3)
improved <- rep(c("None", "Some", "Marked"), each = 2)
Freq <- c(29, 13, 7, 7, 7, 21)
mytable <- as.data.frame(cbind(treatment, improved, Freq))
mydata <- table2flat(mytable)
head(mydata)

# Listing 7.17 - Covariances and correlations

states <- state.x77[, 1:6]
cov(states)
cor(states)
cor(states, method="spearman")

x <- states[, c("Population", "Income", "Illiteracy", "HS Grad")]
y <- states[, c("Life Exp", "Murder")]
cor(x, y)

# partial correlation of population and murder rate, controlling
# for income, illiteracy rate, and HS graduation rate

library(ggm)
pcor(c(1, 5, 2, 3, 6), cov(states))

# Listing 7.18 - Testing correlations for significance

cor.test(states[, 3], states[, 5])

# Listing 7.19 - Correlation matrix and tests of significance via corr.test

library(psych)
corr.test(states, use = "complete")

# --Section 7.4--

# independent t-test

library(MASS)
t.test(Prob ~ So, data=UScrime)

# dependent t-test

library(MASS)
sapply(UScrime[c("U1", "U2")], function(x) (c(mean = mean(x), 
    sd = sd(x))))
with(UScrime, t.test(U1, U2, paired = TRUE))

# --Section 7.5--

# Wilcoxon two group comparison

with(UScrime, by(Prob, So, median))
wilcox.test(Prob ~ So, data=UScrime)
sapply(UScrime[c("U1", "U2")], median)
with(UScrime, wilcox.test(U1, U2, paired = TRUE))

# Kruskal Wallis test

states <- as.data.frame(cbind(state.region, state.x77))
kruskal.test(Illiteracy ~ state.region, data=states)

# Listing 7.20 - Nonparametric multiple comparisons

class <- state.region
var <- state.x77[, c("Illiteracy")]
mydata <- as.data.frame(cbind(class, var))
rm(class,var)
library(npmc)
summary(npmc(mydata), type = "BF")
aggregate(mydata, by = list(mydata$class), median)
