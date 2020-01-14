##################################################
##################################################
#tutorial R code for the introduction to R course
#section: 2.data analysis
#institution: University of Oxford
#year: 2020
##################################################
##################################################

#if not already done, set working directory for your machine, using the location of the folder `tutorial`.
#In addition to importing, exporting, and managing data, R is a power tool to analyse data.
#In this section, we will explore few analytical functionalities of R.

#0. Clean the environment
#Run the following line to remove the objects created in the previous session
rm(list=ls()) 

#1. FIRST EXERCISE 
#Run the following lines, read the comments, and answer the questions.
setwd("/home/user/Desktop/Oxford/Crash_Courses/R")
df <- read.csv("./data/mtcars.csv")
library(Hmisc)
describe(df)

#You have used the command `describe` from the package `Hmisc`.
#As you can see, some commands (like `describe`) are not available in the basic packages in R.
#Additional commands can be available after installing and loading new packages on your machine.

#QUESTIONS:
# a) Based on the ouput in the Console, how many observations and missing values count the variable `am`?
#(Tip: look at the variable `am`, in the `n` and `missing` section of the output) 
# b) How many cars have an engine with exactly 4 cylinders?
#(Tip: look at the variable `cyl`, in the `Frequency` section of the output) 

#2. SECOND EXERCISE 
#Run the following lines, read the comments, and answer the questions. 
#(Tip: to run the following code lines all at once, keep left-click before 
#the first line of code, scrool down over the code lines below, and press Ctrl+Enter)
par(mfrow=c(1,4))
plot(df$mpg, df$hp, main="miles per gallon vs horsepower")
hist(df$wt,main="weight")
boxplot(df$hp, main="Boxplot of horsepower")
plot(df$mpg,df$hp, type="p", pch="*", col="red",xlab="miles per gallon",
     ylab="horsepower", main="miles per gallon vs horsepower")
# The output consists of 4 plots based on the `mtcars` dataset.
# Note that in the final plot points are represented by red stars.

# Questions:
# a) What if you want to have 4 rows and 1 column instead of 4 columns and 1 row for the plot output?
#(Tip: change the values `(1,4)` to `(4,1)` in `par(mfrow=c(1,4))` and re-run the lines.)

# b) Modify the plots (color, type, line width) and observe the results.
#(Tip: you can find help here: https://www.statmethods.net/advgraphs/parameters.html)
# c) (Optional): add a trend line (in red) on the first plot. 
#(Tip: add the following R code: `abline(lm(df$hp~df$mpg),col="red")` as an additional line
#below the code above and re-run the lines.)

#3. THIRD EXERCISE (LINEAR REGRESSION)

#For further details on the context of the analysis, see p.39 to p.55 of Chapter 3: Bayesian Linear Regression,
#from Wang et al. (2018). Bayesian Regression Modeling with INLA. New York: Chapman and Hall/CRC.
#A copy (pdf) can be found in the folder "tutorial" (Wang.pdf)
#Run the R-code below line by line and comment each line with your observations and answer the questions below.

#load stats, ggplot2, and MASS, brinla, and GGally (If not already installed, see practical 1 for help).
library(stats)
library(ggplot2)
library(GGally)
library(MASS)
library(brinla)

#US air pollution data exploration
load("data/usair.rda")
pairs.chart <- ggpairs(usair[,-1], lower = list(continuous = "cor"), upper = list(continuous = "points", combo = "dot")) + ggplot2::theme(axis.text = element_text(size = 6)) 
pairs.chart
usair.formula1 <-  SO2 ~ negtemp + manuf + wind + precip + days
usair.lm1 <- lm(usair.formula1, data = usair)
round(coef(summary(usair.lm1)), 4)
round(summary(usair.lm1)$sigma, 4)

#Questions:
# a) Describe the dataset (what is the dependent variable, the independent variables,
#which study area is associated with the data,...). Tip: use Table 1 p.42 from Wang et al. (2018)
# b) Which explanatory variables are highly correlated and what potential issues can arise by keeping correlated covariates in a lin. regression model?
#Tip: p.44 from Wang et al. (2018)
# c) What is the model structure and assumptions of the `lm` model?
#Tip: use google to find information on the five key assumptions of `lm` models:
# d) Which variable coefficients are significant at 5% level?

#Predictions
new.data <- data.frame(negtemp = c(-50, -60, -40), manuf = c(150, 100, 400), pop = c(200, 100, 300), wind = c(6, 7, 8), precip = c(10, 30, 20), days = c(20, 100, 40))
predict.lm(usair.lm1, new.data, se.fit = TRUE,interval ="confidence")

#Questions
# e) Describe the data.frame `new.data`. What is the purpose of having this data.frame?
# f) Describe the `$fit` results provided by the function `predict`. What do they represent?
# g) Observe the coding structure used to make predictions. What are the options? Hint: type ?predict.lm and Enter in your Console.
# h) What is the ouptut of the prediction process? 
# i) How is uncertainty represented? 

