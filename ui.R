library(shiny)
library(ggplot2)
library(ggtern)

shinyUI(fluidPage(
  
  title = "Diagrama de fase. BIOMAT 2016",
  
  plotOutput("distPlot", width = "100%", height = "700px"),
  
  hr(),
  
  fluidRow(
    column(3,
           h4("Diagrama de fase. BIOMAT 2016"),
           numericInput("itf", "itf", 20)
    ),
    column(3,
           numericInput("AA", "AA", 0),
           numericInput("AB", "AB", -1),
           numericInput("AC", "AC", 1)
    ),
    column(3,
           numericInput("BA", "BA", 1, min = -100, max = 100),
           numericInput("BB", "BB", 0, min = -100, max = 100),
           numericInput("BC", "BC", -1, min = -100, max = 100)
    ),
    column(3,
           numericInput("CA", "CA", -1, min = -100, max = 100),
           numericInput("CB", "CB", 1, min = -100, max = 100),
           numericInput("CC", "CC", 0, min = -100, max = 100)
    )
  )
))
  
  
  
  

