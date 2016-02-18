#LAPPLY practice

x <- list(a = 1:5, b = rnorm(10))

lapply(x,mean)


x <- 1:4

lapply(x,runif)

#runif takes a number as input. for example, runif(1) produces one random number, while runif(2) produces a two random numbers

lapply(x, runif, min = 0, max = 10)

# the min and max are being passed to the "..." argument to the lapply function

x <- list(a = matrix(1:4, 2, 2), b = matrix(1:6, 3, 2))

#write a custom function within lapply

lapply(x, function(elt) elt[,1])

###SAPPLY - variant of lapply that tries to simplify the resulty of lapply if possible (for example maybe you don't won't your output to also be a list)


x <- list(a=1:4, b=rnorm(10), c=rnorm(20,1), d=rnorm(100,5))

lapply(x, mean) #returns list

sapply(x, mean) #returns vector

###APPLY practice

# - used to evaluate over the margins of an arry
# - rows or columns of matrixes are the common targets of apply
# - using apply is better than for loops is not necessarily true, it just means less typing

str(apply)

# X is an array
#MARGIN is an integer vector indicating which margins should be "retained"

x <- matrix(rnorm(200), 20, 10)

apply(x, 2, mean)
#taking the mean across all rows in each column

apply(x, 1, sum)
#taking the sum across all columns in each row

#special functions can be used to do this optimally - rowSums, rowMeans, colSums, colMeans

apply(x, 1, quantile, probs = c(0.25, 0.75))
#pass the quantile function for each row of the matrix

a <- array(rnorm(2 * 2 * 10), c(2, 2, 10))
#three dimensional array

rowMeans(a, dims=2)
#rowMeans can be operated on an array was well


###MAPPLY is a multivariate function comparable to lapply and sapply, etc.,

str(mapply)
#can take multiple list elements to loop over

#FUN- the function to apply
# ... - contains arguments to apply over
# MoreArgs is a list of other arguments to FUN
# SIMPLIFY which tries to simplify the output just like in SAPPLY

list(rep(1,4), rep(2,3), rep(3,2),rep(4,1))

#OR

mapply(rep, 1:4, 4:1)



noise <- function(n, mean, sd){
  rnorm(n, mean, sd)
}

noise(5,1,2)

#noise doesn't allow vector aruguments
noise(1:5, 1:5, 2)

#mapply can vectorize this

mapply(noise, 1:5, 1:5, 2)

###TAPPLY function used to apply a function over subsets of a vector. (e.g. some obs may be women and some may be men, etc.)

str(tapply)

#X - vector
#INDEX - is a factor or a list of factors (or else they can be coerced to factors)
#FUN - function
#... - contains other arguments to pass to function
#SIMPLIFY - to try to simplify the result

x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3,10) # three levels, and each level repeated 10 times
f #10 1's, 10 2's, and 10 3's
class(f)

tapply(x, f, mean)

tapply(x, f, simplify = FALSE)

tapply(x, f, simplify = TRUE)

tapply(x, f, range)

###SPLIT takes a vector or other obkect that splits it into groups determind by a factor or list of factors

str(split)

#X - vector (or list) or data frame
#f - factor or list of factors

split(x, f)

lapply(split(x,f),mean)

tapply(x,f,mean)
#same thing as above

library(datasets)
head(airquality)

#split data set
s <- split(airquality, airquality$Month)

lapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")]))

sapply(s, function(x) colMeans(x[, c("Ozone", "Solar.R", "Wind")], na.rm=TRUE))










