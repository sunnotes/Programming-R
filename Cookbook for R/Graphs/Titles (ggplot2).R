#An example graph without a title:
  
  library(ggplot2)
bp <- ggplot(PlantGrowth, aes(x=group, y=weight)) + geom_boxplot()
bp
  
  
  bp + ggtitle("Plant growth")
  # Equivalent to
  bp + labs(title="Plant growth")
  
  # If the title is long, it can be split into multiple lines with \n
  bp + ggtitle("Plant growth with\ndifferent treatments")
  
  # Reduce line spacing and use bold text
  bp + ggtitle("Plant growth with\ndifferent treatments") + 
    theme(plot.title = element_text(lineheight=.8, face="bold"))