#Model selection (AIC)
usair.step <- stepAIC(usair.lm1, trace = FALSE)
usair.step$anova
#Final multiple regression model
usair.formula2 <- SO2 ~ negtemp + manuf + wind + precip
usair.lm2 <- lm(usair.formula2, data = usair)
round(coef(summary(usair.lm2)), 4)
plot(usair.lm2)

#Additional questions
# j) Interpret the results of the `lm` process (summary of `usair.lm2`)
# k) how is the stepwise model selection using AIC implemented for `lm` output (`usair.lm1`)?
# l) How can we visually check that the model provides a good fit? Help: https://data.library.virginia.edu/diagnostic-plots/
#additional tips for l):
#res vs fit:  equally spread residuals around a horizontal line
#Q-Q:  residuals should follow a straight line: see https://data.library.virginia.edu/understanding-q-q-plots/
#scale-location:  equally spread residuals around a horizontal line
#res vs lev: look for influential outliers, if outside of the Cook’s distance (high Cook’s distance scores), the cases are influential to the regression results

# m) What the Residuals vs Fitted plot indicates and what patterns are expected for a good model fit?
# n) On the same plot, what are the outliers and what could be the reasons that they are outliers?

#FOURTH EXERCICE: HYPOTHESIS TESTING (FREQUENTIST and PARAMETRIC)
#ONE SAMPLE STUDENT T-TEST
#The null hypothesis of the two-tailed test of the population mean (one sample) can be expressed as follows:
#h0: mu = mu0, where mu0 is a hypothesized value of the true population mean mu.
#Let us define the test statistic t in terms of the sample mean, the sample size and the sample standard deviation s :
#t=(xbar-mu0)/(s/sqrt(n))  
#h0 rejected if t.stat >= t.critical (see code below for more details)

# The code below can be used to perform a one-sample t-test under the following assumptions:
# 1) The data is normally distributed
# 2) Samples are iid
# 3) The population variance is not known.

#If the population variance is known, we can use the Normal distribution.
#If the population variance is unknown-assumed, we should use a Student t-distribution with n-1 degrees of freedom (n is the number of observations). 
#As n tends to infinity t-distribution tends to a Normal, therefore if n is sufficiently large (say > 60) you could approximate the t-distribution with a Normal one.
#Remember that:
#1.Low pvalue: strong empirical evidence against h0
#2.High pvalue: little or 'no' empirical evidence against h0
#Generally, as a rule of thumb results with pvalue < 0.05 can be considered statistically "significant"

# Data to perform the test on
data_vector <- c(63, 75, 84, 58, 52, 96, 63, 55, 76, 83)

# Focus on two-tail z test only for the sake of conciseness (right or left tail t-tests are possible as well of course)
# H0: mu = mu0
# H1: mu != mu0
t.test.twoTails <- function(data, mu0, alpha)
{
  t.stat <- abs((mean(data) - mu0)) / (sqrt(var(data) / length(data)))
  dof <- length(data) - 1
  t.critical <- qt(1-alpha/2, df= dof) 
  p.value <- 2*(1-pt(t.stat, df= dof))
  
  if(t.stat >= t.critical)
  {
    print("Reject H0")
  }
  else
  {
    print("Accept H0")
  }
  print('T statistic')
  print(t.stat)
  print('T critical values')
  print(c(-t.critical,t.critical))
  print('P value')
  print(p.value)
  print("#####################")
  
  return(t.stat)
}

t.test.twoTails(data_vector, 73, 0.6)

#Questions
# a) What can you say about the acceptation/rejection of h0 given the results above?
# b) How is the function `t.test.twoTails` generated in R? Comment on the structure.
#Note the presence of `if` and `else` in the function.
# c) Based on the code, in which condition h0 is accepted?
# d) What is returned by the function (final code line)?
#In general, we use commands from existing packages to run t-tests instead of writing our own functions.
# e) Compare the results with the following command (from the `stats` package)
t.test(data_vector, mu = 73, alternative = 'two.sided')

#TWO-SAMPLE T-TEST
#Student's t-test can be used to compare two samples.
#create a new sample
data_vector2 <- c(10, 45, 49, 70, 73, 88, 4, 35, 48, 108)
#run a two-sample t-test
t.test(data_vector, data_vector2)

#Explore the functionalities of the command `t.test` by typing ??stats::t.test in your console (+Enter)
#Questions
# f) is the variance assumed equal per default between the two samples?
# g) run t.test with the parameter `var.equal = TRUE` and observe the differences in the name of the test and the values of the bounds of the 95% CI
# h) change the parameter `conf.level` to set 0.99 instead of 0.95 CI and comment on the results
# i) optional: if you have more time, explore other tests (non-parametric for example the u-test) you can run in R

#FIFTH EXERCICE: GENERALIZED LINEAR MODELS (GLM)
#please get the context of the analysis by reading pp.71-99 of Chapter 4: Generalized Linear Models,
#from Wang et al. (2018). Bayesian Regression Modeling with INLA. New York: Chapman and Hall/CRC.
#A copy (pdf) can be found in the folder "tutorial" (Wang2018Ch4.pdf)

