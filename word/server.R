
library(shiny)
library(data.table)
library(stringi)
library(quanteda)

#source("src/generateNGramTable.R")
source("src/nextWordPredictor.R")

shinyServer(function(input, output) {
        
        # speed up prediction (smaller DT)
        # predict on quadgrams at least, then backoff
        # get back predictions and probabilities and input predictors
        # display input grams
        # display html output predictions
        # display wordcloud if fast enough (or on generation)
        
     
          output$predictions <- renderUI({
                  predictions <- predict_trigram(processInput(input$inputstream), bigramDT, trigramDT)
                  
                  HTML(paste0('<span style="font-size: 2em !important; color: #009933;">', 
                              predictions[1], '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;', predictions[2], '&ensp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;', 
                         predictions[3],'</span>'))
          })      
#         
#         
#         Prediction <- eventReactive(input$submitButton, {
#                 predictDonation(floor((as.Date('2007-02-28')-input$dateRange[1])/30)[[1]],
#                                 floor((as.Date('2007-02-28')-input$dateRange[2])/30)[[1]],
#                                 input$volumeDonated, 
#                                 fit.glm.final, fit.rpart.final, fit.svm.final, fit.rf.final)
#         })
#         
#         
#         output$prediction <- renderTable({
#                 Prediction()
#         })
})

