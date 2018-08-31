#images_crop.R

#Auxiliary Function: image.crop(i, images,dir, img.width, img.height))
#Description : crop and resize image to desired dimensions
#Paramaters:
#   i: image position
#   image: dataframe holding the images names
#   dir: directory to save cropped image
#   img.width: image width
#   img.height: image height
#Return: 
image.crop <- function(i, images,dir, img.width, img.height){
  
  if (file.exists(paste(images[i,],".jpg", sep=""))){

    # Load Image
    img <- load.image(paste(images[i,], '.jpg', sep=""))

    # Black and White
    img <- grayscale(img)

    shape <- dim(img)
    
    # Get squared shaped image (to avoid black bands at the sides)
    short.edge <- min(shape[1:2])
    xx <- floor((shape[1] - short.edge) / 2)
    yy <- floor((shape[2] - short.edge) / 2)
    
    # Cut out black borders
    cropped <- crop.borders(img, xx, yy)
    
    # Resize to desired dimensions
    resized <- resize(cropped, img.width, img.height)

    # Save Image
    imager::save.image(resized, paste(dir,images[i,],".jpg", sep=""))
  }
}

#Function: images.parallel_crop(image_path, images, img.width, img.height)
#Description : crop and resize images to desired dimensions
#Paramaters:
#   image_path: image path
#   images: dataframe holding the images names
#   img.width: image width
#   img.height: image height
#Return: 
images.parallel_crop(image_path, images, img.width, img.height){
  
  #Create a dir to save cropped images
  dir <- paste(image_path, "Cropped/", sep="/")
  dir.create(dir)
  
  # Detect available CPU 
  no_cores <- detectCores() - 1 
  cl<-makeCluster(no_cores)
  
  # Start parallel computing
  registerDoParallel(cl)
  
  foreach(i = 1:dim(images)[1], .packages='imager') %dopar% image.crop(i, images, dir, img.width, img.height)
  
  # Stop parallel computing
  stopCluster(cl)
}