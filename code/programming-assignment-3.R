getwd()
setwd("/home/rstudio/projects/johns-hopkins-coursera/data/rawdat")

#import data
hos <- read.csv()

outcome <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
head(outcome)
outcome[,11] <- as.numeric(outcome[,11])
hist(outcome[,11])

###REFERENCES: https://github.com/muntasir2165/R-Programming-Assignments-1--2--and-3-/blob/master/Programming%20Assignment%203%20-%20Hospital%20Quality/rankall.R



best <- function(state, outcome) {
  ## Read outcome data
  
  dat <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  
  ## Check that state and outcome are valid
  
  states <- dat[,7] 
  
  outcomes <- c("heart attack", "heart failure", "pneumonia")
  
  if ((state %in% states) == FALSE){stop()}
  if ((outcome %in% outcomes) == FALSE){stop()}
    
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  
}


