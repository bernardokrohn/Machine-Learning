#statistics_show.R

#Function: statistics.show(predicition, values)
#Description : Calculates statistics such as specificity, sensitivity and kappa values
#              refering to the model prediction
#Paramaters:
#   prediction: predicted labels on the image test set
#   values: actual labels on the image test set
#Return:
#   class_results: dataframe with statistics for each label class 

statistics.show <- function(prediction, values){
  #read results from file
  results <- cbind(prediction, values)
  class0_results <- results
  class1_results <- results
  class2_results <- results
  class3_results <- results
  class4_results <- results
  
  #Reajust results per class to binary classification 
  
  class0_results[class0_results == 0] <- FALSE
  class0_results[class0_results != 0] <- TRUE
  
  class1_results[class1_results != 1] <- FALSE
  class1_results[class1_results == 1] <- TRUE
  
  class2_results[class2_results != 2] <- FALSE
  class2_results[class2_results == 2] <- TRUE
  
  class3_results[class3_results != 3] <- FALSE
  class3_results[class3_results == 3] <- TRUE
  
  class4_results[class4_results != 4] <- FALSE
  class4_results[class4_results == 4] <- TRUE
  
  
  #arrange data in table for kappa coefficient calculation
  class0_table <- as.matrix(cbind(class0_results[,1],class0_results[,2]))
  class1_table <- as.matrix(cbind(class1_results[,1],class1_results[,2]))
  class2_table <- as.matrix(cbind(class2_results[,1],class2_results[,2]))
  class3_table <- as.matrix(cbind(class3_results[,1],class3_results[,2]))
  class4_table <- as.matrix(cbind(class4_results[,1],class4_results[,2]))
  
  
  #Calculate specificity and sensitivity values and arrange them in an ordered vector
  
  
  if(levels == 5){
    class_level <- c("no DR", "mild DR","moderate DR","severe DR","proliferative DR")
    
    specificity <- c(specificity(factor(class0_results[,1]), factor(class0_results[,2])),
                     specificity(factor(class1_results[,1]), factor(class1_results[,2])),
                     specificity(factor(class2_results[,1]), factor(class2_results[,2])),
                      specificity(factor(class3_results[,1]), factor(class3_results[,2])),
                     specificity(factor(class4_results[,1]), factor(class4_results[,2]))
    )
    sensitivity <- c(sensitivity(factor(class0_results[,1]), factor(class0_results[,2])),
                     sensitivity(factor(class1_results[,1]), factor(class1_results[,2])),
                     sensitivity(factor(class2_results[,1]), factor(class2_results[,2])),
                     sensitivity(factor(class3_results[,1]), factor(class3_results[,2])),
                     sensitivity(factor(class4_results[,1]), factor(class4_results[,2]))
    )
    kappa_coefficient <- c(kappa2(class0_table)$value,
                           kappa2(class1_table)$value,
                           kappa2(class2_table)$value,
                           kappa2(class3_table)$value,
                           kappa2(class4_table)$value)
  }else{
    class_level <- c("Normal DR", "Abnormal DR")
      
    specificity <- c(specificity(factor(class0_results[,1]), factor(class0_results[,2])),
                     specificity(factor(class1_results[,1]), factor(class1_results[,2]))
    )
    sensitivity <- c(sensitivity(factor(class0_results[,1]), factor(class0_results[,2])),
                     sensitivity(factor(class1_results[,1]), factor(class1_results[,2]))
    )
    kappa_coefficient <- c(kappa2(class0_table)$value,
                           kappa2(class1_table)$value)
  }
  
  
  
  #Add all calculated vectors together to form the final value data frame
  class_results <- data.frame(class_level,specificity,sensitivity,kappa_coefficient,stringsAsFactors = TRUE)
  return(class_results)
}
