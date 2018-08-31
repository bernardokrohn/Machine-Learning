#model_create.R

#Function model.create(output_levels)
#Description: Creates the convolutional neural network with all its layers
#Parameters:
#   output_levels:  amount of output nodes
#Return:
#   NN_model: complete CNN

model.create <- function(output_levels){

  data <- mx.symbol.Variable('data')
  # first conv
  conv1 <- mx.symbol.Convolution(data=data, kernel=c(3,3), num_filter=32)
  tanh1 <- mx.symbol.Activation(data=conv1, act_type="relu")
  #norm1 <- mx.symbol.BatchNorm(data=tanh1)
  pool1 <- mx.symbol.Pooling(data=tanh1, pool_type="max", kernel=c(2,2), stride=c(2,2))
  drop1 <- mx.symbol.Dropout(data=pool1, p=0.2)
  # second conv
  conv2 <- mx.symbol.Convolution(data=drop1, kernel=c(3,3), num_filter=64)
  tanh2 <- mx.symbol.Activation(data=conv2, act_type="relu")
  #norm2 <- mx.symbol.BatchNorm(data=tanh2)
  pool2 <- mx.symbol.Pooling(data=tanh2, pool_type="max", kernel=c(3,3), stride=c(2,2))
  drop2 <- mx.symbol.Dropout(data=pool2, p=0.2)
  # first fullc
  flatten <- mx.symbol.Flatten(data=drop2)
  fc1 <- mx.symbol.FullyConnected(data=flatten, num_hidden=64)
  tanh3 <- mx.symbol.Activation(data=fc1, act_type="relu")
  norm3 <- mx.symbol.BatchNorm(data=tanh3)
  drop3 <- mx.symbol.Dropout(data=norm3, p=0.25)
  # second fullc
  fc2 <- mx.symbol.FullyConnected(data=drop3, num_hidden=output_levels)
  # loss
  NN_model <- mx.symbol.SoftmaxOutput(data=fc2)
  
  return (NN_model)
}