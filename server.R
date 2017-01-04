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
source('printOrPlotIPLMatch2Teams.R')
shinyServer(function(input, output,session) {
    
    # Analyze and display batsmen plots
    output$batsmanPlot <- renderPlot({  
        analyzeIPLBatsmen(input$batsman,input$batsmanFunc)
        
    })
    
    # Analyze and display bowler plots
    output$bowlerPlot <- renderPlot({  
        analyzeIPLBowlers(input$bowler,input$bowlerFunc)
        
    })
    
    ######################################## IPL Match  #############################################
    # Analyze and display IPL Match plot
    output$IPLMatchPlot <- renderPlot({ 
        printOrPlotIPLMatch(input, output)
     
    })
    
    # Analyze and display IPL Match table
    output$IPLMatchPrint <- renderPrint({ 
        a <- printOrPlotIPLMatch(input, output)
        a 
        
    })
    output$plotOrPrintIPLMatch <-  renderUI({ 
        # Check if output is a dataframe. If so, print
        if(is.data.frame(scorecard <- printOrPlotIPLMatch(input, output))){
            verbatimTextOutput("IPLMatchPrint")
        }
        else{ #Else plot
            plotOutput("IPLMatchPlot")
        }
      
    })
   
    #################################### IPL Matches between 2 teams
    # Analyze Head to head confrontation of IPL teams
    
    # Analyze and display IPL Matches between 2 teams plot
    output$IPLMatch2TeamsPlot <- renderPlot({ 
        printOrPlotIPLMatch2Teams(input, output)
        
    })
    
    # Analyze and display IPL Match table
    output$IPLMatch2TeamsPrint <- renderTable({ 
        a <- printOrPlotIPLMatch2Teams(input, output)
        head(a,n=20)
        #a
    })
    output$plotOrPrintIPLMatch2teams <-  renderUI({ 
        # Check if output is a dataframe. If so, print
        if(is.data.frame(scorecard <- printOrPlotIPLMatch2Teams(input, output))){
            tableOutput("IPLMatch2TeamsPrint")
        }
        else{ #Else plot
            plotOutput("IPLMatch2TeamsPlot")
        }
        
    })
    

    
    ################################ IPL Teams's overall performance ##############################
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
