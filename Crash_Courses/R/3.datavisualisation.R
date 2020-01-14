##################################################
##################################################
#tutorial R code for the introduction to R course
#section: 3.data visualisation
#institution: University of Oxford
#year: 2020
##################################################
##################################################

#0. Clean the environment
#Run the following line to remove the objects created in the previous session
rm(list=ls()) 

#A.FIRST EXERCISES

################################Ch.A1 Bar plot#######################################
####################################################################################


#load a library used in this tutorial
library(corrplot)
#some warning messages - although in red - can be ignored. They only indicate that a package is built under a specific version of R 
#1.2. Explore the dataset mtcars by running the following line
?mtcars #tip: to run a line, click left anywhere on a code line and press "ctrl+Enter" for PC, "command+Enter" for MAC). 
#A description of the dataset is given in the Help tab, bottom-right of R studio.

#run the following line to get more information on the variables (columns) and observations (rows)
head(mtcars)

#1.3 Aggregate the data
Numbers<-table(mtcars$cyl,mtcars$gear)
Numbers
#what is the result of the table command applied to two columns of mtcars?
#tips: 'table' is a function used to aggregate data

#1.4. Make your first bar plot
barplot(Numbers,main='Automobile cylinder number grouped by number of gears', 
        col=c('red','orange','steelblue'),legend=rownames(Numbers),xlab='Number of Gears',ylab='count')
#run the following line to get more information on barplot (select Bar Plots when you get the info on the Help menu)
?barplot
#customize the plot (e.g. change the filling color of the bar, plot horizontally, remove the axes,....)

#1.5. Save your final barplot (feel free to customize the code lines below) as a pdf and png file

#save your plot as pdf
pdf("mybarplot.pdf")# this line is used to indicate that the plot will be saved as a pdf file.
barplot(Numbers,main='Automobile cylinder number grouped by number of gears', 
        col=c('red','orange','steelblue'),legend=rownames(Numbers),xlab='Number of Gears',ylab='count')
dev.off()#important element to close the plot  

#save your plot as png
png("mybarplot.png", width = 450, height = 350)
barplot(Numbers,main='Automobile cylinder number grouped by number of gears', 
        col=c('red','orange','steelblue'),legend=rownames(Numbers),xlab='Number of Gears',ylab='count')
dev.off()
#a) where are the plots saved?
#tips: check where is your working directory by running the following line
getwd()
#this is where your plots are saved if not indicated otherwise
#customize the way you save your plot (size, location) and save your final choices
#tip: run ?pdf and also ?png to get more info on the plot options 

################################Ch.A2 Histogram##########################################################################################################################

#2.1. Plot the histogram of frequency of ozone values in 'airquality' dataset
hist(airquality$Temp,col='steelblue',main='Maximum Daily Temperature',
     xlab='Temperature (degrees Fahrenheit)')

#2.2. We would prefer having an histogram with values degrees Celsius instead of degrees Fahrenheit. 
#a) Transform the values of temperature in degree Celsius and replot your histogram.
#tip: The temperature in degrees Celsius is equal to the temperature in degrees Fahrenheit minus 32, times 5/9. Therefore, you can add the new temperature in the dataframe "airquality", for example by running: airquality$TCelsius <-  airquality$Temp....

#2.3. Let's compare the two histograms. 
#a) Plot them next to each other.
#Tip: look at the some tips for the layout of plots from this website: https://www.statmethods.net/advgraphs/layout.html. In addition, make sure that you also amend the labels accordingly.


################################Ch.A3 Box plot#########################################################################################################################

#Here you will learn how to make box plot, which allows you to visualise some useful statistics of the data

#3.1.Run the following lines
mtcars<-transform(mtcars,cyl=factor(cyl))# convert 'cyl' column from class 'numeric' to class 'factor'
class(mtcars$cyl)# 'cyl' is now a categorical variable 
par(mfrow=c(1,1))#back to the original graphic layout
boxplot(mpg~cyl,mtcars,xlab='Number of Cylinders',ylab='miles per gallon',
        main='miles per gallon for varied cylinders in automobiles',cex.main=1.2)
#a) How is the relationship between the number of cylinders and the number of miles per gallon? Is it what you expect?

