#model_train.R

#Function: model.train(model, model_prefix, dataset, round_number, batch_size, learning_rate)
#Description : trains the given model with the given image training set
#Paramaters:
#   model: Convolutional Neural Network model
#   model_prefix: name of the model to be stored
#   dataset: dataframe holding the image set and the corresponding labels
#   round_number: number of rounds to train model
#   batch_size: batch size per round
#   learning_rate: model learning rate
#Return:
#   model: trained model

model.train <- function(model, model_prefix, dataset, round_number, batch_size, learning_rate){
  # Set seed for reproducibility
  mxnet::mx.set.seed(100)
  
  # Device used. Sadly not the GPU :-(
  device=list(mx.cpu(0),mx.cpu(1),mx.cpu(2))
  
  
  # Train on 1200 samples
  model <- mxnet::mx.model.FeedForward.create(NN_model, X =  dataset$set, y = dataset$labels,
                                              ctx = device,
                                              num.round = round_number,
                                              array.batch.size = batch_size,
                                              learning.rate = learning_rate,
                                              momentum = 0.9,
                                              wd = 0.00001,
                                              eval.metric = mxnet::mx.metric.accuracy,
                                              epoch.end.callback=mx.callback.save.checkpoint(model_prefix))
  return(model)
}