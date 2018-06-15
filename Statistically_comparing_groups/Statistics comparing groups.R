#### RLadies - comparing means using t tests

### required packages
install.packages("car")
library(car)


### load datasets
### load(file path)
### if you don't know the file path, file -> open then yes you want to load it into the global environment




##### parametric assumptions

### 1. data are independent => to do with research design 
### 2. scale level data - on a numerical scale interval or ratio e.g. temperature or height
### 3. normality - distribution of data is similar to normal/gaussian - can be tested 
### 4. homogeniety of variances - data from different groups have a similar variance


##### normality 
#### example of normal distribution (Gaussian)
y<-rnorm(1000)  ## creates a normally distributed dataset, which will be different each time
h<-hist(y)      ## creates a histogram of the normally distributed data, should see the clear 'bell'-shaped curve

#### example of skewed distrbution (Poisson)
z<-rpois(1000,lambda = 1)   ## creates a non-normally distributed dataset (poisson distribution), which will be different each time
hist(z)                     ## creates a histogram of the non-normally distributed data, no bell shaped curve indicating non-normal



#### Comparing blood pressure before and after relaxation intervention - Paired t test
### Hypothesis - blood pressure will be lower after the relaxation intervention

##View the dataset
View(blood_pressure)

##Observe normality for each column using a histogram
## hist(dataset$column name)
hist(blood_pressure$Pre_BP)
hist(blood_pressure$Post_BP)

#### statistical test for normality 
## shapiro-wilk test for data with <50 cases
## shapiro.test(variable)
shapiro.test(blood_pressure$Pre_BP)
shapiro.test(blood_pressure$Post_BP)

#### paired t test 
## t.test(first variable, second variable, paired=TRUE)
## look for p<0.05 
t.test(blood_pressure$Pre_BP,blood_pressure$Post_BP,paired=TRUE)

## Look at means to confirm
## colMeans(dataset)
colMeans(blood_pressure)


###graph to compare means
library(tidyverse) ## need to adjust the dataset to use ggplot2 
BP<-gather(blood_pressure,"Time","BP",Pre_BP:Post_BP) ## first column now indicates pre/post, second column is blood pressure value
ymin<-c(rep((157.857142857143-8.48398620802875),14),rep((139.642857142857-13.7930146359399),14)) ## mean - standard deviation, for pre and post for error bars 
ymax<-c(rep((157.857142857143+8.48398620802875),14),rep((139.642857142857+13.7930146359399),14)) ## mean + standard deviation
BP<-cbind(BP,ymin,ymax) 
library(ggplot2)      ## graph creating package 
ggplot(BP)+           ### creates bar chart showing means and error bars 
  geom_col(aes(x=Time, y=(BP/14)),fill="skyblue", alpha=0.7)+
  geom_errorbar( aes(x=Time, ymin=ymin, ymax=ymax), width=0.4, colour="orange", alpha=0.9, size=1.3)+
  ylab("Blood Pressure") 



#### Unpaired t test
#### Comparing mean record sales between 2 genres
View(record_sales)

# histograms on top of each other to show variance and normality
hist(record_sales$sales[record_sales$genre=="metal"],col="purple",xlim=c(0,100))
hist(record_sales$sales[record_sales$genre=="reggae"],col="blue",add=TRUE)

#### statistical test for normality 
shapiro.test(record_sales$sales[record_sales$genre=="metal"])
shapiro.test(record_sales$sales[record_sales$genre=="reggae"])

#### statistical test for homogeneity of variance
## leveneTest(dependent variable, grouping variable, center = mean)
## if normality test is significant use center = median
leveneTest(record_sales$sales,record_sales$genre,center = mean)

#### between groups
#### data should have 2 columns, grouping variable and data set
## t.test(first variable, second variable, paired=FALSE, var.equal=TRUE)
# if levene's test is significant, use var.equal=FALSE (this is the default)
t.test(record_sales$sales~record_sales$genre,paired=FALSE,var.equal=TRUE)


###graph to compare means
ymin<-c(rep(mean(record_sales$sales[1:20])-sd(record_sales$sales[1:20]),20),rep(mean(record_sales$sales[21:40])-sd(record_sales$sales[21:40]),20)) ## mean - standard deviation, for pre and post for error bars 
ymax<-c(rep(mean(record_sales$sales[1:20])+sd(record_sales$sales[1:20]),20),rep(mean(record_sales$sales[21:40])+sd(record_sales$sales[21:40]),20)) ## mean - standard deviation, for pre and post for error bars 
RS<-cbind(record_sales,ymin,ymax) 
library(ggplot2)      ## graph creating package 
ggplot(RS)+           ### creates bar chart showing means and error bars 
  geom_col(aes(x=genre, y=(sales/20)),fill="skyblue", alpha=0.7)+
  geom_errorbar( aes(x=genre, ymin=ymin, ymax=ymax), width=0.4, colour="orange", alpha=0.9, size=1.3)+
  ylab("Mean Sales") 




