#' Visualize number of tracks played by hour
#' 
#' Vizualizes, using a bar chart, the number of songs that were played on each of the weekdays in given time period. 
#' Can be set to inculde songs that were counted as skipped 
#' 
#' 
#' @param filtered A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param as_percentage A logical scalar. If TRUE (dafault) bars show percentage of of all tracks played for each weekday.
#' @param period A character vector indicating for which periods to split the time for counting tracks played 
#' @param include_skipped A logical scalar indicating whether to include tracks that were skipped

#' @export
#' 
#' @import data.table
#' @import ggplot2
#' 


number_of_tracks_by_period <- function(filtered, as_percentage = TRUE, include_skipped = FALSE){
  if (!inculed_skipped){filtered <- filtered[skipped == FALSE,]}
  vis <- ggplot(filtered, aes(x = weekday))
  
  if (as_percentage){
    vis <- vis+
      geom_bar(aes(y = (..count..)/sum(..count..)))+
      xlab(toupper(period))+
      ylab("Percentage of all tracks played")
  }
  else{
    vis <- vis +
      geom_bar()+
      xlab(toupper(period))+
      ylab("Tracks played")
  }
  vis
}


