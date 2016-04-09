
library(shiny)
library(caret)

#options(shiny.maxRequestSize=60*1024^2) 
#source("load_train_bloodDonation.R")
#source("predict_bloodDonation.R")

shinyServer(function(input, output) {
        
#         output$volDonated <- renderText({paste0("Volume Donated: ", input$volumeDonated, " c.c.")})
#         output$start <- renderText({paste0("First Donation: ", floor((as.Date('2007-02-28')-input$dateRange[1])/30)[[1]]," months ago. \n")})
#         output$recent <- renderText({paste0("Most Recent Donation: ",  floor((as.Date('2007-02-28')-input$dateRange[2])/30)[[1]], " months ago. \n")})
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

