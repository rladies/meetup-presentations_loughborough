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



#### example of skewed distrbution (Poisson)



#### Comparing blood pressure before and after relaxation intervention - Paired t test
### Hypothesis - blood pressure will be lower after the relaxation intervention

##View the dataset
View(blood_pressure)

##Observe normality for each column using a histogram
## hist(dataset$column name)



#### statistical test for normality 
## shapiro-wilk test for data with <50 cases
## shapiro.test(variable)



#### paired t test 
## t.test(first variable, second variable, paired=TRUE)
## look for p<0.05 



## Look at means to confirm
## colMeans(dataset)





#### Unpaired t test
#### Comparing mean record sales between 2 genres
View(record_sales)

# histograms on top of each other to show variance and normality


#### statistical test for normality 


#### statistical test for homogeneity of variance
## leveneTest(dependent variable, grouping variable, center = mean)
## if normality test is significant use center = median


#### between groups
#### data should have 2 columns, grouping variable and data set
## t.test(first variable, second variable, paired=FALSE, var.equal=TRUE)
# if levene's test is significant, use var.equal=FALSE (this is the default)







