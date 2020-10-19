#' Visualize popularity of different playlist
#'
#' Visualize, using a bar chart, how popular were different playlists. Either by number of tracks played or play time.
#'
#' @param str_his_with_playlists_long A data table containing streaming history with information about playlists,
#' in long form, made with \code{\link{str_his_with_playlists_long}}.
#' @param time_or_count A character vector indicating whether to count number of tracks played
#' or the time they were played.
#' @param time_unit A character vector indicating the time unit to use if showing an absolute value of time played.
#' Permitted vales are "seconds", "minutes", "hours".
#'
#' @export


plot_playlist_popularity <-
  function(str_his_with_playlists_long,
           time_or_count = "time",
           time_unit = "hours") {
    . <- playlist_name <- s_played  <- time <- count <- NULL
    
    
    summary <-
      str_his_with_playlists_long[, .(count = .N, time = sum(s_played)), by = playlist_name][(!is.na(playlist_name)), ][order(eval(as.name(time_or_count)))][, playlist_name := factor(playlist_name,
                                                                                                                                                                                      levels = as.character(playlist_name))]
    viz <- ggplot(summary) +
      theme_spotifyviz() +
      theme(axis.title.y = element_blank())
    
    if (time_or_count == "time") {
      time_units <- c("seconds" = 1,
                      "minutes" = 60,
                      "hours" = 3600)
      abbr <- c("seconds" = "s",
                "minutes" = "min",
                "hours" = "h")
      
      viz <- viz +
        geom_bar(
          aes(y = playlist_name, x = time / time_units[time_unit]),
          stat = "identity",
          fill = "#440154FF",
          colour = "white"
        ) +
        labs(x = "Play time") +
        scale_x_continuous(
          labels = function(x) {
            paste(x, abbr[time_unit])
          }
        )
      
      
    }
    
    else{
      viz <- viz +
        geom_bar(
          aes(y = playlist_name, x = count),
          stat = "identity",
          fill = "#440154FF",
          colour = "white"
        ) +
        labs(x = "Tracks played")
      
    }
    
    viz
  }
