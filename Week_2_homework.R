# Homework 2
set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)
hw2
##  [1] 31.697246 12.972021 48.457102        NA 20.885307 49.487524 41.498897 15.682545
##  [9] 35.612619 42.245735  8.814791        NA 27.418158 36.504914 43.666428 42.722117
## [17] 24.582411 48.374680 10.494605 39.728776 40.971460        NA 20.447903  6.668049
## [25] 30.024323 34.314318        NA 10.825658 46.676823 25.913006 26.933701 15.810164
## [33] 26.616794  9.403891 27.589087 34.262403  9.591257 27.733004 17.877330 38.975078
## [41] 46.102046 25.041810 46.369401 15.919465 19.813791 23.741937 19.192818 38.630297
## [49] 42.819312  4.500130


# Function IS.NA ( The function is.na(vector) indicates which elements are missing in the data 

is.na(hw2)

#Creating a new vector without NA (note that the ! sign invert the meaning of the function)

hw2_without_NA <- hw2[!is.na(hw2)]


#Selecting all the numbers between 14 to 38
prob1<-hw2_without_NA[hw2_without_NA>=14 & hw2_without_NA<=38]


prob1

times3<-prob1*3
plus10<-c(times3+10)
times3
plus10
hw2
plus10
ANSWER<-plus10[c(TRUE,FALSE)]
ANSWER
