library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Subset data from a CSV before analyzing"),
  sidebarPanel(fileInput(inputId = "DataFile", label = "Upload list the data")),
  mainPanel(tabsetPanel(
    tabPanel("Pick Students",uiOutput("StudentCheckList")),
    tabPanel("Pick Classes",uiOutput("ClassCheckList")),
    tabPanel("Summary",tableOutput("Summary"))
  ))
))
