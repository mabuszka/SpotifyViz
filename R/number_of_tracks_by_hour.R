#' Visualize number of tracks played by hour
#' 
#' Vizualizes, using a bar chart, the number of tracks played on different hours. 
#' Either collectively or separetely for each day of the week. Can be set to inculde songs that were counted as skipped.
#' 
#' 
#' @param filtered A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param start_date A POSIXt indicating start of the period of time.
#' @param end_date A POSIXt indicating end of the period of time.
#' @param by_weekday A logic scalar indicating whether to show data for each weekday separately on the graph.
#' @param show_skipped A logic scalar indicating whether to include tracks that were skipped in counting.
#' 
#' @export
#' 
#' @import data.table
#' @import ggplot2
#' @importFrom lubridate hour
#' 



number_of_tracks_by_hour <- function(filtered, start_date, end_date, 
                                     by_weekday = FALSE, show_skipped = FALSE){
  if (!show_skipped){
    filtered <- filtered[skipped == FALSE, ]
  }
  vis <- ggplot(filtered, aes(x = hour(start_time)))+
    geom_bar()+
    scale_x_discrete(limits = 0:24)+
    xlab("Hour")+
    ylab("Tracks played")
  
  if (by_weekday){
    vis <- vis+
      facet_wrap(~weekday)
  }
  vis
}



