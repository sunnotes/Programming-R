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
