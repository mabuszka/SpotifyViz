#' Prepares the streaming history data table
#'
#' Prepares the data table containig streaming history for futher oprations.
#'  Changes the names of the base columns to: end_time, artist_name, track_name, s_played. Changes the end_time 
#'  column from charcter to POSTIX date, s_played to a duration in seconds. Adds new columns: 
#'  start_time - estimated start time calculated from end_time and s_played, skipped - TRUE if the track was 
#'  played for less than 10s, weekday - weekdays derived from start_time date.  \cr
#' 
#'
#' @param streaming_history A raw data table containing streaming history from spotify.
#' 
#' @return A data table containg streaming history from spotify suited for being used in rest of the functions from the package.
#'
#' @export
#' 
#' @import data.table
#' @importFrom lubridate dmilliseconds wday ymd_hm duration 
#' 

prepare_streaming_history <- function(streaming_history){
  streaming_history <- copy(streaming_history)
  setnames(streaming_history,c("end_time", "artist_name", "track_name", "s_played"))
  streaming_history[,`:=`(end_time = ymd_hm(end_time), s_played = dmilliseconds((s_played)))
                    ][,`:=`(start_time = end_time - s_played,
                            skipped = (s_played < duration(10, "seconds")))
                      ][,weekday := lubridate::wday(start_time, label = TRUE)]
}