#Run the R-code below line by line and comment each line with your observations and
#answer the questions below. Note that there are four distinct sections.

#Generalized Linear Models
#BINOMIAL MODEL
#1.Logistic regression with low birth weight data
data(lowbwt, package = "brinla")
#GLM
lowbwt.glm1 <- glm(LOW ~ AGE + LWT + RACE + SMOKE + HT + UI + FTV, data=lowbwt, family=binomial())
round(coef(summary(lowbwt.glm1)), 4)
lowbwt.glm2 <- glm(LOW ~ LWT + RACE + SMOKE + HT + UI, data=lowbwt, family=binomial())
#Compare the AIC for two models
c(lowbwt.glm1$aic, lowbwt.glm2$aic)

#Questions
# a) In which context GLM is usefeul? 
#Tip: read introduction p. 71 (Wang et al.,2018)
# b) Describe a model from the exponential family for (i) a binary response and (ii) a count response.
# c). What are the components of the GLM model?
#Tip: read p. 73 (Wang et al. 2018)
# d). What is the (canonical) link function and its inverse for a Poisson model? 
# e). What is the (canonical) link function and its inverse for a Bernoulli model? 
#Tip: read p. 71-73 (Wang et al. 2018)
# f) Explore the data `lowbt`. What indicates each variable and the response?
#Tip: read p. 74 Table 4.2 (Wang et al. 2018)
# g) What is the goal (qualitative) of the logistic regression?
# h) Which variable coefficients are significant (5% level) with the `glm` approach.
# i) How do you compute the odd ratios of the predictors in a Bernoulli model? 
# j) What is the interpretation of getting a significant (5% level) coefficient `LWT=-0.0176`? 
#Tip: read p. 75 (Wang et al. 2018)
# k). What model is favoured according to the AIC results?

#POISSON MODEL
#Analysis of Australia AIDS Data
data(AIDS, package = "brinla")
# Plot the data
par(mfrow=c(1,2))
plot(DEATHS ~ TIME, data=AIDS, ylim=c(0,60))
hist(AIDS$DEATHS, xlab="DEATHS", main="")
#Poisson model 
AIDS.glm1 <- glm(DEATHS ~ TIME, family=poisson(), data=AIDS) 
round(coef(summary(AIDS.glm1)), 4)
#Plot results
par(mfrow = c(1,1))
plot(DEATHS ~ TIME, data=AIDS, ylim=c(0,60))
lines(AIDS$TIME, AIDS.glm1$fitted.values, lwd=2)
# Poisson Regression with transformed TIME
AIDS.glm2 <- glm(DEATHS ~ log(TIME), family=poisson(), data=AIDS) 
round(coef(summary(AIDS.glm2)), 4)
#compare AIC
c(AIDS.glm1$aic, AIDS.glm2$aic)

# Plot the results
par(mfrow = c(1,1))
plot(DEATHS ~ log(TIME), data = AIDS, ylim=c(0,60))
lines(log(AIDS$TIME), AIDS.glm1$fitted.values, lwd=2)

#Questions
# a) What is the difference between a binary and a count data?
# b) What are potential issues in using an ordinary linear regression to fit count data?
#Tip read p. 76 (Wang et al. 2018)
# c) Describe the relationship between the mean and the variance in a Poisson model
# d) Explore the data `AIDS` and describe the variables
#Tip read p. 77 Table 4.3 (Wang et al. 2018)
# e) What the histogram suggests about the distribution of the values of `Deaths`?
# f) Which model (with `TIME` vs with log(`TIME`)) is preferred according to the `AIC` values?


#Analysis of Rate Data with Car Insurance claims
data(Insurance, package = "MASS")
#GLM Poisson	
insur.glm <- glm(Claims ~ District + Group + Age + offset(log(Holders)), data = Insurance, family = poisson)
round(summary(insur.glm)$coefficients, 4)
#Residual plots
plot.new()
par(mfrow=c(2,2))
plot(insur.glm)
#Questions
# a) Explore the data Insurance and describe the variables
#Tip: read Table 4.5. and further description p. 85 (Wang et al. 2018)
# b) What is the difference between a count and rate? Why modelling a rate can be of interest?
#Tip: read p. 84 (Wang et al. 2018)
# c) What is the role of the exposure? Why it is logged in the `glm`
#Tip read first and and second equation and description of them in p.85 and p.86 (top) (Wang et al.,2018)
# d) How can we derive that the estimated rate of claims for major city is 26.4% given that
#the estimated coefficient mean for `District4` is 0.234
#Tip: read p. 86 (Wang et al. 2018)
# e) What procedure can be run to check the validation of a Poisson model? Interpret the results of the plot of `insur.glm`


##################################################
##################################################
#end of section 2.data analysis
##################################################
##################################################

