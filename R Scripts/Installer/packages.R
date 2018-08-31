# Packages with easy installation script
pak <- function(pkg){
  # check if package has already been installed
  new.pkg <- pkg[!(pkg %in% installed.packages()[, 'Package'])]
  if(length(new.pkg))
    # install package
    install.packages(new.pkg, dependencies=TRUE)
}

packages <- c('tidyverse','caret','magick','pixmap', 'jpeg', 'stringi',
              'doParallel', 'here','gridExtra', 'irr','imager', 'filesstrings', 'foreach')
pak(packages)


# EBImage package installation
source('https://bioconductor.org/biocLite.R')
biocLite('EBImage')

cran <- getOption('repos')
cran['dmlc'] <- 'https://apache-mxnet.s3-accelerate.dualstack.amazonaws.com/R/CRAN/'
options(repos=cran)
install.packages("mxnet")


verify <- c(packages, 'EBImage', 'mxnet')

# Check if packages were installed
is.installed <- function(pkg){
  # Display name and install status
  sapply(pkg, require, character.only=TRUE)
  #paste(pkg, is.element(pkg, installed.packages()[,1]), sep=': ')
}
is.installed(verify)