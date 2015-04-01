#There are several bits of code of the form if(is.null(object)){return() 
#This is to prevent that reactive function from executing before the requisite steps are completed

#Frequently, there is a tagList function wrapping the widget definition in renderUI functions
#This is to allow the renderUI to be expanded to hold multiple widgets

library(shiny)
shinyServer(function(input, output) {  
  
  #This creates a reactive data.frame of the contents of the csv.
  #Since it is reactive, to access it as a data.frame, you must use d1() not just d1
  d1 = reactive(
    if(is.null(input$DataFile)){return()
    } else {d2 = read.csv(input$DataFile$datapath)
            return(d2)}
  ) #end of d1 definition
  
  #This pulls a list of unique names from the Student column of the data and creates a checklist
  output$StudentCheckList <- renderUI({
    if(is.null(d1())){return ()
    } else tagList(
      checkboxGroupInput(inputId = "SelectedStudents", 
                         label = "Which students you like to select?", 
                         choices = unique(as.character(d1()$Student)))
    )
  }) #end of output$StudentCheckList definition
  
  #This pulls a list of unique names from the Class column of the data and creates a checklist
  output$ClassCheckList <- renderUI({
    if(is.null(d1())){return ()
    } else tagList(
      checkboxGroupInput(inputId = "SelectedClasses", 
                         label = "Which classes would you like to select?", 
                         choices = unique(as.character(d1()$Class)))
    )
  }) #end of output$ClassCheckList definition
  
  #This generates the table of data subsetted by the checklist selections
  #This code will not run until the user clicks on the Summary tab
  output$Summary = renderTable({
    if(is.null(d1())){return ()
    } else {
      d3 = d1()[which(as.character(d1()$Student) %in% input$SelectedStudents),]
      d3 = d3[which(as.character(d3$Class) %in% input$SelectedClasses),]
      return(d3)
    }
  }) #end of output$Summary definition
  
}) #end of shinyServer function