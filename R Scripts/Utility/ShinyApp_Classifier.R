#ShinyApp_Classifier.R

#Initial development for a interface using Shiny

library(shiny)
library(EBImage) #for image processing and analysis


#UI Code
ui <- fluidPage(
  theme = "classifier_style.css",
    navbarPage(
      "Medical Test",
      tabPanel("Start"),
      tabPanel("Diabetic Retinopathy",
                        fileInput(inputId = "image",
                                 label = "Select image to classify",
                                 multiple = FALSE, 
                                 accept = c(".jpeg", ".jpg"),
                                 placeholder = "No image selected",
                                 buttonLabel = "Browse..."),
                        #DR button
                        actionButton(inputId = "DR",
                                     label = "OK"),
                         #Results text field
                         verbatimTextOutput(outputId = "outputtext",
                                            placeholder = TRUE),
                         #Image Field
                         imageOutput("img"))
  )
)

#Server code
server <- function(input,output, session){

  #ok event
  observeEvent(input$DR, {
    
    if(!is.null(file)){
      file <- isolate(input$image)
      source("image_classifier.R")
      predict_probs <- classify(file)
      output$img <- renderImage({
        list(src=file$datapath, alt=file$name, contentType=file$type)
      }, deleteFile=FALSE)
      output$outputtext <- renderText({paste0("\nPatient :", file$datapath,
                                              "\nNormal Level of NPR:", round(predict_probs[1], digits = 4), 
                                              "\nAbnormal Level of NPR:", round(predict_probs[2], digits = 4))})
    }else{
      output$outputtext <- renderText({paste0("No image selected...")})
    }
  })
}

shinyApp(ui = ui, server = server)