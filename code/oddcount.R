#counts number

oddcount <- function(x){
  k <- 0 #init
  for( i in x){
    if(i%%2 == 1){
      k <- k+1
    }      
  }
  return (k)
}

oddcount(c(1,3,5))

oddcount(c(1,3,5,6.345))