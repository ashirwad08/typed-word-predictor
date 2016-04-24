library(shiny)
#source("./src/nextWordPredictor.R")

#loadGrams()

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
                                                   tags$h4(uiOutput("predictions", inline = TRUE)),
                                                   tags$br(),
                                                   tags$hr()
                                           )
                                           
                                    )
                            ),
                            fluidRow(
                                    column(6, offset = 3,
                                           a("Author: Ash Chakraborty",
                                             href='https://www.linkedin.com/in/ashirwadchakraborty/')
                                    )
                            )
                   ),
                   
                   
                   tabPanel("About",
                            fluidRow(
                                    column(6, offset=3,
                                           tags$div(
                                                   tags$br(),
                                                   tags$h2('Instructions'),
                                                   tags$p('Please allow approximately 10 seconds for initial training, on first load.'),
                                                   tags$img(src='WORD_instructions.png', align='center',width='525',height='300'),
                                                   tags$br()
                                                   ),
                                           tags$br(),
                                           tags$hr(),
                                           tags$div(
                                                   tags$a("App. Code",
                                                     href='https://github.com/ashirwad08/typed-word-predictor'),
                                                   tags$br(),
                                                   tags$a("App. Pitch",
                                                     href='http://rpubs.com/ashirwad/word'),
                                                   tags$br(),
                                                   tags$a("Author",
                                                     href="https://www.linkedin.com/in/ashirwadchakraborty/")
                                                   )
                                                   
                                           )
                                    )
                            )
                   )
)