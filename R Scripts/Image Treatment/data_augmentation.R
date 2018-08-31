#data_augmentation

#Function: create.vector()
#Description : create image vector
#Paramaters:
#   img: magick type image
#   i: image position
#Return:
#   vec: image vector with label attached
create.vector <- function(img, i){

  # Cast to cimg
  cimg <- magick2cimg(img)
  
  # Cast to vector
  img_vector <- as.vector(cimg)
  
  # Add image's label
  vec <- c(labels[i,], img_vector)
  
  return(vec)
}

### Uniformize training data - artificially creating more images with slight changes but same labels ###

# As of right now, we use the second most common label (2) as standard to match
# Zeroes (0) must be trimmed, ones (1) doubled and threes and fours need a substantial amount
#   of new images to match

#Function: more.imgs()
#Description : artificially creates more images from existing ones to uniformize data
#Paramaters:
#   image_path: image path
#   image_list: image list
#   path: "Test" or "Train"
#   zero_limit: maximum number of zeros uploaded
#Return:
#   df: dataframe with images
more.imgs <- function(image_path, image_list, path, zero_limit){
  
  # Path where images are stored
  setwd(paste(image_path,path,sep="/"))

  df <- data.frame()
  counter <- 0

  # We might need to parallelize the loop for large quantities of images
  for (i in 1:dim(image_list$images)[1]){
    if (file.exists(paste(image_list$images[i,],".jpg", sep=""))){
      
      # Get magick image object
      img <- image_read(paste(image_list$images[i,],".jpg", sep=""))
      
      # Cast image to black and white if necessary
      #img <- grayscale(img)
      
      # All of this can be changed depending on original images' label
      # The amount of rbind a label has indicates how many images will be created from each original
      if(image_list$labels[i,] == 1){
        df <- rbind(df, create.vector(img, i))

        img2 <- image_flip(img)
        df <- rbind(df, create.vector(img2, i))
      }

      if(image_list$labels[i,] == 3 || image_list$labels[i,] == 4){
        df <- rbind(df, create.vector(img, i))

        img2 <- image_flip(img)
        df <- rbind(df, create.vector(img2, i))

        img3 <- image_flop(img)
        df <- rbind(df, create.vector(img3, i))

        img4 <- image_flip(img3)
        df <- rbind(df, create.vector(img4, i))

        img5 <- image_flop(img4)
        df <- rbind(df, create.vector(img5, i))

        if(image_list$labels[i,] == 4){
          img6 <- image_rotate(img, 10)
          df <- rbind(df, create.vector(img6, i))
        }
      }

      if(image_list$labels[i,] == 2){
        df <- rbind(df, create.vector(img, i))
      }

      if(image_list$labels[i,] == 0 && counter < zero_limit){
        df <- rbind(df, create.vector(img, i))
        counter <- counter + 1
      }
      
      remove("img")
      
      print(paste("Done",image_list$images[i,],sep = " "))
      
    }
  }
  return(df)
}
