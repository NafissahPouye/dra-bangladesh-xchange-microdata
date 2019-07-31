library(readxl)      #for excel, csv sheets manipulation
library(sdcMicro)    #sdcMicro package with functions for the SDC process 
library(tidyverse)   #optional #for data cleaning

#Import data
setwd("C:/Users/LENOVO T46OS/Desktop/dra-bangladesh-xchange-microdata")
data <- read_excel("xchanges-hostcommunitysurvey-data.xlsx")

#Xchange Bangladesh microdata
selectedKeyVars <- c('Sex', 'Upazila_of_residence',
                     'Union_of_residence', 'Time_residing_in_Union',
                     'How_do_you_spend_your_time_during_an_average_day_maximum_3_responses?'
                     )
#weightVar <- c('weight')

#Convert variables into factors
cols =  c('Sex', 'Upazila_of_residence', 'Time_residing_in_Union', 'Union_of_residence',
          'How_do_you_spend_your_time_during_an_average_day_maximum_3_responses?')
data[,cols] <- lapply(data[,cols], factor)

#Convert the sub file into dataframe
fileRes<-data[,selectedKeyVars]
fileRes <- as.data.frame(fileRes)

#Assess the disclosure risk
objSDC <- createSdcObj(dat = fileRes, keyVars = selectedKeyVars)
print(objSDC, "risk")
report(objSDC, filename ="index",internal = T) 
