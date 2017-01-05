printOrPlotIPLMatch <- function(input,output){
    m <- strsplit(as.character(input$match),"-")
    teams <- c(m[[1]][1],m[[1]][2])
  
    
    # Set the IPL teams
    output$selectTeam <- renderUI({ 
        selectInput('team', 'Choose team',choices=teams,selected=input$team)
    })
 
    otherTeam = setdiff(teams,input$team)
    a <- analyzeIPLMatches(input$match,input$matchFunc,input$plotOrTable,input$team,otherTeam)
    a
}