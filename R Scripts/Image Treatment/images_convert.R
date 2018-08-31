#images_convert.R

#Function: images.convert(image_path, images, ext_from, ext_to)
#Description: Converts a set of image to a different extension (ex: '.jpg' to '.jpeg')
#Paramaters:
#   image_path: image path
#   images: dataframe holding images names
#   ext_from: original extension
#   ext_to: desired extension
#Return:

images.convert <- function(image_path, images, ext_from, ext_to){
  for (i in 1:dim(images)[1]){
  
    image <- (paste(image_path, images[,i], sep = "/"))
    
    if (file.exists(paste(image,suffix_from, sep=""))){
      
      # Simply rename the extension
      file.rename(from=paste(images[i,],".jpeg", sep=""), to=paste(image,ext_to, sep=""))
      
      print(paste("Done",images[i,],sep = " "))      
    }
  }
}