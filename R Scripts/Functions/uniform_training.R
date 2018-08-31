#Function: uniform.train(df, qnt)
#Description :  uniforms training dataset for better results
#Paramaters:
#   df: dataframe with augmented images
#   qnt: quantity to keep within each label
#Return:
#   res:  list containing
#           train_: uniformed training dataframe
#           test_: test dataframe 
uniform.train <- function(df, qnt){
  test_ <- data.frame()
  train_ <- data.frame()
  counter <- c(0,0,0,0,0)
  for (i in 1:dim(df)[1]){
      
      if(counter[df[i,1] + 1] < qnt){
        train_ <- rbind(train_, df[i,])
        counter[df[i,1] + 1] <- counter[df[i,1] + 1] + 1
      } else{
        test_ <- rbind(test_, df[i,])
      }
      print(i)
    }
  
  setwd(home)
  return(list(train_, test_))
}

df <- df[sample(1:dim(df)[1]),]
result <- uniform.train(df, 2000)
train <- result[1]
test <- result[2]