# Diabetic Retinopathy

Deep Learning algorithm to diagnose [Diabetic Retinopathy](https://en.wikipedia.org/wiki/Diabetic_retinopathy) using high-resolution retina images

## Getting Started

### *Anything pertaining to the graphical interface is written down in the README within `file-upload/` folder!*

### Prerequisites
Clone this repository:

```
git clone <repository>
```

Retrieve dataset:

```
https://www.kaggle.com/c/diabetic-retinopathy-detection/data
```

Place the images into the *Rhyno* folder

### Installing

You will need the following software:

* [R](https://cran.r-project.org/) - programming language
* [RStudio](https://www.rstudio.com/products/rstudio/download/) - IDE
* [7zip](https://7-zip.org/) or similar

You will also need to install the required packages:

```
In RStudio, select all the code from packages.R (located on the ...\R Scripts\Installer)
	and click run (or press Ctrl-Enter)
```

## Running the code

Open main.R 

#Initialization
Here we reset the environment to clear anything leftover from previous code
Additionally, all libraries used by the programm are called here

#Variables
levels: This variable defines how many class levels you will be using to grade the pictures 

img.width: width of the images used for training/testing

img.height: height of the images used for training/testing

color.channel: RGB (3) or Grayscale (1) image

round_number: number of rounds wanted for training

batch_size: batch size wanted for training

learning_rate: learning rate wanted for training

model_prefix: name to be used to save model 

begin_round: round to start on for model retraining (iteration needs to be saved)

model_dir: directory where the model will be saved

iteration_to_save: wanted iteration to save model

iteration_to_load: wanted iteration to load model

train_zero_limit: maximum amount of zero graded images to pass on the train dataset

test_zero_limit: maximum amount of zero graded images to pass on the test dataset

#Workspace initialization
Here all workspace and path variables are initialized

#Functions initialization
Here all functions used by the programm are initialized
All scripts for these functions must be located on the "...\R Scripts\Functions" Folder

First we read the names and corresponding labels of the images from the csv files 
adding them to a list with 2 data frames, one holding the image names ("images") and the other
the image labels ("labels")

Then we upload the images, there are two functions for this

image.upload - uploads all images in the chosen directory, normally "...\Train" or "...\Test"

image.augmented_upload - uploads only a limited amount of zero graded images and balances the other graded images
according to its distribution
This will take some time

Then we prepare the images for training, mainly we normalize the images with its mean and create a 
list with 2 data frames, one holding the image array ("set") and one holding the corresponding labels ("labels")

Then the model is trained, there are two cases:
	
If there is no previous model train, we need to create a new model using the model.create function and then
we can train it with the model.train function
	
If there is a previous model we wish to retrain we just have to be sure the begin round is correctly chosen
and we can just use the model.retrain function

The programm will print out the current train accuraccy for each iteration
In both caseÌs the models is periodically saved, so we can stop the programm at any time without losing the model
The model will be saved in the current directory under a JSON file wich holds the model information and a PARAMS file
for each iteration, we need both to load the model.
If there is a model saved in the current directory the function will write over it, so take care
Additionally each PARAMS file can only be loaded with the corresponding JSON File.

In case the programm was stopped before reaching its end the model will not be saved in the current environment so it 
cannot be saved, however it can be loaded with the mx.model.load function

Finally we will test our model with the model.predict function which will use the trained cnn to predict test dataset and
compare the predictions with the actual values

Lastly we can verify our results with the statistics.show function which will calculate the specificity and sensibility 
values for each grade and plot them in a table




