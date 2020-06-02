#' Visualize number of tracks played by hour
#' 
#' Vizualizes, using a bar chart, the number of songs that were played on each of the weekdays in given time period. 
#' Can be set to inculde songs that were counted as skipped 
#' 
#' 
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param start_date A POSIXt indicating start of the period of time.
#' @param end_date A POSIXt indicating end of the period of time.
#' @param show_skipped A logical scalar indicating whether to include tracks that were skipped in counting.
#' @param as_percentage A logical scalar. If TRUE (dafault) bars show percentage of of all tracks played for each weekday.
#' 
#' @export
#' 
#' @import data.table
#' @import ggplot2
#' 


number_of_tracks_by_weekday <- function(streaming_history, start_date, end_date, show_skipped = FALSE, as_percentage = TRUE){
  
  
  ..count..
  start_time = end_time = weekday = skipped = ..count.. = NULL
  
  if (show_skipped){
      filtered <- streaming_history[start_date <= start_time & end_date >= end_time,]
    }
    else{
      filtered <- streaming_history[start_date <= start_time & end_date >= end_time & skipped == FALSE, ]
  }
  vis <- ggplot(filtered, aes(x = weekday))
  
  if (as_percentage){
    vis <- vis+
      geom_bar(aes(y = (..count..)/sum(..count..)))+
      xlab("Weekday")+
      ylab("Percentage of all tracks played")
  }
  else{
    vis <- vis +
      geom_bar()+
      xlab("Weekday")+
      ylab("Tracks played")
  }
  vis
}
