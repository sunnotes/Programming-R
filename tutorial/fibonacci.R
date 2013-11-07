fib <- function(n)
{
  ifelse(n < 2, n, fib(n - 1) + fib(n - 2))
}
system.time(fib(25))


fib2 <- function(n)
{
  if(n < 2) n else Recall(n-1) + Recall(n-2)
}
system.time(fib2(25))


library(compiler)
enableJIT(3)
fib3 <- cmpfun(fib2)
system.time(fib3(25))



require(inline)
incltxt <- '
int fibonacci(const int x) {
if (x == 0) return(0);
if (x == 1) return(1);
return (fibonacci(x - 1)) + fibonacci(x - 2);
}'
fibRcpp <- cxxfunction(signature(xs="int"),
                       plugin="Rcpp",
                       incl=incltxt,
                       body='
                       int x = Rcpp::as<int>(xs);
                       return Rcpp::wrap( fibonacci(x) );
                       ')
start <- Sys.time()
fibRcpp(25)
end <- Sys.time()
end - start



library(gmp)
start <- Sys.time()
fibnum(25)
end <- Sys.time()
end - start



fibonacci <- local({                      
  memo <- c(1, 1, rep(NA, 100))           
  f <- function(x) {                      
    if(x == 0) return(0)                  
    if(x < 0) return(NA)                  
    if(x > length(memo))                  
      stop("’x’ too big for implementation")
    if(!is.na(memo[x])) return(memo[x])   
    ans <- f(x-2) + f(x-1)                
    memo[x] <<- ans                       
    ans                                     
  }                                         
})                                        
start <- Sys.time()                       
fibonacci(25)                             
end <- Sys.time()                         
end - start       