#############################Ch.A4 Correlogram#########################################################################################################################

#4.1. Plot the correlation among several variables
mtcars$cyl<-as.numeric(mtcars$cyl)#make variable cylinder numerical
#get correlation coefficients
corr_matrix <- cor(mtcars)
#generate disks of different sizes and colours
corrplot(corr_matrix)
#what is the meaning of the disk size and colours?

#4.2. plot the correlation with numbers and a lower matrix matrix
corrplot(corr_matrix,method = 'number',type = "lower")
#what is the meaning of the numbers and colours?

#END A.FIRST EXERCISES
################################################################################
################################################################################



#B.SECOND EXERCISES

##########################Ch.B1 Basics of ggplot#####################################
####################################################################################

#load required libraries (already installed in Rvisu1.R)
library(tidyverse)#don't worry if it is indicated in the console that there are conflicts between packages, this cannot be avoided. However, it will not create issues for this tutorial.
library(ggplot2)
library(gridExtra)

#1.2. Setup
#Unlike base graphics, ggplot doesn't take vectors but uses dataframes as datasource.
#In ggplot, the 'aes()' argument is used for aesthetics. The aesthetics specified will be inherited by all the geometrical layers you will add subsequently.

#IMPORTANT REMARK:#################################################
#No plot will be printed until you add the "geom_layers" (Ch.2)
###################################################################

#1.3. Run the following lines and try observe the Plots tab in RStudio
?diamonds#get information on the data
diamonds<-diamonds# save it as dataframe so you can better visualise it
head(diamonds)#get info on the dataframe
ggplot(diamonds)#prepare a ggplot graphic 
ggplot(diamonds, aes(x=carat))#if only X-axis is known. 
ggplot(diamonds, aes(x=carat, y=price))#if both X and Y axes are fixed for all layers
ggplot(diamonds, aes(x=carat, color=cut))#each category of the 'cut' variable will now have a distinct color, once a layer is added.

#Note that ggplot2 considers the X and Y axis of the plot to be aesthetics as well, along with color, size, shape, fill etc. If you want to have the color, size etc fixed (i.e. not vary based on a variable from the dataframe), you need to specify it outside the aes() like in this example here:
ggplot(diamonds, aes(x=carat), color="steelblue")

##########################Ch.B2 Layers of ggplot#####################################
####################################################################################

#The layers in ggplot2 are also called 'geoms'. Once the base setup is done, you can append the geoms one on top of the other. Check your ggplot cheatsheet to get more info on the layers.

#2.1. Run the following line
plot.new()
ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() 
#We have added one layer: geom_point(). Since the X axis Y axis and the color were defined in ggplot() setup (Ch.1), this layer inherited those aesthetics. 

#2.1. Alternatively, you can specify those aesthetics inside the geom layer also as shown below.
ggplot(diamonds) + geom_point(aes(x=carat, y=price, color=cut)) # Same as above but specifying the aesthetics inside the geoms.

#2.2. From here we can add more layers (smooth function)
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=cut)) + geom_smooth() #in this plot, we added a smooth function based on the entire dataset.

#2.3. We can add a smooth function for each category instead of a global one
ggplot(diamonds, aes(x=carat, y=price)) + geom_point(aes(color=cut)) + geom_smooth(aes(color=cut)) 

#########################Ch.B3 Labels with ggplot####################################
####################################################################################

#Now that you have drawn the main parts of the graph. You might want to add the plot's main title and perhaps change the X and Y axis titles. This can be done using the "labs" layer, used to specify the labels. 

#3.1. Run the following line and try to amend the labels:
gg <- ggplot(diamonds, aes(x=carat, y=price, color=cut)) + geom_point() + labs(title="My scatterplot", x="Carat", y="Price")  # add axis lables and plot title.
print(gg)#we print the plot using print() since we save the object as "gg"
#note that manipulating the size, color of the labels is the job of the 'Theme' (next chapter).

#########################Ch.B4 Themes in ggplot######################################
####################################################################################

#Almost everything is set, except that we want to increase the size of the labels and change the legend title. Adjusting the size of labels can be done using the theme() function. You will be able to set the plot.title, axis.text.x and axis.text.y.

