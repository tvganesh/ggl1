printOrPlotIPLTeamPerfOverall <- function(input,output){
    # Set the rank of player
    rankValues <- c(1,2,3,4,5,6)
    output$Rank = renderUI({
        selectInput('rank', 'Choose the rank',choices=rankValues,selected=input$rank)
    })
    
    print(input$teamMatches)
    n <- strsplit(as.character(input$teamMatches),"-")
    #print(n[[1]][2])
    
    analyzeIPLTeamPerfOverall(input$teamMatches,input$overallperfFunc,n[[1]][2],input$rank)
    


}