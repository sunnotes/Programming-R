# Encoding: utf8

library(hash)

list1.insert.test <- function(len) {
  a <- list()
  res <- system.time({
    for(i in 1:len)
      a[[as.character(i)]] <- i
  })
  res[3]
}

list2.insert.test <- function(len) {
  a <- list()
  res <- system.time({
    for(i in 1:len)
      a <- c(a,i)
    names(a) <- 1:len
  })
  res[3]
}

hash.insert.test <- function(len) {
  a <- hash()
  res <- system.time({
    for(i in 1:len)
      a[[as.character(i)]] <- i
  })
  clear(a)
  res[3]
}

list.select.test <- function(len) {
  a <- hash(1:len,1:len)
  b <- as.list(a)
  clear(a)
  x <- names(b)
  res <- system.time({ invisible(sapply(x,
                                        function(i) {
                                          b[[i]]
                                        }))
  })
  res[3]
}

hash.select.test <- function(len) {
  a <- hash(1:len,1:len)
  x <- keys(a)
  res <- system.time({ invisible(sapply(x,
                                        function(i) {
                                          a[[i]]
                                        }))
  })
  clear(a)
  res[3]
}

run.test <- function(fun, x, .progress='text') {
  require(plyr)
  laply(x,fun,.progress=.progress)
}

### ------ Main ------
x <- c(10,100,200,300,400,500,600,800,1000,1500,2000,3000,4000,5000,7000,10000,15000,20000,30000)
list1.insert.time <- run.test(list1.insert.test, x)
list2.insert.time <- run.test(list2.insert.test, x)
hash.insert.time <- run.test(hash.insert.test, x)
p <- par(mfrow=c(1,2))
plot(x, list1.insert.time, type='l', 
     col='red',lty=1,
     ylim=range(c(list1.insert.time,list2.insert.time,hash.insert.time)),
     main='Time Comparison: Insert',
     xlab='Element Length',ylab='Time (seconds)')
lines(x, list2.insert.time, col='cyan', lty=2)
lines(x, hash.insert.time, col='blue', lty=3)
legend('topleft', c('list1','list2','hash'), col=c('red','cyan','blue'), lty=c(1,2,3))

list.select.time <- run.test(list.select.test, x)
hash.select.time <- run.test(hash.select.test, x)
plot(x, list.select.time, type='l',
     col='red',lty=1,
     ylim=range(c(list.select.time,hash.select.time)),
     main='Time Comparison: Select',
     xlab='Element Length',ylab='Time (seconds)')
lines(x, hash.select.time, col='blue', lty=2)
legend('topleft', c('list','hash'), col=c('red','blue'), lty=c(1,2))
par(p)
