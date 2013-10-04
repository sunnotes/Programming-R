#melt(data, id.vars, measure.vars,
#     variable.name = "variable", ..., na.rm = FALSE,
#     value.name = "value")


head(airquality)

dim(airquality)


names(airquality) <- tolower(names(airquality))
aqm <- melt(airquality, id=c("month", "day"), na.rm=TRUE)
head(dcast(aqm, day ~ variable+month))



head(dcast(aqm, month ~ variable, mean, margins = c("month", "variable")))