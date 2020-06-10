



library(shiny)


shinyServer(function(input, output) {
  
  str_hist_dt_u1 = eventReactive(input$do_plots, {
        
        read_files_str_hist <- rbindlist(lapply(input$streaming_history$datapath, jsonlite::fromJSON))
        prepare_streaming_history(read_files_str_hist)
  })
  
  search_queries_dt_u1 = eventReactive(input$do_plots, {
      
    read_files <- data.table(jsonlite::fromJSON(input$search_queries$datapath))
    read_files[,list(date=ymd(date),platform,country)]
  })
  
  playlists_dt_u1 = eventReactive(input$do_plots, {
    playlist_shiny(input$playlist$datapath)
  })
  

  ### data four user 1
  output$streaming_historyDT <-renderDataTable({
    req(input$streaming_history)
    
    tryCatch(
      {
        
        read_files <- rbindlist(lapply(input$streaming_history$datapath, jsonlite::fromJSON))
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    
    streaming_history_dt <- prepare_streaming_history(read_files)
    
  })
  
    output$StreamingHistoryDT <- renderDataTable(streaming_history_dt())

  
  output$search_queriesDT <- renderDataTable({
    req(input$search_queries)
    tryCatch(
      {
        
        read_files <- data.table(jsonlite::fromJSON(input$search_queries$datapath))
        read_files <- read_files[,list(date=ymd(date),platform,country)]
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    search_queries <- read_files
    search_queries
  })
  output$SearchQueriesDT <- renderDataTable(search_queries_dt())
  
  output$playlistDT <- renderDataTable({
    req(input$playlist)
    tryCatch(
      {
        
       playlists = playlist_shiny(input$playlist$datapath)
        
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    playlist_dt <- playlists
    
    
  })
  
  ##### data for user 2
  
  output$streaming_historyDT_u2 <-renderDataTable({
    req(input$streaming_history_u2)
    
    tryCatch(
      {
        
        read_files <- rbindlist(lapply(input$streaming_history_u2$datapath, jsonlite::fromJSON))
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    
    return(prepare_streaming_history(read_files))
  })
  
  
  output$search_queriesDT_u2 <- renderDataTable({
    req(input$search_queries_u2)
    tryCatch(
      {
        
        read_files <- data.table(jsonlite::fromJSON(input$search_queries_u2$datapath))
        read_files <- read_files[,list(date=ymd(date),platform,country)]
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    return(read_files)
  })
  
  output$playlistDT_u2 <- renderDataTable({
    req(input$playlist_u2)
    tryCatch(
      {
        
        playlists = playlist_shiny(input$playlist_u2$datapath)
        
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    return(playlists)
    
    
  })
  
  ### plots user 1
  
  output$plot_searches = renderPlot({
    
    plot_searches(search_queries_dt_u1())
  })
})