#4.1. Run the following lines and observe the results.
gg1 <- gg + theme(plot.title=element_text(size=30, face="bold"), 
                  axis.text.x=element_text(size=15), 
                  axis.text.y=element_text(size=15),
                  axis.title.x=element_text(size=25),
                  axis.title.y=element_text(size=25)) + 
  scale_color_discrete(name="Cut of diamonds")#change legend title.
print(gg1)# print the plot

#try to modify the theme in order to get your desired font size and type
#you can get predefined themes as well. Explore https://ggplot2.tidyverse.org/reference/ggtheme.html to get more info.

#example with black and white theme
ggbw <- gg + theme_bw()+ 
  scale_color_discrete(name="Cut of diamonds")
print(ggbw)# print the plot

#example with classic theme
ggcl <- gg + theme_classic()+ 
  scale_color_discrete(name="Cut of diamonds")
print(ggcl)# print the plot

#4.2. You can also change the position of the legend
#Run the three examples with different legend specifications and plot them together
#Note the different possibilities to modify the legend
p1 <- gg + theme(legend.position="none") + labs(title="First option")# remove legend
p2 <- gg + theme(legend.position="top") + labs(title="Second option")# legend at top
p3 <- gg + labs(title="Third option") + theme(legend.justification=c(1,0), legend.position=c(1,0))# legend inside the plot.
grid.arrange(p1, p2, p3, ncol=3)#display plots next to each other
#try to make your own customized plots with your favorite theme and legend option.

#########################Ch.B5 Facets in ggplot######################################
####################################################################################

#In the previous chart, you had the scatterplot for all different values of cut plotted in the same chart. What if you want one chart for one cut?

#5.1. Run the following line and observe the results
gg1 + facet_wrap( ~ cut, ncol=3)# columns defined by 'cut'
#get more information on the way you can define facets
?facet_wrap

#5.2. Make 3 plots displayed in 3 rows
gg1 + facet_wrap( ~ cut, nrow=3)

######################Ch.B6 Bar chart in ggplot####################################
####################################################################################

#By default, ggplot makes a 'counts' barchart: it counts the frequency of observations specified by the 'x' aesthetic (in our case, it corresponds to the number of automatic vs manual cars) and plots it. In this format, you don't need to specify the Y aesthetic.
#6.1. Run the following lines and observe the structure of the plotting function
mtcars$am<-as.factor(mtcars$am)#replace numerical by factor value
bar1 <- ggplot(mtcars, aes(x=am)) + geom_bar() + labs(title="Frequency bar chart")  # Y axis derived from counts of X item
print(bar1)

#6.2. Let's add the number of cylinders on the x-axis instead of the artificial names for the category (0 and 1).
bar2 <- ggplot(mtcars, aes(x=am)) + geom_bar() + labs(title="Frequency bar chart")  + scale_x_discrete(name ="gearbox", labels=c("automatic","manual"))
print(bar2)

#6.3. To make a bar chart using the Y aesthetic (a value is provided by a variable rather than being a count), you need to set stat="identity" inside the geom_bar.
df <- data.frame(var=c("a", "b", "c"), nums=c(6,2,8))
df#observe the structure of the dataframe
plot2 <- ggplot(df, aes(x=var, y=nums)) + geom_bar(stat = "identity")
print(plot2)
#make your own barplot by changing the name and values in the dataframe df

######################Ch.B7 Time series in ggplot####################################
####################################################################################

#Plotting timeseries requires that you have your data in dataframe format, in which one of the columns is the dates that will be used for X-axis. In this section, we use another dataset 'economics', which is also part of ggplot2.
data(economics)
economics <- data.frame(economics)#convert to dataframe
head(economics)#gives summary statistics of the dataframe
?economics#gives information on the dataframe

#7.1. Run the following lines to plot your timeseries
ggplot(economics) + geom_line(aes(x=date, y=pce, color="pcs")) + geom_line(aes(x=date, y=unemploy, col="unemploy")) + scale_color_discrete(name="Legend") + labs(title="Economics") # plot multiple time series using 'geom_line's
#what geometric layer is used to plot lines?
#a)How the code is structured so that two time series can be plot on the same graph?
#What is common between the two 'geom_line' in the plot? 

