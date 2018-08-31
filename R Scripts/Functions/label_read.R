#label_read.R

#Function: label.read(names_path, labels_path)
#Description :  Reads images names and labels from the csv files
#Paramaters:
#   names_path: path to the csv containing the images names
#   labels_path: path to the csv containing the images labels
#Return:
#   res:  list containing
#           images: all images names
#           labels: all image labels


label.read <- function(names_path, labels_path){
  #X = rhyno pictures
  #Y = rhyno classification
  images <- read.csv(names_path, header = F)
  labels <- read.csv(labels_path, header = F)
  res <- list("images"= images, "labels"=labels)
  return(res)
}