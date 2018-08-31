#image_upload.R

#Function: image.upload()
#Description : uploads images in the selected image_path into a dataframe
#Paramaters:
#   image_path: path to the folder where the images are stored
#   image_list: dataframe containing images and corresponding labels
#   path: path to Train or Test directory
#Return:
#   df: dataframe where images are stored

image.upload <- function( image_path, image_list ,path){
  
  setwd(paste(image_path,path,sep="/"))
  df <- data.frame()
  for (i in 1:dim(image_list$images)[1]){
    label <- image_list$labels[i,]
    if(file.exists(paste(image_list$images[i,],".jpeg", sep=""))){
      
      #Limit maximum amount of images per level
      img <- readImage(paste(image_list$images[i,],".jpeg", sep=""))
      #read image and create data frame with info
      img_matrix <- img@.Data
      #img_matrix <- as.matrix(img@.Data)
      img_vector <- as.vector(t(img_matrix))
      vec <- c(image_list$labels[i,], img_vector)
      df <- rbind(df,vec)
      print(paste("Done",image_list$images[i,],sep = " "))
    }
  }
  return(df)
}

