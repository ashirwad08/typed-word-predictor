library(shiny)

shinyUI(
        navbarPage('Word! The Next Word Predictor', inverse = TRUE, collapsible = TRUE,
                   
                   tabPanel("Predictor",
                            fluidRow(
                                    column(6, offset=3,
                                           wellPanel(
                                                   textInput("inputstream", label = h2("Enter Text "),
                                                             value = "Begin typing to see next word suggestions")
                                           )
                                    )
                            ),
                            hr(),
                            fluidRow(
                                    column(6, offset = 3,
                                           tags$div(
                                                   tags$br(),
                                                   tags$h2('Top 3 Predictions...'),
                                                   tags$h3(uiOutput("predictions", inline = TRUE)),
                                                   tags$br(),
                                                   tags$hr()
                                           )
                                           
                                    )
                            ),
                            fluidRow(
                                    column(6, offset = 3,
                                           a("Author: Ash Chakraborty",
                                             href='http://https://www.linkedin.com/in/ashirwadchakraborty/')
                                    )
                            )
                   ),
                   tabPanel("About")
        )
)