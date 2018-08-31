#model_retrain.R

#Function: model.retrain(statistics.show)
#Description : Retrains a saved pre-trained model with a given dataset
#Paramaters:
#   model_prefix: pre-trained models name
#   dataset: image dataset
#   begin_round: round to begin training
#   round_number: number of rounds to train model
#   batch_size: batch size per round
#   learning_rate: model learning rate
#Return:
#   model: re-trained model

model.retrain <- function(model_prefix, dataset,begin_round, round_number ,batch_size,learning_rate){

  mxnet::mx.set.seed(100)

  device=list(mx.cpu(0),mx.cpu(1),mx.cpu(2))

  model <- mx.model.load(model_prefix, begin_round )

  model <- mxnet::mx.model.FeedForward.create(symbol = model$symbol,
                                            arg.params = model$arg.params, 
                                            aux.params = model$aux.params,
                                            X =  dataset$set, y = dataset$labels,
                                            ctx = device,
                                            begin.round = begin_round, 
                                            num.round = round_number,
                                            array.batch.size = batch_size,
                                            learning.rate = learning_rate,
                                            momentum = 0.9,
                                            wd = 0.00001,
                                            eval.metric = mxnet::mx.metric.accuracy,
                                            epoch.end.callback=mx.callback.save.checkpoint(model_prefix))
  return(model)
}