
##04-ordered-and-unordered-factors


##Sample
	> state <- c("tas", "sa", "qld", "nsw", "nsw", "nt", "wa", "wa",
	+ "qld", "vic", "nsw", "vic", "qld", "qld", "sa", "tas",
	+ "sa", "nt", "wa", "vic", "qld", "nsw", "nsw", "wa",
	+ "sa", "act", "nsw", "vic", "vic", "act")
	> statef <- factor(state)
	> state
	 [1] "tas" "sa"  "qld" "nsw" "nsw" "nt"  "wa"  "wa"  "qld" "vic" "nsw" "vic"
	[13] "qld" "qld" "sa"  "tas" "sa"  "nt"  "wa"  "vic" "qld" "nsw" "nsw" "wa" 
	[25] "sa"  "act" "nsw" "vic" "vic" "act"
	> statef
	 [1] tas sa  qld nsw nsw nt  wa  wa  qld vic nsw vic qld qld sa  tas sa  nt 
	[19] wa  vic qld nsw nsw wa  sa  act nsw vic vic act
	Levels: act nsw nt qld sa tas vic wa
	> levels(statef)
	[1] "act" "nsw" "nt"  "qld" "sa"  "tas" "vic" "wa" 
	> 
##factor()函数
	> sex <- c("M","F","M","M", "F");sex
	[1] "M" "F" "M" "M" "F"
	> sexf <- factor(sex); sexf
	[1] M F M M F
	Levels: F M
	> 
##factor()将一个向量编码成一个因子
	> 
	> 
##tapply() 函数
	> incomes <- c(60, 49, 40, 61, 64, 60, 59, 54, 62, 69, 70, 42, 56,
	+ 61, 61, 61, 58, 51, 48, 65, 49, 49, 41, 48, 52, 46,
	+ 59, 46, 58, 43)
	> incomes
	 [1] 60 49 40 61 64 60 59 54 62 69 70 42 56 61 61 61 58 51 48 65 49 49 41 48
	[25] 52 46 59 46 58 43
	> incmeans <- tapply(incomes, statef, mean)
	> imcmeans
	Error: object 'imcmeans' not found
	> incmeans
		 act      nsw       nt      qld       sa      tas      vic       wa 
	44.50000 57.33333 55.50000 53.60000 55.00000 60.50000 56.00000 52.25000 
	> stderr <- function(x) sqrt(var(x)/length(x))
	> incster <- tapply(incomes, statef, stderr);incster
		 act      nsw       nt      qld       sa      tas      vic       wa 
	1.500000 4.310195 4.500000 4.106093 2.738613 0.500000 5.244044 2.657536 
	> 
##gl()函数
###gl(n, k, length = n*k, labels = 1:n, ordered = FALSE)
	> gl(3,5)
	 [1] 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3
	Levels: 1 2 3
	> gl(3,1,15)
	 [1] 1 2 3 1 2 3 1 2 3 1 2 3 1 2 3
	Levels: 1 2 3
	> 
