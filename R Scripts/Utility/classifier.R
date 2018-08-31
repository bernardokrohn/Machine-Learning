#classifier.R

#initial interface development usig a prebuilt generic R interface

Diabetic_Retinopathy <- function(model){
  require(EBImage)
  require(mxnet)
  require(stringi)
  
  file_for_classification <- file.choose()
  flush.console()
  
  aux <- nchar(file_for_classification)
  aux2 <- stri_locate_all(pattern = '\\', file_for_classification, fixed = TRUE)
  aux2 <- matrix(unlist(aux2), ncol = 5, byrow = TRUE)

  img <- readImage(file_for_classification)
  
  #grayimg<-EBImage::channel(img,"gray")
  #img_matrix <- grayimg@.Data
  #img_vector <- as.vector(t(img_matrix))
  #dim(img_vector) <- c(img.width, img.height, colour.channel, 1)
  
  colorimg<-EBImage::channel(img,"rgb")
  img_matrix <- as.matrix(colorimg@.Data)
  img_vector <- as.vector(t(img_matrix))
  dim(img_vector) <- c(img.width, img.height, colour.channel, 1)

  predict_probs <- predict(model, img_vector)
  predicted_labels <- max.col(t(predict_probs)) - 1
  #output <- table(test__[,1], predicted_labels)
  paste0("Patient ", substr(file_for_classification,aux2[1,5]+1,aux),":",
         "\nNormal level of NPR: ", round(predict_probs[1], digits = 4),
         "\nConsiderable level of NPR: ", round(predict_probs[2], digits = 4))

}