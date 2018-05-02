# Welcome to the first R-Ladies meetup and our introduction to R!
# In this code, we will look at the basics of R.
# We will start by creating our own objects and then move on to playing with the survey data.
# We finish by using a package.

# Part 1, creating objects

# Assign to object x the value 5
x <- 5

# Assign object x to be a vector of length 5 with elements 1,2,3,4,5
x <- c(1,2,3,4,5)
x <- c(1:5) # the colon means '1 to 5 by 1'
x <- seq(1,5) # seq does the same
x <- seq(2,10,2) # we can set the step to be by 2 or any other number

# Create new vectors y, z, u and v from x
y <- 5*x + 2
z <- y/2 - x
u <- sqrt(z)
v <- z^2

# Extract common summary statistics from x
a <- max(x)
b <- min(x)
c <- sd(x)
d <- mean(x)
e <- sum(x)

# Create objects from particular elements of x
xprime1 <- x[x>4] # elements of x greater than 4
xprime2 <- x[x>=4] # elements of x greater than or equal to 4
xprime3 <- x[x==4] # elements of x equal to 4
xprime4 <- x[x!=4] # elemenets of x not equal to 4
xprime5 <- x[1:3] # values first three elements of x
xprime6 <- x[c(1,3,5)] # values from elements 1, 3 and 5 of x
xprime7 <- x[-(1:3)] # values not in the first three elements of x

# Check what type of vector x is
class(x)
xchar <- as.character(x) # convert to a character vector
xnum <- as.numeric(xchar) # convert back to numeric

# Create a 3x3 matrix M with values 1:9 
M <- array(1:9,dim=c(3,3))

# Look at different elements of M
M
M[1,2] # element in first row, second column
M[3,1] # element in third row, first column
M[,1] # elements in first column
M[,2] # elements in second column
M[1,] # elements in first row

# Create a vector m1 from a column of matrix M
m1 <- M[,1]

# Create a 3x3 matrix N with values 1:9, arranged differently
N <- array(c(1,4,7,2,5,8,3,6,9),dim=c(3,3))

# Create matrices O and P from M and N
O <- M*N # element by element multiplication
O
P <- O+2
P
Omat <- M%*%N # matrix multiplication
Omat

# Transpose M
Mt <- t(M)
Mt

# Use a for loop to make a new matrix that depends on element index of M
Mloop <- matrix(0,3,3) # make a matrix of zeros to send results to
for (i in c(1:9)){ # for loop where an object i iterates from 1 to 9
  Mloop[i] <- M[i]*i # in each iteration, this operation is performed
}

# Use a for loop but now include a condition
Mloop2 <- matrix(0,3,3)
for (i in c(1:9)){
  if (N[i] >= 4){ # the operation within this bracket will only be carried out if the ith element of N is greater than 3
    Mloop2[i] <- M[i]*i
  }
}

# Q: Create 3x3 matrix with values 3 to 15, increasing by 3 each time.
# Try multiplying/dividing/adding/substracting this matrix with matrix M.
# What is the maximum value in your new matrix?

# Part 2, survey data

# Import survey data
surveydata <- read.csv("rladiessurvey.csv")

# Change the names of the columns (variables)
colnames(surveydata) <- c("date","experience","purpose","expectations","sharing","organising","time","duration")

# Create a vector from one of the columns of the dataframe
date <- surveydata$date

# Create a vector with values 1:number of rows in the survey data
uniqueID <- c(1:nrow(surveydata))

# Join the uniqueID vector to the left of the survey data
surveydata <- cbind(uniqueID,surveydata) # uniqueID is now the first column of surveydata

# Check how many responders wanted 1.5h sessions
nrow(surveydata[surveydata$duration=="1.5h",])
table(surveydata$duration) # get counts of all duration choices

# Create a fictional new responder
newresponse <- cbind(15,surveydata[14,-1]) # they have the same responses as responder 14
colnames(newresponse) <- colnames(surveydata) # need to have the same column names as the survey data
surveydata <- rbind(surveydata,newresponse) # join new responder to bottom of survey data, this is now the last row

# Import a new survey dataset with 3 additional fictional 'score' columns
surveydata2 <- read.csv("rladiessurvey2.csv")

# Check what type of columns we have
class(surveydata2$duration)
class(surveydata2$scoreA)

# Take the sum of each row in the three score columns
sumscore <- rowSums(surveydata2[,c(9,10,11)]) # this is a vector with the same length as the survey data
surveydata2 <- cbind(surveydata2,sumscore) # join this vector to right of surveydata2, this is now the last column

# Find the mean and standard deviations of each score column
scoremeans <- colMeans(surveydata2[,c(9,10,11,12)]) # vector of length 4
scoresds <- sapply(surveydata2[,c(9,10,11,12)],sd) # vector of length 4

# Create plots of the data
barplot(table(surveydata2$duration),main="Preferred durations of sessions",xlab="Duration") # bar plot of session duration responses
levels(surveydata2$duration) # check order of levels in duration
surveydata2$duration = factor(surveydata2$duration, levels = c("1h","1.5h","2h")) # reorder
levels(surveydata2$duration)
barplot(table(surveydata2$duration),main="Preferred durations of sessions",xlab="Duration")
hist(surveydata2$sumscore,main="Histogram of total score",xlab="Total score") # histogram of total scores
plot(surveydata2$scoreA,surveydata2$scoreB,main="Plot of score A vs score B",xlab="Score A",ylab="Score B") # scatter plot of score A vs score B

# Q: How many responders said that they had no experience with R?
# What was the total score of responder 12?
# What was the max total score in the data?
# Plot a bar plot of duration for only the first 7 responders

# Part 3, using a package

install.packages("abind") # install the package abind
library(abind) # load the package

# Create a 3x3x2 array from M and N
Q <- abind(M,N,along=3)
