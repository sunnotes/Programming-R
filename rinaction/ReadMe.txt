Source code for R in Action
2011 - Copyright: Manning Publications. All rights reserved.

This directory contains the source code for chapters 1 through 16.

Many chapters require the installation of contributed packages.
These are indicated in the header of the corresponding code file.

For example, the code in chapter 3 requires that you have the
Hmisc package installed. If you don't have this package installed, 
execute the command
    install.packages("Hmisc")
    
You will also find that packages may be loaded more than once in
a file. For example, in the chapter 6 code file, the statement
    "library(vcd)" 
is repeated several times. It is actually only needed once. 

However, placing it in several places allows you run a portion
of the file's code without having to run all the code from the beginning. 
    
I hope you find this code helpful and welcome your feedback.

-Rob Kabacoff, Ph.D.
robk@statmethods.net