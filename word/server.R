
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
        
     
          output$predictions <- renderText({
                  predict_trigram(processInput(input$inputstream),
                                  bigramDT, trigramDT)
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

