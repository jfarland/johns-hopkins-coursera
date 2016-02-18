getwd()
setwd("/home/rstudio/projects/johns-hopkins-coursera")

pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  setwd(file.path("/home/rstudio/projects/johns-hopkins-coursera", directory))
  
  #we're going to need to import all of the values, and divide by the number of NA's
  
  num = 0
  den = 0
  
  for(i in id)
  {
    if(i<10)
    {
      data <- read.csv(paste("0","0", as.character(i), ".csv", sep=""), header = TRUE, na.strings=c("NA", "NaN", " "))
    }
    else if(i>=10 & i<100)
    {
      data <- read.csv(paste("0", as.character(i), ".csv", sep=""), header = TRUE, na.strings=c("NA", "NaN", " "))
    }
    else{
      data <- read.csv(paste(as.character(i),".csv", sep=""), header = TRUE, na.strings=c("NA", "NaN", " "))
    }
    
    
    data = na.omit(data)
    den = den+ nrow(data) 
    
    if(pollutant == "sulfate") {num = num + sum(data$sulfate)}
    else{num = num + sum(data$nitrate)}
    
  } #end of for loop  
  
  setwd("..")
  
  return(num/den)
}

#example calls

pollutantmean("specdata", "sulfate", 34)

pollutantmean("specdata", "nitrate")

###

#STAGE 2

###


complete <- function(directory, id = 1:332) {
  
  
  dataframe = NULL  ## initializing the dataframe we want from this function   
  setwd(file.path("C:/Users/jonfar/Documents/Research/Coursera/R-Programming/", directory)) ## setting the directory
  
  #Looping thru the directory's files specified in the 'id' argument 
  for (i in id)
  {
    
    
    ## Due to the format of the filename, i.e 001, 010  instead of 1, 10. I became aware that the following method works but not efficient, 
    ## but at the time of the completion of this assignment, it was the only way I knew how to do it.           
    if (i <10) { 
      data <- read.csv(paste("0","0", as.character(i), ".csv", sep=""),  ## for example, if 'id' =7, we get 007.csv
                       header = T, 
                       na.strings=c("NA","NaN", " "))
    }
    
    else if (i>=10 & i<100) { 
      data <- read.csv(paste("0", as.character(i), ".csv", sep=""),  ## for example, if 'id' = 17, we get 017.csv
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    }
    
    
    
    else       { 
      data <- read.csv(paste(as.character(i), ".csv", sep=""),     ## Normal
                       header = T, 
                       na.strings=c("NA","NaN", " ") 
      )
    }
    
    ## getting rid of all the "NA" values and, consequently, all the non-complete ovservations (the ones with at least one NA in row)
    data = na.omit(data) 
    ##  make it a matrix to easily fill each successive row of our dataframe
    data = as.matrix(data)
    dataframe = rbind(dataframe, c(i,nrow(data))) # fill each successive row of our dataframe. Each row contains the monitor ID,
    # and its total complete observed cases (no rows containg NAs)
    
    
    
  }
  
  setwd("..")  # reseting working directory path
  dataframe = data.frame(dataframe)  # from matix to data frame 
  names(dataframe) = c('id', 'nobs') # set the column names of the data frame
  return (dataframe) 
}

complete("specdata", 1)

##   id nobs
## 1  1  117

complete("specdata", c(2, 4, 8, 10, 12))

complete("specdata", 30:25)

complete("specdata", 3)

###

#STAGE 3

###

corr <- function(directory, threshold = 0) {
  setwd(file.path("C:/Users/jonfar/Documents/Research/Coursera/R-Programming/", directory)) ## setting the directory
  
  correlationVector = NULL ## initializing the correlation matrix
  
  #Looping thru ALL the directory's files 
  for (i in 1:332)
  {
    
    
    ## Due to the format of the filename, i.e 001, 010  instead of 1, 10. I became aware that the following method works but not efficient, 
    ## but at the time of the completion of this assignment, it was the only way I knew how to do it.           
    if (i <10) { 
      data <- read.csv(
        paste("0","0", as.character(i), ".csv", sep=""),  ## for example, if 'id' =7, we get 007.csv
        header = T, 
        na.strings=c("NA","NaN", " ")
        
      )
    }
    
    else if (i>=10 & i<100) { 
      data <- read.csv(
        paste("0", as.character(i), ".csv", sep=""),  ## for example, if 'id' = 17, we get 017.csv
        header = T, 
        na.strings=c("NA","NaN", " ") 
        
      )
    }
    
    
    
    else       { 
      data <- read.csv(
        paste(as.character(i), ".csv", sep=""),     ## Normal
        header = T, 
        na.strings=c("NA","NaN", " ") 
        
      )
    }
    
    ## getting rid of all the "NA" values and, consequently, all the non-complete ovservations (the ones with at least one NA in row)
    data = na.omit(data) 
    
    ## if the number of complete observed cases meets the quota, find the correlation between the pollutants for the given monitor AND
    ## store the results in the correlation matrix
    if (nrow(data) > threshold) {
      correlationVector = c(correlationVector, cor(data[,2], data[,3]))
    }
    
    
  }
  
  
  
  setwd("..")  # reseting working directory path
  return (correlationVector)
}

#We can test this function with the following queries

cr <- corr("specdata", 150)
head(cr); summary(cr)

## [1] -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667 -0.07588814

##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -0.21060 -0.04999  0.09463  0.12530  0.26840  0.76310

cr <- corr("specdata", 400)
head(cr); summary(cr)

## [1] -0.01895754 -0.04389737 -0.06815956 -0.07588814  0.76312884 -0.15782860

##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -0.17620 -0.03109  0.10020  0.13970  0.26850  0.76310

cr <- corr("specdata", 5000)
head(cr); summary(cr) ; length(cr)

## NULL

## Length  Class   Mode 
##      0   NULL   NULL

## [1] 0

cr <- corr("specdata") # default threshold value  is ZERO
head(cr); summary(cr) ; length(cr)

## [1] -0.22255256 -0.01895754 -0.14051254 -0.04389737 -0.06815956 -0.12350667

##     Min.  1st Qu.   Median     Mean  3rd Qu.     Max. 
## -1.00000 -0.05282  0.10720  0.13680  0.27830  1.00000

## [1] 323

