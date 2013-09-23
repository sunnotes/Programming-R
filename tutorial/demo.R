# TODO: Add comment
# 
# Author: EASON
###############################################################################

prime<-function(n)
{
	prime1<-function(x)
	{
		y<-TRUE
		for(i in (x%/%2):2)
		{
			if(x%%i==0) y=FALSE
			if(x==2 | x==3) y=TRUE
		}
		y
	}
	x<-c()
	for (i in 2:n)
	{
		if(prime1(i)) x<-c(x,i)
		if(i==n) return(x)
	}
}
prime(100)
prime(1000)


mean(abs(rnorm(100)))

mean(rnorm(100))

rnorm(100)





x <- data.frame(matrix (1:30,nrow = 5 , byrow = T) )
dim( x )
print ( x )
new.x1 <- x[-c ( 1, 4 ) , ] #row
new.x2 <- x[,-c(2,3)] # col
new.x1;new.x2



x <- array ( 1:24 , 2:4 )
x





year <- 1995:2005
x1 <- data.frame ( year , GDP = sort ( rnorm( 11 , 1000 , 100 ) ) )
x2 <- data.frame ( year , UR = rnorm( 11 , 5 , 1 ) )
par (mar = c ( 5 , 4 , 4 , 6 )+0.1 )
plot ( x1 , axes = FALSE, type="l")
axis ( 1 , at = year , label = year ) ; axis( 2 )
par (new = T, mar = c ( 10 , 4 , 10 , 6 ) + 0.1 )
plot ( x2 , axes = FALSE, xlab = "" , ylab = "" , col = "red" , type= "b")
mtext ("UR(%)" , 4 , 3 , col="red")
axis ( 4 , col ="red" , col . axis = "red")

x<-c(0.10, 0.11, 0.12, 0.13, 0.14, 0.15,
       0.16, 0.17, 0.18, 0.20, 0.21, 0.23)
y<-c(42.0, 43.5, 45.0, 45.5, 45.0, 47.5,
       49.0, 53.0, 50.0, 55.0, 55.0, 60.0)

lm.sol<-lm(y ~ 1+x)
summary(lm.sol)



