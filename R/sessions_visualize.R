#' Visualize sessions length
#'
#' Infromation about length of every session. Excludes skipped tracks.
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
  
  sessions = sessions_length(streaming_history, mins)
  
  sessions$interval = ifelse(
    sessions$session_time < 10 * 60, "<10min", ifelse(
      sessions$session_time < 30 * 60, "10-30 min", ifelse(
        sessions$session_time < 60 * 60, "0.5-1h", ifelse(
          sessions$session_time < 2 * 60 * 60, "1-2h", ifelse(
            sessions$session_time < 4 * 60 * 60, "2-4h", ifelse(
              sessions$session_time < 6 * 60 * 60, "4-6h", "6h+"
            )
          )
        )
      )
    )
  )
  
  sessions_groupped = sessions[, .(sum = .N), by = interval][, frac := 100 * round(sum / sum(sum), 3)]
  
  
  if(as_percentage) {
    vis = ggplot(sessions_groupped, aes(x = interval, y = frac / 100)) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label = frac), position = position_dodge(width = 0.9), vjust = -0.5)+
      scale_y_continuous(labels = function(x) paste(x*100, "%"))+
      labs(x = "Session length", y = "Percentage of all tracks played")
  } else {
    vis = ggplot(sessions_groupped, aes(x = interval, y = sum)) +
      geom_bar( stat = "identity", position = "dodge")+
      geom_text(aes(label = sum), position = position_dodge(width = 0.9), vjust = -0.5)+
      labs(x = "Session length", y = "Sessions")
  }
  
  vis
}
