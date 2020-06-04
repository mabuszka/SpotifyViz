#' Measure time spent listening to spotify
#'
#' Measures time spent listening to spotify during given time period. 
#' Either as a duration or as a percentage of the whole given period of time.
#'
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it
#' @param start_date A POSIXt,Date or string that can be coerced into Date by \code{\link{as_date}} indicating start of the period of time to count tracks
#' @param end_date A POSIXt,Date or string that can be coerced into Date by \code{\link{as_date}} indicating end of the period of time to count tracks
#' @param as_percentage A logical scalar. If FALSE (default) length of time (in seconds and an approximate in biggest reasonable unit)
#' that songs were listened to in given time period is returned,
#' otherwise a character vector indicating percentage of given time period will be returned.
#' 
#' @return An ineteger if `as_percetage` is FALSE and a character vector if `as_percentage` is TRUE
#'
#' @export
#'
#' @import data.table
#' @import lubridate

how_long_listened <- function(streaming_history, start_date, end_date, as_percentage = FALSE){
  
  start_time <- s_played <- NULL
  
  end_date <- as_date(end_date)
  start_date <- as_date(start_date)
  
  suma <- streaming_history[start_time >= start_date & start_time <= end_date, sum(s_played)]
  seconds_in_period <-as.numeric(difftime(end_date,start_date, units = "secs"))
  if (as_percentage)
    return(paste(round(suma/seconds_in_period * 100, digits = 2
                       ), "%", sep = ""))
  as.duration(suma)
}
