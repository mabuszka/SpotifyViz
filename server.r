server <- function(input, output) {
  
  
  output$ui2 <- renderUI({if(input$which_plots == "Number of songs") {
    radioButtons("count_skipped", "Count skipped songs",
                 choices = list("Yes" = FALSE, "No" = TRUE), selected = TRUE)}
  })
  
  output$ui3 <- renderUI({if(input$which_plots == "Number of songs"){
    radioButtons("split_by_weekday", "Split number of songs listened on different hours by weekdays",
                 choices = list("Yes" = TRUE, "No" = FALSE), selected = FALSE)
  }})
  
  output$ui4 <- renderUI({if(input$which_plots == "Number of songs") {
    radioButtons("skipped_by", "Show how many songs were skipped by",
                 choices = list("Day" = "day","Week" = "week", "Month" = "month"), selected = "day")}
  })
  
  output$ui5 <- renderUI({if(input$which_plots == "Number of songs") {
    radioButtons("skipped_type", "Type of skipped songs plot",
                 choices = list("Bar plot" = "bar", "Scatter plot" = "point"), selected = "bar")}
  })
  
  output$ui_plot1 <- renderUI({switch(input$which_plots, 
                                      "Country" = plotOutput("country_plot1"),
                                      "Platform used" = plotOutput("platform_plot1"),
                                      "Number of songs" = plotOutput("songs_plot1"))
  })
  output$ui_plot2 <- renderUI({switch(input$which_plots, 
                                      "Country" = plotOutput("country_plot2"),
                                      "Platform used" = plotOutput("platform_plot2"),
                                      "Number of songs" = plotOutput("songs_plot2"))
  })
  
  output$ui_plot3 <- renderUI({switch(input$which_plots,
                                      "Number of songs" = plotOutput("songs_plot3"))
  })
  
  output$ui_header_1 <-renderUI({switch(input$which_plots,
                                        "Country" = h4("In which countries was Spotify used"),
                                        "Platform used" = h4("On which platforms was Spotify used"),
                                        "Number of songs" = h4("Number of songs listened - by weekdays")
  )})
  
  output$ui_header_2 <-renderUI({switch(input$which_plots,
                                        "Country" = h4("In which countries was Spotify used over time"),
                                        "Platform used" = h4("On which platforms was Spotify used over time"),
                                        "Number of songs" = h4("Number of songs listened - by hours")
  )})
  
  output$ui_header_3 <-renderUI({switch(input$which_plots,
                                        "Number of songs" = h4("Number of skipped songs")
  )})
  
  output$country_plot1 <- renderPlot({country_by_date(search_queries, input$start_date_plots, input$end_date_plots)})
  
  output$platform_plot1 <- renderPlot({platform_used_by_date(search_queries, input$start_date_plots, input$end_date_plots)})
  
  output$songs_plot1 <-renderPlot({
    number_of_songs_listened_by_weekday(
      streaming_history, 
      input$start_date_plots, 
      input$end_date_plots, 
      dont_show_skipped =  input$count_skipped
      )
    })
    
  
  output$country_plot2 <- renderPlot({country(search_queries, input$start_date_plots, input$end_date_plots)})
  
  output$platform_plot2 <- renderPlot({platform_used(search_queries, input$start_date_plots, input$end_date_plots)})
  
  output$songs_plot2 <- renderPlot({
    number_of_songs_listened_by_hour(
      streaming_history,
      input$start_date_plots, 
      input$end_date_plots, 
      by_weekday = input$split_by_weekday, 
      dont_show_skipped = input$count_skipped
      )
    })
  
  output$songs_plot3 <- renderPlot({
      number_of_skipped_songs(
        streaming_history,
        input$start_date_plots,
        input$end_date_plots,
        by = input$skipped_by,
        type = input$skipped_type
      )
    })
  
  output$Table2 <- renderDataTable({
      most_played_skipped_track_artist(
        streaming_history,
        input$start_date_tables,
        input$end_date_tables,
        input$how_many_tables,
        input$skipped_or_played_tables,
        input$track_or_artist_tables
      )
    })
  
  output$summary_table <- renderTable({
      create_summary_table(
        streaming_history,
        input$start_date_summary,
        input$end_date_summary,
        input$as_percentage_summary
      )
    })
}