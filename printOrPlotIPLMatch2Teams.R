printOrPlotIPLMatch2Teams <- function(input,output){
    # Get the IPL teams
    p <- strsplit(as.character(input$match2),"-")
    teams2 <- c(p[[1]][1],p[[1]][2])
    
    # Set the IPL teams
    output$selectTeam2 <- renderUI({ 
        selectInput('team2', 'Choose team',choices=teams2,selected=input$team2)
    })
    output$selectRepType <- renderUI({ 
        radioButtons("DetailedorSummary", label = h4("Report Type"),
                     choices = c("Summary" = 1, "Detailed" = 2), 
                     selected = 1,inline=T)
    })
    #Find the other team
    otherTeam = setdiff(teams2,input$team2)
    a <- analyzeIPLMatches2Teams(input$match2,input$matches2TeamFunc,input$plotOrTable1,input$team2,otherTeam)
    a
}