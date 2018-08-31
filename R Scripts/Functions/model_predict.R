#model_predict.R

#Function: model.predict()
#Description : Makes a prediction on the test set according to the trained model
#Paramaters:
#   cnn_model: trained model
#   test: dataframe holding the image set and its values
#Return:
#   prediction: list containing
#                 predicted_labels: predicted labels
#                 accuracy: models prediction accuracy

model.predict <- function(cnn_model, test){
  predict_probs <- predict(cnn_model, test$set)
  predicted_labels <- max.col(t(predict_probs)) - 1
  accuracy <- sum(diag(table(test$labels, predicted_labels)))/length(test$labels)
  accuracy <- round(accuracy, digits = 2)
  prediction <- list("predicted_labels" = predicted_labels, "accuracy" = accuracy)
  return(prediction)
}