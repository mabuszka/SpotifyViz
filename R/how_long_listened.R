#' Measure time spent listening to spotify
#'
#' Measures time spent listening to spotify durring given time period. 
#' Either as a duration or as a percentage of the whole given period of time.
#'
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it
#' @param start_date POSIXt indicating start of the period of time to count skipped songs
#' @param end_date POSIXt indicating end of the period of time to count skipped songs
#' @param as_percentage A logical scalar. If FALSE (default) length of time (in seconds and an approximate in biggest reasonable unit)
#' that songs were listened to in given time period is returned,
#' otherwise a character vector indicating percentage of given time period will be returned.
#'
#' @export
#'
#' @import data.table
#' @import lubridate

how_long_listened <- function(streaming_history, start_date, end_date, as_percentage = FALSE){
  
  start_time = s_played = NULL
  
  suma <- streaming_history[start_time >= start_date & start_time <= end_date, sum(s_played)]
  seconds_in_period <-as.numeric(difftime(end_date,start_date, units = "secs"))
  if (as_percentage)
    return(paste(round(suma/seconds_in_period * 100, digits = 2
                       ), "%", sep = ""))
  as.duration(suma)
}
