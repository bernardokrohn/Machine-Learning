#image_classifier.R

#initial classify function development

classify <- function(file){

  file_for_classification <- file$datapath
  aux <- nchar(file_for_classification)
  aux2 <- stri_locate_all(pattern = '\\', file_for_classification, fixed = TRUE)
  aux2 <- matrix(unlist(aux2), ncol = 5, byrow = TRUE)
  img <- readImage(file_for_classification)
  
  colorimg<-EBImage::channel(img,"rgb")
  img_matrix <- as.matrix(colorimg@.Data)
  img_vector <- as.vector(t(img_matrix))
  dim(img_vector) <- c(50, 50, 3, 1)
  
  predict_probs <- predict(model, img_vector)
  predicted_labels <- max.col(t(predict_probs)) - 1
  
  return(predict_probs)
}