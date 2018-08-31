#model.binary_predict.R

#Auxiliary Function: labels.to_binary(labels)
#Description : Creates a new list with binary classification
#Paramaters:
#   labels: list with original non-binary classification labels
#Return:
#   binary: list with new binary classification labels


labels.to_binary <- function(labels){
  new <- labels
  
  for (i in 1:length(labels)){
    if(labels[i] < 2){
      new[i] <- 0
    }else{
      new[i] <- 1
    }
  }
  return (new)
}

#Function: model.binary_predict()
#Description : Makes a prediction on the test set according to the trained model
#Paramaters:
#   cnn_model: trained model
#   test: dataframe holding the image set and its values
#Return:
#   prediction: list containing
#                 predicted_labels: predicted labels
#                 accuracy: models prediction accuracy

model.binary_predict <- function(cnn_model, test){
  predict_probs <- predict(cnn_model, test$set)
  predicted_labels <- max.col(t(predict_probs)) - 1
  accuracy <- sum(diag(table(labels.to_binary(test$labels), labels.to_binary(predicted_labels))))/length(labels.to_binary(test$labels))
  accuracy <- round(accuracy, digits = 2)
  prediction <- list("predicted_labels" = labels.to_binary(predicted_labels), "accuracy" = accuracy)
  return(prediction)
}