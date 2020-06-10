library(shiny)


shinyServer(function(input, output) {
  
  streaming_history_dt <- eventReactive(input$streaming_history,{
    
    tryCatch(
      {

        read_files <- rbindlist(lapply(input$streaming_history$datapath,
                                       jsonlite::fromJSON))
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
    
    tryCatch(
      {
        
        read_files <- data.table(jsonlite::fromJSON(input$search_queries$datapath))
        read_files <- read_files[,list(date = lubridate::ymd(date), platform, country)]
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
  
  #### plots streaming history ####
  ### ARTUR
  
  ### playtime
  output$ui_play_time = renderUI({if (input$t_or_c_play_time == "time") {
    radioButtons("t_units_play_time", "Time units",
                 choices = c("Hours" = "hours", "Minutes" = "minutes", "Seconds" = "seconds")
    )
  }
  })
  
  ### for plots with playlists
  str_hist_plot_str_his = eventReactive({input$start_date_plots_str_his
    input$end_date_plots_str_his
    input$streaming_history
    input$playlist
  },
  {str_his_filtered = filter_streaming_history(streaming_history_dt(),
                                               start_date = input$start_date_plots_str_his,
                                               end_date = input$end_date_plots_str_his)
  str_his_filtered
  
  })
  
  
  str_hist_plot_str_his_wo_playlists = eventReactive({input$start_date_plots_str_his
    input$end_date_plots_str_his
    input$streaming_history
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
  
  
  
  ### popular playlists
  
  output$ui_pop_playlists = renderUI({if (input$t_or_c_pop_playlists == "time") {
    radioButtons("t_units_pop_playlists", "Time units",
                 choices = c("Hours" = "hours", "Minutes" = "minutes", "Seconds" = "seconds")
    )
  }
  })
  
  output$str_his_plot_pop_playlists = renderPlot({
    plot_playlist_popularity(str_his_with_playlists_long = str_his_with_playlists_long(playlist_dt(), str_hist_plot_str_his()),
                             time_or_count = input$t_or_c_pop_playlists, time_unit = input$t_units_pop_playlists)
  })
  
  
  ### track counts 
  
  output$str_his_plot_track_count = renderPlot({
    plot_track_count(str_hist_plot_str_his_wo_playlists(),
                     only_skipped = as.logical(input$skipped_track_count),
                     by = input$time_track_count)
  })
  
  #### track counts by period
  
  output$ui_track_period = renderUI({if (input$by_track_period == "hour") {
    radioButtons("by_weekday_track_period", "By weekday",
                 choices = c("Yes" = TRUE, "No" = FALSE), selected = c("No" = FALSE)) 
  }
  })
  
  
  output$str_his_plot_track_period = renderPlot({
    plot_track_count_by_period(str_hist_plot_str_his_wo_playlists(),
                               period = input$by_track_period, include_skipped = as.logical(input$skipped_track_period),
                               as_percentage = as.logical(input$percentage_track_period),
                               by_weekday = as.logical(input$by_weekday_track_period))
  })
  
  ### sessions plot
  
  output$str_his_plot_session = renderPlot({
    sessions_visualize(str_hist_plot_str_his_wo_playlists(), mins = 5, as_percentage = as.logical(input$session_plot))
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
  longest_session_dt <- eventReactive({input$start_date_tables
    input$end_date_tables
    input$streaming_history},
    {
      longest_session_dt <- longest_session(streaming_history_filtered_tables(),5)
      longest_session_dt
    }
    
  )
  
  output$longest_session <- renderDT(session_for_view(longest_session_dt()))
  
  output$longest_session_summ <- renderTable(make_session_stats(longest_session_dt()))
  
  
  ### user comparison
  ## input from other user 
  streaming_history_dt_u2 <- eventReactive(input$streaming_history_u2,{
    
    tryCatch(
      {
        
        read_files <- rbindlist(lapply(input$streaming_history_u2$datapath,
                                       jsonlite::fromJSON))
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    
    streaming_history_dt_u2 <- prepare_streaming_history(read_files)
    streaming_history_dt_u2
    
  })
  
  output$streaming_historyDT_u2 <- renderDataTable(streaming_history_dt_u2())
  
  
  search_queries_dt_u2 <- eventReactive(input$search_queries_u2,{
    
    tryCatch(
      {
        
        read_files <- data.table(jsonlite::fromJSON(input$search_queries_u2$datapath))
        read_files <- read_files[,list(date = lubridate::ymd(date), platform, country)]
      }, 
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    search_queries_dt_u2 <- read_files
    search_queries_dt_u2
  })
  output$search_queriesDT_u2 <- renderDataTable(search_queries_dt_u2())
  
  
  playlist_dt_u2 <- eventReactive(input$playlist_u2,{
    tryCatch(
      {
        
        playlists_u2 = playlist_shiny(input$playlist_u2$datapath)
        
      },
      error = function(e) {
        stop(safeError(e))
      }
    )
    
    playlist_dt_u2 <- playlists_u2
    
    playlist_dt_u2
    
  }) 
  
  output$playlistDT_u2 <- renderDataTable(playlist_dt_u2())
  
  ## for plots
  
  two_users_day <- eventReactive({input$date_day_compare
    input$streaming_history_u2
    input$streaming_history},
    {
      two_users_day <- make_two_users_dt(streaming_history_dt(), streaming_history_dt_u2(), input$date_day_compare)
      two_users_day
    }
  )
  observeEvent(input$take_names,
               {
                 
                 output$day_compare <- renderPlot({
                   plot_day_comparison(two_users_day(), input$u1_name, input$u2_name
                   )
                 }) 
               })
  
  ## for tables
  
  output$common_dt <- renderDT({
    common <- compare_history(streaming_history_dt(),streaming_history_dt_u2(), by_track = as.logical(input$tracks_common))
    setnames(common, old = c("artist_name", "track_name"), new = c("Artist name", "Track name"), skip_absent = TRUE)
    common
  }
  )
  
  
  
})
