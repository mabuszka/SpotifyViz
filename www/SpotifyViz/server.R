



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
  
  
  
  
  ## MAGDA
  
  # generate defoult value of date inputs
  output$end_date_tables_ui <- renderUI(
    {
      dateInput('end_date_tables',
                     label = ('End date: yyyy-mm-dd'),
                     value = max_date(streaming_history_dt()))
    }
           )
  
  output$start_date_tables_ui <- renderUI(
    {
      dateInput('start_date_tables',
                label = ('Start date: yyyy-mm-dd'),
                value = min_date(streaming_history_dt()))
    }
  )

  
  streaming_history_filtered_tables <- eventReactive({input$start_date_tables 
                                                      input$end_date_tables
                                                      input$StreamingHistory},
                                                     {
                                                       str_his_filtered <-  filter_streaming_history(streaming_history_dt(),
                                                                                                     start_date = input$start_date_tables,
                                                                                                     end_date = input$end_date_tables)
                                                       str_his_filtered
                                                     })
  output$most_skipped <- renderDT(most_skipped(streaming_history_filtered_tables(),
                                               track_or_artist = input$track_or_artist_tables))
  
  output$most_played <- renderDT(most_played(streaming_history_filtered_tables(), 
                                             track_or_artist = input$track_or_artist_tables))
  
  
  ## MAGDA
  
})
