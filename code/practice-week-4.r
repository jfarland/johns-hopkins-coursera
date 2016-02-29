
#STR function very similar to "summary"

#simulation week - generation random numbers

#rnorm - random number generator

#dnorm - density function
str(dnorm)


#pnorm - cumulative distribution function

#qnorm - quintile function

#rpois


x <- rnorm(10)
summary(x)

x <- rnorm(10, 20, 2)

#
set.seed(1)
rnorm(5)


#simulate a linear model

set.seed(20)

x <- rnorm(100)
e <- rnorm(100, 0, 2)

y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

#what if x is a binary variable
x <- rbinom(100, 1, 0.5)
e <- rnorm(100, 0, 2)

y <- 0.5 + 2 * x + e
summary(y)
plot(x,y)

### RANDOM SAMPLING

set.seed(1)

sample(1:10, 4) #w/0 replacement

sample(letters, 5) #w/o replacement

sample(1:10) # permutation (e.g., 10 numbers)

sample(1:10, replace = TRUE) #WITH replacement




