# --ggplot2--

# box plots example
library(ggplot2)
mtcars$cylinder <- as.factor(mtcars$cyl)
qplot(cylinder, mpg, data=mtcars, geom=c("boxplot", "jitter"),
      fill=cylinder,
      main="Box plots with superimposed data points",
      xlab= "Number of Cylinders",
      ylab="Miles per Gallon")

# regression example
library(ggplot2)
transmission <- factor(mtcars$am, levels = c(0, 1), 
                       labels = c("Automatic", "Manual"))
qplot(wt, mpg, data = mtcars, 
      color = transmission, shape = transmission, 
      geom = c("point", "smooth"), 
      method = "lm", formula = y ~ x, 
      xlab = "Weight",  ylab = "Miles Per Gallon", 
      main = "Regression Example")

# bubble plot example
library(ggplot2)
mtcars$cyl <- factor(mtcars$cyl, levels = c(4, 6, 8), 
                     labels = c("4 cylinders", "6 cylinders", "8 cylinders"))
mtcars$am <- factor(mtcars$am, levels = c(0, 1), 
                    labels = c("Automatic", "Manual"))
qplot(wt, mpg, data = mtcars, facets = am ~ cyl, size = hp)

# density plot example
library(ggplot2)
data(singer, package = "lattice")
qplot(height, data = singer, geom = c("density"), 
      facets = voice.part ~ ., fill = voice.part)

