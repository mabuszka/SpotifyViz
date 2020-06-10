



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
    
    playlist_dt
    
  }) 
  
  output$playlistDT <- renderDataTable(playlist_dt())
  
  ### plots search queries
  ## ARTUR
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
  
  #### plots streaming history
  ### ARTUR
  
  output$text <- renderText(input$as_per_str_his_play_time)
  
  output$ui_play_time = renderUI({if (input$t_or_c_play_time == "time") {
    radioButtons("t_units_play_time", "Time units",
                 choices = c("Hours" = "hours", "Minutes" = "minutes", "Seconds" = "seconds")
    )
  }
  })
  
  str_hist_plot_str_his = eventReactive({input$start_date_plots_str_his
    input$end_date_plots_str_his
    input$streaming_history
    #input$playlist
    },
    {str_his_filtered = filter_streaming_history(streaming_history_dt(),
                                                 start_date = input$start_date_plots_str_his,
                                                 end_date = input$end_date_plots_str_his)
    str_his_filtered
      
    })
  
  
  output$str_his_plot_play_time = renderPlot({
    plot_in_playlists_count(str_his_with_playlist_wide = str_his_with_playlists_wide(playlist_dt(), str_hist_plot_str_his()),
                            time_or_count = input$t_or_c_play_time, time_unit = input$t_units_play_time,
                            as_percentage = as.logical(input$as_per_str_his_play_time)
                            )
  })
  
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

  ## filter streaming_history for tables
  streaming_history_filtered_tables <- eventReactive({input$start_date_tables 
                                                      input$end_date_tables
                                                      input$streaming_history},
                                                     {
                                                       str_his_filtered <-  filter_streaming_history(streaming_history_dt(),
                                                                                                     start_date = input$start_date_tables,
                                                                                                     end_date = input$end_date_tables)
                                                       str_his_filtered
                                                     })
  
  # tables
  output$most_skipped <- renderDT(most_skipped(streaming_history_filtered_tables(),
                                               track_or_artist = input$track_or_artist_tables,
                                               how_many = input$how_many_tables))
  
  output$most_played <- renderDT(most_played(streaming_history_filtered_tables(), 
                                             track_or_artist = input$track_or_artist_tables,
                                             how_many = input$how_many_tables))
  
  output$summary_dt <- renderTable(make_summary_dt(streaming_history_dt(), 
                                                input$start_date_tables, 
                                                input$end_date_tables,
                                                as_percentage = as.logical(input$as_percentage_summary)
                                                ))
  
  
  ## MAGDA
  
})
