printOrPlotIPLMatch <- function(input,output,teams,otherTeam){
    m <- strsplit(as.character(input$match),"-")
    print(m[[1]][1])
    print(m[[1]][2])
    
    teams <- c(m[[1]][1],m[[1]][2])
    #print(teams)
    
    # Set the IPL teams
    output$selectTeam <- renderUI({ 
        selectInput('team', 'Choose team',choices=teams,selected=input$team)
    })
    #print(input$team)
    # Find the opposition IPL team
    otherTeam = setdiff(teams,input$team)
    #print(otherTeam)
    a <- analyzeIPLMatches(input$match,input$matchFunc,input$plotOrTable,input$team,otherTeam)
    #print("Hi")
    #print(a)
    a
}