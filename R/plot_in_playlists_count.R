#' Visualize how much of music listened to was from playlists
#' 
#' Visualize, using a bar chart, how much music listened to was from playlists. 
#' Either counting the number of tracks played or play time.

#' @param str_his_with_playlist_wide A data table containing streaming history with information about playlists, 
#' in wide form, made with \code{\link{str_his_with_playlists_wide}}.
#' @param as_percentage A logical scalar indicating whether to show a percentage or an absolute value.
#' @param time_or_count A character vector indicating whether to count number of tracks played or the time they were played.
#' @param time_unit A character vector indicating the time unit to use if showing an absolute value of time played.
#' Permitted vales are "seconds", "minutes", "hours".
#'
#' @import data.table
#' @import ggplot2
#' 
#' 
#' @export
#'
#' 
#' 
#' 



plot_in_playlists_count <- function(str_his_with_playlist_wide, as_percentage = FALSE, time_or_count = "time", time_unit = "minutes") {
  . <- played <- in_any <- s_played <- NULL
  
  abbr <- c("seconds" = "s", "minutes" = "min", "hours" = "h")
  
  if (time_or_count == "time") {
    time_units <- c("seconds" = 1, "minutes" = 60, "hours" = 3600)
    time_dt  <- str_his_with_playlist_wide[, .(played = sum(s_played) / time_units[[time_unit]]) , by = in_any]
    y_label  <- "Play time"
    y_label_percent <- "Percentage of all play time"
    vis <- ggplot(time_dt) +
      theme_spotifyvis()
  }
  
  else{
    count_dt <- str_his_with_playlist_wide[, .(played = .N), by = in_any]
    vis <- ggplot(count_dt) +
      theme_spotifyvis()
    y_label <- "Tracks played"
    y_label_percent <- "Percentage of all tracks played"
  }
  
  
  if (!as_percentage) {
    vis <- vis + geom_bar(aes(x = in_any, y = played ), stat = "identity", fill = "#440154FF", colour = "white") +
            labs(y = y_label) +
            scale_y_continuous(labels = function(x) paste(x, abbr[time_unit])) 
      
  }
  
  else {
    vis <- vis + 
            geom_bar(aes(x = in_any, y = played / sum(played) ), stat = "identity", fill = "#440154FF", colour = "white") +
            scale_y_continuous(labels = function(x) paste(x*100, "%")) +
            labs(y = y_label_percent)
  }
  
  vis <- vis +
          scale_x_discrete(labels = c("Other tracks","Tracks from playlists"), name = NULL)

  vis
}

 
 