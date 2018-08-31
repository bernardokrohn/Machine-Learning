#set_treat.R

#Function: set.treat(df,img.width,img.height,color.channel)
#Description : Sets the imageset so it can be used to train the CNN
#Paramaters:
#   df: dataframe containing the images
#   img.width: image width
#   img.height: image height
#   color.channel: color.channel
#Return:  
#   ds: list containing:
#           set:  images selected for training
#           labels: images labels

set.treat <- function(df,img.width,img.height,color.channel){
  
  # Fix train and test datasets
  set <- data.matrix(df)
  set_x <- t(set[,-1])
  set_y <- set[,1]
  set_array <- set_x
  dim(set_array) <- c(img.width, img.height, color.channel, ncol(set_x))
  mean.image <- colMeans(df[2:dim(df)[2]])
  new_set_array = set_array - mean.image
  ds = list("set" = new_set_array,  "labels"=set_y)
  return(ds)
}

