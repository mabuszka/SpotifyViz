



library(shiny)


shinyServer(function(input, output) {
  
  
    # req(input$StreamingHistory)
  streaming_history_dt <- eventReactive(input$StreamingHistory,{
    
    tryCatch(
      {
        
        read_files <- rbindlist(lapply(input$StreamingHistory$datapath, jsonlite::fromJSON))
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    
    streaming_history_dt <- prepare_streaming_history(read_files)
    
  })
  
    output$StreamingHistoryDT <- renderDataTable(streaming_history_dt())

  
  search_queries_dt <- eventReactive(input$SearchQueries,{
    
    # req(input$SearchQueries)
    tryCatch(
      {
        
        read_files <- data.table(jsonlite::fromJSON(input$SearchQueries$datapath))
        read_files <- read_files[,list(date=ymd(date), platform, country)]
      }, 
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    search_queries <- read_files
    search_queries
  })
  output$SearchQueriesDT <- renderDataTable(search_queries_dt())
  
  
  playlist_dt <- eventReactive(input$Playlist,{
    # req(input$Playlist)
    tryCatch(
      {
        
        playlists = playlist_shiny(input$Playlist$datapath)
        
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    playlist_dt <- playlists
    
    
  }) 
  
  output$PlaylistDT <- renderDataTable(playlist_dt())
  
})
