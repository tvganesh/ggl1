#########################################################################################################
#
# Title :  Googly - An interactive app to analyze IPL Players, teams and matches 
# Designed and developed by: Tinniam V Ganesh
# Date : 25 Dec 2016
# File: server.R
# More details: https://gigadom.wordpress.com/
#
#########################################################################################################
library(shiny)
library(yorkr)
library(rpart)
library(dplyr)
library(ggplot2)
library(rpart.plot)

# Source files

source("definitions.R")
source("funcs.R")
source("analyzeIPLBatsmen.R")
source("analyzeIPLBowlers.R")
source("analyzeIPLMatches.R")
source("analyzeIPLMatches2Teams.R")
source("analyzeIPLTeamPerfOverall.R")
source("printOrPlotIPLMatch.R")
shinyServer(function(input, output,session) {
    
    # Analyze and display batsmen plots
    output$batsmanPlot <- renderPlot({  
        analyzeIPLBatsmen(input$batsman,input$batsmanFunc)
        
    })
    
    # Analyze and display bowler plots
    output$bowlerPlot <- renderPlot({  
        analyzeIPLBowlers(input$bowler,input$bowlerFunc)
        
    })
    
    output$IPLMatchPlot <- renderPlot({ 
        printOrPlotIPLMatch(input, output)
     
    })
    output$IPLMatchPrint <- renderPrint({ 
        a <- printOrPlotIPLMatch(input, output)
        a 
        #print(scorecard)
        
        
    })
    output$plotOrPrint <-  renderUI({ 
        if(is.data.frame(scorecard <- printOrPlotIPLMatch(input, output))){
            verbatimTextOutput("IPLMatchPrint")
        }
        else{
            plotOutput("IPLMatchPlot")
        }
      
    })
   
    # Analyze Head to head confrontation of IPL teams
    output$IPLMatch2TeamsPlot <- renderPlot({  
        # Get the IPL teams
        p <- strsplit(as.character(input$match2),"-")
        teams2 <- c(p[[1]][1],p[[1]][2])
        #print(teams2)
        # Set the IPL teams
        output$selectTeam2 <- renderUI({ 
            selectInput('team2', 'Choose team',choices=teams2,selected=input$team2)
        })
        #Find the other team
        otherTeam = setdiff(teams2,input$team2)
        analyzeIPLMatches2Teams(input$match2,input$matches2TeamFunc,input$team2,otherTeam)
        
    })
    # Analyze overall IPL team performance plots
    output$IPLTeamPerfOverall <- renderPlot({  
        # Set the rank of player
        rankValues <- c(1,2,3,4,5,6)
        output$Rank = renderUI({
            selectInput('rank', 'Choose the rank',choices=rankValues,selected=input$rank)
        })
        
        print(input$teamMatches)
        n <- strsplit(as.character(input$teamMatches),"-")
        #print(n[[1]][2])
        
        analyzeIPLTeamPerfOverall(input$teamMatches,input$overallperfFunc,n[[1]][2],input$rank)
        
    })
    
    
})
