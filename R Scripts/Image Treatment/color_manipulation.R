#Function: proc.img()
#Description : Manipulates image brightness/contrast/gamma
#Paramaters:
#   pic: image file
#   bright: change to image's brightness value (default = 0)
#   contrast: change to image's contrast value (default = 1)
#   gamma: change to image's gamma value       (default = 1)
#Return:
#   pic: new image with changes 
proc.img <- function(pic, bright = 0, contrast = 1, gamma = 1){

  # Originally was built using Imager's CIMG class type image
  pic <- pic + bright
  pic <- pic * contrast
  pic <- pic ^ gamma

  return(pic)
}