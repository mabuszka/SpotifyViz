#' Measure the number of continuous listening sessions.
#' 
#' Listening number informs about number of songs listened in a row.
#' If distance between beginning of a song and end of a previous one is less than \code{mins} then listening number stays.
#' Otherwise increases. Counting begins from the newest song in streaming history.
#'
#'
#' @param streaming_history A data table containing streaming history from spotify.
#' @param mins Number of minutes which determine distance between listening sessions.
#' @return A data table containing streaming history with additional column about listening number.
#' @export
#'
#' @import data.table



continuous_listening = function(streaming_history, mins) {
  
  end_time <- start_time <- NULL
  
  dt = copy(streaming_history)
  dt = dt[order(-start_time, -end_time)]
  
  
  distances = difftime(dt[["start_time"]][1:(nrow(dt) - 1)], dt[["end_time"]][2:nrow(dt)], units = "mins") <  mins
  distances = c(distances, T)
  
  #dt[, is_continuous := distances]
  
  
  listening_number = rep(0, nrow(dt))
  k = 1
  
  for( i in 1:nrow(dt)) {
    if (distances[i]) {
      listening_number[i] = k
    } else {
      listening_number[i] = k
      k = k + 1
    }
  }
  
  dt[, listening_number := listening_number]
  
  dt
}
