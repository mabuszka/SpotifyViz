#' Measure the number of continuous listening sessions.
#' 
#' Listening number informs about number of songs listened in a row.
#' If distance between beginning of a song and end of a previous one is less than 
#' \code{mins} then listening number stays.
#' Otherwise increases. Counting begins from the oldest song in streaming history.
#'
#' @param streaming_history A data table containing streaming history from spotify.
#' @param mins Number of minutes which determine distance between listening sessions.
#' @return A data table containing streaming history with additional column about listening number.
#' @export
#'
#' @import data.table



continuous_listening <- function(streaming_history, mins) {
  skipped <- end_time <- artist_name <- track_name <- s_played <- start_time <- NULL
  weekday <- end_of_prev <- diff <- . <- NULL
  streaming_history <- streaming_history[order(start_time, end_time)]
  streaming_history <- streaming_history[, .(end_time, artist_name, track_name, s_played,
                                             start_time, skipped, weekday,
                                             end_of_prev = data.table::shift(end_time,
                                                                             fill = min(end_time)))]
  
  streaming_history <- streaming_history[, .(end_time, artist_name, track_name, s_played,
                                             start_time, skipped, weekday,
                                             diff = as.numeric(start_time - end_of_prev))]
  
  
  streaming_history <- streaming_history[, .(end_time, artist_name, track_name, s_played, 
                                             start_time, skipped, weekday,
                                             listening_number = (cumsum(diff > mins * 60)) + 1)]
  
  streaming_history
}
