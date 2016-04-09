library(shiny)

shinyUI(
        navbarPage('Next Word Predictor', inverse = TRUE, collapsible = TRUE,
                   
                   tabPanel("Predictor",
                            fluidRow(
                                    column(6, offset=3,
                                           wellPanel(
                                                   textInput("text", label = h2("Enter Text "),
                                                             value = "Begin typing to see next word suggestions below...")
                                           )
                                    )
                            ),
                            hr(),
                            fluidRow(
                                    column(6, offset = 3,
                                           "suggested text goes here"
                                    )
                            ),
                            fluidRow(
                                    column(6, offset = 3,
                                           a("Author: Ash Chakraborty",
                                             href='http://theintentionalmachine.net/about/')
                                    )
                            )
                   ),
                   tabPanel("About")
        )
)