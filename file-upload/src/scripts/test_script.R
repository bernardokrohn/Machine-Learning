#!/usr/bin/env Rscript

args = commandArgs(trailingOnly=TRUE)

suppressPackageStartupMessages(library(here))
suppressPackageStartupMessages(library(imager))
suppressPackageStartupMessages(library(mxnet))

setwd(paste(here(),'src/scripts/', sep="/"))

model <- mx.model.load("model",520)

if (length(args)==0) {
    stop("At least one argument must be supplied (input file).n", call.=FALSE)
} else if (length(args)==1) {
    img <- load.image(paste(here(), args[1], sep="/"))
    img <- grayscale(img)
    shape <- dim(img)
    
    short.edge <- min(shape[1:2])
    xx <- floor((shape[1] - short.edge) / 2)
    yy <- floor((shape[2] - short.edge) / 2)
    
    cropped <- crop.borders(img, xx, yy)
    
    resized <- resize(cropped, 50, 50)
    #imager::save.image(resized,paste(here(), args[1], sep="/"))
    img_vector <- as.vector(resized)
    dim(img_vector) <- c(50,50,1,1)
    print(max.col(t(predict(model, img_vector))) - 1)
}