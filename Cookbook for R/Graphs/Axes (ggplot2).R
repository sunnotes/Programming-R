library(ggplot2)

bp <- ggplot(PlantGrowth, aes(x=group, y=weight)) + geom_boxplot()
bp


##Swap x and y axes (make x vertical, y horizontal):
  
  bp + coord_flip()


###Discrete axis

#Changing the order of items

# Manually set the order of a discrete-valued axis
bp + scale_x_discrete(limits=c("trt1","trt2","ctrl"))

# Reverse the order of a discrete-valued axis
# Get the levels of the factor
flevels <- levels(PlantGrowth$group)
# "ctrl" "trt1" "trt2"
# Reverse the order
flevels <- rev(flevels)
# "trt2" "trt1" "ctrl"
bp + scale_x_discrete(limits=flevels)

# Or it can be done in one line:
bp + scale_x_discrete(limits = rev(levels(PlantGrowth$group)) )



#Setting tick mark labels

#For discrete variables, the tick mark labels are taken directly from levels of the factor. However, sometimes the factor levels have short names that aren't suitable for presentation.

bp + scale_x_discrete(breaks=c("ctrl", "trt1", "trt2"), labels=c("Control", "Treat 1", "Treat 2"))


# Hide x tick marks, labels, and grid lines
bp + scale_x_discrete(breaks=NULL)

# Hide all tick marks and labels (on X axis), but keep the gridlines
bp + theme(axis.ticks = element_blank(), axis.text.x = element_blank())





##Continuous axis

##Setting range and reversing direction of an axis

##Note that if any scale_y_continuous command is used, it overrides any ylim command, and the ylim will be ignored.

# Set the range of a continuous-valued axis
# These are equivalent
bp + ylim(0,8)
bp + scale_y_continuous(limits=c(0,8))




#If the y range is reduced using the method above, the data outside the range is ignored. This might be OK for a scatterplot, but it can be problematic for the box plots used here. For bar graphs, if the range does not include 0, the bars will not show at all!
  
#  To avoid this problem, you can use coord_cartesian instead. Instead of setting the limits of the data, it sets the viewing area of the data.

# These two do the same thing; all data points outside the graphing range are dropped,
# resulting in a misleading box plot
bp + ylim(5, 7.5)
bp + scale_y_continuous(limits=c(5, 7.5))

# Using coord_cartesian "zooms" into the area
bp + coord_cartesian(ylim=c(5, 7.5))

# Specify tick marks directly
bp + coord_cartesian(ylim=c(5, 7.5)) + 
  scale_y_continuous(breaks=seq(0, 10, 0.25))  # Ticks from 0-10, every .25



# Reverse order of a continuous-valued axis
bp + scale_y_reverse()



##Setting and hiding tick markers

# Setting the tick marks on an axis
# This will show tick marks on every 0.25 from 1 to 10
# The scale will show only the ones that are within range (3.50-6.25 in this case)
bp + scale_y_continuous(breaks=seq(1,10,1/4))

# The breaks can be spaced unevenly
bp + scale_y_continuous(breaks=c(4, 4.25, 4.5, 5, 6,8))

# Suppress ticks and gridlines
bp + scale_y_continuous(breaks=NULL)

# Hide tick marks and labels (on Y axis), but keep the gridlines
bp + theme(axis.ticks = element_blank(), axis.text.y = element_blank())



#Axis transformations: log, sqrt, etc.

#By default, the axes are linearly scaled. It is possible to transform the axes with log, power, roots, and so on.

#There are two ways of transforming an axis. One is to use a scale transform, and the other is to use a coordinate transform. With a scale transform, the data is transformed before properties such as breaks (the tick locations) and range of the axis are decided. With a coordinate transform, the transformation happens after the breaks and scale range are decided. This results in different appearances, as shown below.

# Create some noisy exponentially-distributed data
set.seed(201)
n <- 100
dat <- data.frame(xval = (1:n+rnorm(n,sd=5))/20, yval = 2*2^((1:n+rnorm(n,sd=5))/20))

# A scatterplot with regular (linear) axis scaling
sp <- ggplot(dat, aes(xval, yval)) + geom_point()
sp

# log2 scaling of the y axis (with visually-equal spacing)
library(scales)     # Need the scales package
sp + scale_y_continuous(trans=log2_trans())

# log2 coordinate transformation (with visually-diminishing spacing)
sp + coord_trans(y="log2")



#With a scale transformation, you can also set the axis tick marks to show exponents.

sp + scale_y_continuous(trans = log2_trans(),
                        breaks = trans_breaks("log2", function(x) 2^x),
                        labels = trans_format("log2", math_format(2^.x)))


#A couple scale transformations have convenience functions: scale_y_log10 and scale_y_sqrt (with corresponding versions for x).

set.seed(205)
n <- 100
dat10 <- data.frame(xval = (1:n+rnorm(n,sd=5))/20, yval = 10*10^((1:n+rnorm(n,sd=5))/20))

sp10 <- ggplot(dat10, aes(xval, yval)) + geom_point()

# log10
sp10 + scale_y_log10()

# log10 with exponents on tick labels
sp10 + scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                     labels = trans_format("log10", math_format(10^.x)))



##Fixed ratio between x and y axes

#It is possible to set the scaling of the axes to an equal ratio, with one visual unit being representing the same numeric unit on both axes. It is also possible to set them to ratios other than 1:1.

# Data where x ranges from 0-10, y ranges from 0-30
set.seed(202)
dat <- data.frame(xval = runif(40,0,10), yval = runif(40,0,30))
sp <- ggplot(dat, aes(xval, yval)) + geom_point()

# Force equal scaling
sp + coord_fixed()

# Equal scaling, with each 1 on the x axis the same length as y on x axis
sp + coord_fixed(ratio=1/3)



#Axis labels and text formatting

#To set and hide the axis labels:
  
  bp + theme(axis.title.x = element_blank()) +   # Remove x-axis label
  ylab("Weight (Kg)")                    # Set y-axis label

# Also possible to set the axis label with the scale
# Note that vertical space is still reserved for x's label
bp + scale_x_discrete(name="") +
  scale_y_continuous(name="Weight (Kg)")