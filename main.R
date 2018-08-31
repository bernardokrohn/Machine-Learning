#main.R

#Initialization
#################################################

#clear environment
rm(list=ls())

#invoke libraries (use packages.R to retrieve them if not installed)
library(mxnet)
library(EBImage)
library(here)
library(irr)
library(caret)
library(gridExtra)
library(magick)
library(imager)
library(doParallel)
library(foreach)
library(filesstrings)

#################################################

#Variables
#################################################

#Classification Levels (5 or 2)
levels <- 5

#Select according to image values
img.width <- 32
img.height <- 32

# 3 = RGB   1 = Grayscale 
color.channel <- 1

#Variables regarding cnn training / retraining
round_number <- 3000
batch_size <- 120
learning_rate <- 0.04
model_prefix <- 'model'

#variables regarding cnn retraining
begin_round <- 6835

#Variables regarding saving/loading model
model_dir <- 'new model'
iteration_to_save <- 5000
iteration_to_load <- 5123

#Variables regarding augmented image upload
train_zero_limit <- 3000
test_zero_limit <- 10000

#################################################

#Workspace initialization
#################################################

workspace <- here()
image_workspace <- (paste(workspace, "Images", sep="/"))
train_images_path <- (paste(image_workspace,"Train",sep="/"))
test_images_path <- (paste(image_workspace,"Test",sep="/"))
functions_path <-(paste(workspace, "R Scripts/Functions", sep="/"))
models_path <- (paste(workspace, "Models", sep="/"))
csv_path <- (paste(workspace, "CSV Files",sep = "/"))
names_path <- (paste(csv_path, "rhyno_X.csv",sep = "/"))
labels_path <- (paste(csv_path, "rhyno_Y.csv",sep = "/"))
current_model_path <- (paste(models_path,"Current", sep = "/"))
model_path <- (paste(models_path, model_dir, sep = "/"))

#different image paths
bw_image_path <- (paste(image_workspace, "Rhyno BW", sep= "/"))
cropped_image_path<- (paste(image_workspace, "Rhyno Cropped", sep= "/"))

#################################################

#Functions initialization
#################################################
#Load scripts
#for labels reading function
source(paste(functions_path, 'label_read.R',sep= '/'))
#for image upload function
source(paste(functions_path, 'image_upload.R',sep= '/'))
#for create model function
source(paste(functions_path, 'model_create.R',sep= '/'))
#for train model function
source(paste(functions_path, 'model_train.R',sep= '/'))
#for predict model function
source(paste(functions_path, 'model_predict.R',sep= '/'))
#for calculating statistics funtion
source(paste(functions_path, 'statistics_show.R',sep= '/'))
#for image set treatment
source(paste(functions_path, 'set_treat.R',sep= '/'))
#for retraining model
source(paste(functions_path, 'model_retrain.R',sep= '/'))
#for augmentating data set
source(paste(functions_path, 'image_augmented_upload.R',sep= '/'))
#for binary predict model function
source(paste(functions_path, 'model_binary_predict.R',sep= '/'))
#################################################

#Reads labels
#Stores them in 'image_list$images' and 'image_list$labels'
image_list <-label.read(names_path, labels_path)

#Upload images
#Choose image path according to images wanted
#train_df <- image.upload(bw_image_path, image_list, "Train")
train_df <- image.augmented_upload( bw_image_path, image_list, "Train",train_zero_limit)
#test_df <- image.upload(bw_image_path, image_list, "Test")
test_df <- image.augmented_upload( bw_image_path, image_list , "Test" ,test_zero_limit)

#Prepare images for training
train_dataset <-set.treat(train_df, img.width, img.height, color.channel)
#Prepate images for testing
test_dataset <- set.treat(test_df, img.width, img.height, color.channel)


#NEW MODEL

#Create CNN
#cnn_model <- model.create(levels)

#Train CNN
#setwd(current_model_path)
#model <- model.train(cnn_model,model_prefix, train_dataset , round_number, batch_size ,learning_rate)
#setwd(workspace)


#RETRAIN MODEL

setwd(current_model_path)
new_round_number <- begin_round + round_number
model <- model.retrain(model_prefix,train_dataset,begin_round, new_round_number , batch_size,learning_rate)
setwd(workspace)


#Load a trained model
setwd(current_model_path)
model <- mx.model.load(model_prefix, 7341)
setwd(workspace)

#Save a model
#setwd(model_path)
#mx.model.save(model,model_prefix, iteration_to_save)
#setwd(workspace)


#Calculate results
prediction <- model.predict(model, test_dataset)
table(test_dataset$labels, prediction$predicted_labels)

#Show Statistics
table <- statistics.show(prediction$predicted_labels, test_dataset$labels)
#Plot table with grid package function
grid.arrange(tableGrob(table,theme = ttheme_default()))
prediction$accuracy

b_prediction <- model.binary_predict(model, test_dataset)
table(labels.to_binary(test_dataset$labels), b_prediction$predicted_labels)
b_prediction$accuracy
