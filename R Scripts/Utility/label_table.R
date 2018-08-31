#label_table.R

#Function: label.table (image_path, image_list ,path)
#Description : writes a table with the label distribution
#Paramaters:
#   image_path: image path
#   image_list: dataframe containing the images

label.table <- function(image_path,image_list){
  setwd( image_path)
  df <- data.frame()
  for (i in 1:dim(image_list$images)[1]){
    if (file.exists(paste(image_list$images[i,],".jpeg", sep=""))){
      label <- image_list$labels[i,]
      df <- rbind(df, label)
    }
  }
  write.table(table(df), "table.txt", append = FALSE, sep = " ", dec = ".",row.names = TRUE, col.names = TRUE)
}
