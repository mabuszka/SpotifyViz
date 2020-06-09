#' Visualize sessions length
#'
#' Visualize sessions length divided on intervals using bar plot.
#'
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param mins Number of minutes which determine distance between listenings.
#' @param as_percentage A logical value. If TRUE (default) bars show percentage of of all sessions.
#' @export
#'
#' @import data.table
#' @import ggplot2
#' 


sessions_visualize = function(streaming_history, mins, as_percentage = TRUE) {
  
  frac = NULL
  
  sessions_groupped = sessions_intervals(streaming_history, mins)
  
  
  if (as_percentage) {
    vis = ggplot(sessions_groupped, aes(x = interval, y = frac / 100)) +
      geom_bar(stat = "identity", position = "dodge", fill = "#440154FF", colour = "white") +
      geom_text(aes(label = frac), position = position_dodge(width = 0.9), vjust = -0.5) +
      scale_y_continuous(labels = function(x) paste(x*100, "%")) +
      labs(x = "Session length", y = "Percentage of all tracks played") +
      theme_spotifyvis()
  } else {
    vis = ggplot(sessions_groupped, aes(x = interval, y = sum)) +
      geom_bar( stat = "identity", position = "dodge", fill = "#440154FF", colour = "white") +
      geom_text(aes(label = sum), position = position_dodge(width = 0.9), vjust = -0.5) +
      labs(x = "Session length", y = "Sessions") + 
      theme_spotifyvis()
  }
  
  vis
}
