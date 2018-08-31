source('Rhyno_Start.R')

create.dfn <- function(){
  totaln <- cbind(images, labels)
  dfn <- data.frame(stringsAsFactors = F)
  
  ### Create DataFrame with Actual Images We Have ####
  for (i in 1:dim(images)[1]){
    # image path
    setwd(path1)
    
    # Check if a certain image exists
    if (file.exists(paste(images[i,],".jpg", sep=""))){
      
      # Get image Name and Value
      vecn <- c(paste(images[i,],".jpg", sep=""), labels[i,])
      dfn = rbind(dfn, vecn, stringsAsFactors = FALSE)
    }  
  }
  
  # Change column names
  colnames(dfn) <- c('Image', 'Value')
  
  setwd(path0)
  return(dfn)
}

dfn <- create.dfn()
####                  ####                    ####



#### CHECK FOR SINGLE IMAGES  (WITHOUT PAIR) ####
unique.eye <- function(dfn){
  names <- c()
  
  for(i in 1:nrow(dfn)){
    image <- dfn[i,][1]
    # Get patient number  ->    regexpr("_", image) - 1 is the element immediately to the left of underscore
    name <- substring(image,1 , regexpr("_", image)-1)
    names <- append(names, c(name))
  }
  # print out any names not present in the duplicated(names) list -> not having a pair
  print(names[!names %in% names[duplicated(names)] == TRUE])
}
# Uncomment for function call
#unique.eye(dfn)
####                 ####                   ####


#### Create Pie Chart ####
# Start with a basic bar plot
pie <- ggplot(dfn, aes(x = factor(1), fill = Value)) +
  geom_bar(width = 1) + 
  # Make pie chart
  coord_polar(theta = "y") +
  # Remove unwanted labels
  theme_void()
# Build chart
pie
####                  ####

#### Create DataFrame that Combines Both Eye Data ####
create.combined <- function(dfn){
  comb.dfn <- data.frame(stringsAsFactors = FALSE)
    
  for (i in seq(from=1, to=nrow(dfn), by=2)) {
    # Left eye
    Lvalue <- as.integer(dfn[i,][2])
    # Right eye
    Rvalue <- as.integer(dfn[i+1,][2])
  
    image <- dfn[i,][1]
    name <- substring(image, 1, regexpr("_", image) - 1)
    
    # eye levels difference
    absValue <- abs(Lvalue - Rvalue)
    
    affected <- FALSE
    both <- FALSE
    
    if(Lvalue > 0 | Rvalue > 0){
      # either eye affected
      affected <- TRUE
      if(Lvalue > 0 & Rvalue > 0){
        # both eyes affected
        both <- TRUE
      }
    }
    
    comb.vecn <- c(name, Lvalue, Rvalue, absValue, affected, both)
    comb.dfn <- rbind(comb.dfn, comb.vecn, stringsAsFactors = FALSE)
  }
  
  # Change column names
  colnames(comb.dfn) <- c('Patient', 'LValue', 'RValue', 'Value_Dif', 'Affected', 'Both')
  ####                    ####                      ####
  
  # Export comb.dfn to .csv file
  setwd(path0)
  return(comb.dfn)
  #write.csv(comb.dfn, file='rhyno_combined.csv', row.names=FALSE)
}

comb.dfn <- create.combined(dfn)

plot <- ggplot(comb.dfn, aes(x = "", fill = Affected)) +
  geom_bar(position='fill',width=0.5) +
  ylab('Percentage') +
  xlab('Affected')
plot

plt1 <- ggplot(comb.dfn, aes(x = "", fill = LValue)) +
  geom_bar(width = 0.5) +
  xlab('LValue')
plt1

plt2 <- ggplot(comb.dfn, aes(x = "", fill = RValue)) +
  geom_bar(width = 0.5) +
  xlab('RValue')
plt2