###############################Ch.B8 Save ggplot#####################################
####################################################################################

#An important aspect in R is to save objects. Knowing the options of saving plots in R is useful. Here is how to save your ggplots

#8.1. Save a ggplot in a different format
plot1 <- ggplot(mtcars, aes(x=cyl)) + geom_bar()
ggsave("myggplot.png", plot=plot1)# save plot1 as png file in your working directory
ggsave("myggplot.pdf", plot=plot1)# save plot1 as pdf file in your working directory
ggsave("myggplot.jpg", plot=plot1)# save plot1 as jpg file in your working directory

#8.2. Run the following line to get more info on the ggsave function and customise the saved plot (for example increase the dpi)
?ggsave

#note that to save the final plot displayed in R studio (in our case we named it "myggplot"), you can run the following command: ggsave("myggplot.png") 

#END B.SECOND EXERCISES
################################################################################
################################################################################



#C. THIRD EXERCISES
#############################Animated graphics######################################
####################################################################################

#In this tutorial, you will learn how to create animated graphs using extensions of ggplot2. Do not hesitate to ask questions to your instructor during the exercise. Good luck! 

############################Ch.C1 Gapminder##########################################
####################################################################################

#load librairies used in this section
library(ggplot2)#you can ignore the warning messages indicating that the package has been built under another version of R
library(gapminder)
library(gganimate)
library(gifski)
library(png)
#1.1. Run the following lines and try to understand how the plot has been generated.

gapminder<-gapminder#put the data into dataframe
?gapminder#get more info on this dataset

#static plot
theme_set(theme_bw())
p <- ggplot(
  gapminder, 
  aes(x = gdpPercap, y=lifeExp, size = pop, colour = country)) +
  geom_point(show.legend = FALSE, alpha = 0.7) +
  scale_color_viridis_d() +
  scale_size(range = c(2, 12)) +
  scale_x_log10() +
  labs(x = "GDP per capita", y = "Life expectancy")
p

#1.2. Make a dynamic plot. Run the following lines and try to understand how time element is incorporated into the graphic.
p + transition_time(year) +
  labs(title = "Year: {frame_time}")
#Key R function: transition_time(). The transition length between the states will be set to correspond to the actual time difference between them.
#Label variables: frame_time. Gives the time that the current frame corresponds to.

#1.3. Add facets for each continent
p + facet_wrap(~continent) +
  transition_time(year) +
  labs(title = "Year: {frame_time}")

#1.4. Show preceding frames with gradual falloff
#This shadow is meant to draw a small wake after data by showing the latest frames up to the current. You can choose to gradually diminish the size and/or opacity of the shadow. The length of the wake is not given in absolute frames as that would make the animation susceptible to changes in the framerate. Instead it is given as a proportion of the total length of the animation.
#Run the following lines
p + transition_time(year) +
  labs(title = "Year: {frame_time}") +
  shadow_wake(wake_length = 0.1, alpha = FALSE)

#1.5. Show the original data as background marks
#This shadow lets you show the raw data behind the current frame. Both past and/or future raw data can be shown and styled as you want.
#Run the following lines
p + transition_time(year)  
labs(title = "Year: {frame_time}") +
  shadow_mark(alpha = 0.3, size = 0.5)

#1.6. Time series plot
#static graphic
p <- ggplot(airquality,aes(Day, Temp, group = Month, color = factor(Month))) + geom_line() + scale_color_viridis_d() +
  labs(x = "Day of Month", y = "Temperature") +
  theme(legend.position = "top")
p
#gradually reveal the x-axis
p + transition_reveal(Day)
#add points
p + geom_point() + transition_reveal(Day)
#try to modify the options of gganimate (look for some info on google)
#to get more info on the option on how the x-axis is revealed type:
?transition_reveal

#1.7 Save the last animation:
anim_save("gapmanim.gif",animation=last_animation())

############################Ch.C2 Your graph#########################################
####################################################################################

#Using your own data, try to make a unique graph (animated or not)
#and share your output with your colleagues!
#if you have time and want to discover more on interactive plots, 
#google Rshiny and try to replicate some code. Enjoy!

##################################################
##################################################
#end of section 3.data visualisation
##################################################
##################################################

