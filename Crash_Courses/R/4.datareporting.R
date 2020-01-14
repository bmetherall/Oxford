##################################################
##################################################
#tutorial R code for the introduction to R course
#section: 4.data reporting
#institution: University of Oxford
#year: 2020
##################################################
##################################################

#0. Clean the environment
#Run the following line to remove the objects created in the previous session
rm(list=ls()) 

#1. FIRST EXERCISE 
#We will run a linear regression of horsepower on miles per gallon using the `mtcars` dataset and export the results.
#Run the following line, read the comments, and answer the questions. 

df <- read.csv("data/mtcars.csv")
regresult<-lm(mpg ~ hp, data = df)
stargazer::stargazer(regresult, type = "latex",style="aer",title = "Regression summary table")

# Questions:
# a) What is the `stargazer` package for?
# b) What is the `style` option for? Try another style and observe the results.
# c) Replace the standard error (given in parentheses) by confidence intervals and compare the results.
#(Tip: add the option `CI=TRUE` as an additional argument. More info, type `??stargazer` in your Console and press `Enter` 
# d) What means `::` in the code above? Is it useful? Why? Can we apply this to other command?
# e) Open the online LaTeX editor: https://latexbase.com/ (or any other LaTeX editor of your choice) and copy and paste the LaTeX output 
#anywhere between `\maketitle` and `\end{document}` and visualise the results.

#2. SECOND EXERCISE 
#We will generate a scientific report, which can include R code.
#Run the following lines, read the comments, and answer the questions. 
library(rticles)
library(rmarkdown)
rmarkdown::render("PLOStemplate/PLOStemplate.Rmd")
#If successful, a pdf has been generated in the folder tutorial/PLOStemplate from the `PLOStemplate.Rmd`` file
#Note that you need a LaTeX compiler. If needed, you can install tinytex (not tested yet but it should work).
#To do so, uncomment and run the following lines to install it:
#install.packages("tinytex")
#tinytex::install_tinytex()  # install TinyTeX


# Questions:
# a) Open the file `PLOStemplate.Rmd` located in the folder `PLOStemplate`
#Try to understand the structure of the file, especially how R code chuncks are inserted.
#Consult the `rmarkdown-cheatsheet.pdf` (especially section `Embed code`).

# b) Amend PLOStemplate.Rmd to create your own report.
#It should include (at least) the following elements:
#   - your subject title, name, date of the day
#   - data import
#   - brief statistical analysis of the data
#   - plot(s)
#   - brief discussion of the results
#   - your own bibliography (amend the file `mybibfile.bib`)
#(Tip: shortcut to generate the pdf from PLOStemplate.Rmd, open PLOStemplate.Rmd
#and use the knit function with shortcut: Control+shift+k (see section `Render` in the `rmarkdown-cheatsheet.pdf`)


##################################################
##################################################
#end of section 4.data reporting
##################################################
##################################################
