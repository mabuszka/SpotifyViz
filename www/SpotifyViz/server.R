



library(shiny)


shinyServer(function(input, output) {
  
  # req(input$StreamingHistory)
  streaming_history_dt <- eventReactive(input$streaming_history,{
    
    tryCatch(
      {
        
        read_files <- rbindlist(lapply(input$streaming_history$datapath, jsonlite::fromJSON))
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    
    streaming_history_dt <- prepare_streaming_history(read_files)
    streaming_history_dt
    
  })
  
  output$streaming_historyDT <- renderDataTable(streaming_history_dt())
  
  
  search_queries_dt <- eventReactive(input$search_queries,{
    
    # req(input$SearchQueries)
    tryCatch(
      {
        
        read_files <- data.table(jsonlite::fromJSON(input$search_queries$datapath))
        read_files <- read_files[,list(date=ymd(date), platform, country)]
      }, 
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    search_queries <- read_files
    search_queries
  })
  output$search_queriesDT <- renderDataTable(search_queries_dt())
  
  
  playlist_dt <- eventReactive(input$playlist,{
    # req(input$Playlist)
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
  
  output$playlistDT <- renderDataTable(playlist_dt())
  
  ### plots search queries
  
  str_his_fil_plot_search_que <- eventReactive({input$start_date_plots_search_que
    input$end_date_plots_search_que
    input$search_queries},
    {
      str_his_filtered <-  filter_search_queries(search_queries_dt(),
                                                    start_date = input$start_date_plots_search_que,
                                                    end_date = input$end_date_plots_search_que)
      str_his_filtered
    })
  
  output$plot_searches = renderPlot(
    plot_searches(str_his_fil_plot_search_que(), additional = input$radio_btn_plot_search_que)
    
  )
  
  
  
  
  
  ## MAGDA
  
  
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
  
  output$most_played <- renderDT(most_played(streaming_history_filtered_tables(), track_or_artist = input$track_or_artist_tables))
  
  
  ## MAGDA
  
})
