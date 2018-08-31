#imageS_sort.R

#Function: images.sort (image_path, image_list)
#Description : sorts an image set into "Test" and "Train" folders
#Paramaters:
#   image_path: image path
#   image_list: image list
#Return:  list containing:
#           set:  images selected for training
#           labels: images labels
#           values: images values

images.sort <- function(image_path, image_list){
  
  train_path <- paste(image_path, "Train", sep ='/')
  test_path <- paste(image_path, "Test", sep ='/')
  
  dir.create(train_path)
  dir.create(test_path)
  
  counter <- c(1,1,1,1,1)
  
  for (i in 1:dim(image_list$images)[1]){
    
    setwd(image_path)
    if (file.exists(paste(image_list$images[i,],".jpg", sep=""))){
      if( (counter[image_list$labels[i,] +1] %% 4 == 0) ){
        file.move(paste(image_list$images[i,],".jpg", sep=""), test_path)
      }else{
        file.move(paste(image_list$images[i,],".jpg", sep=""), train_path)
      }
      counter[image_list$labels[i,] +1] <- counter[image_list$labels[i,] +1] +1
      print(paste("Done",image_list$images[i,],sep = " "))
   }
  }
}