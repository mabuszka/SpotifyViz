



library(shiny)


shinyServer(function(input, output) {
  
  output$StreamingHistoryDT <-renderDataTable({
    req(input$StreamingHistory)
    
    tryCatch(
      {
        
        read_files <- rbindlist(lapply(input$StreamingHistory$datapath, jsonlite::fromJSON))
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    
    return(prepare_streaming_history(read_files))
  })

  
  output$SearchQueriesDT <- renderDataTable({
    req(input$SearchQueries)
    tryCatch(
      {
        
        read_files <- data.table(jsonlite::fromJSON(input$SearchQueries$datapath))
        read_files <- read_files[,list(date=ymd(date),platform,country)]
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    return(read_files)
  })
  
  output$PlaylistDT <- renderDataTable({
    req(input$Playlist)
    tryCatch(
      {
        
       playlists = playlist_shiny(input$Playlist$datapath)
        
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    return(playlists)
    
    
  })
})
