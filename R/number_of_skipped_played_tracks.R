#' vizualize number of tracks that were played or skipped 
#' 
#' vizualizes, using a bar chart, how many tracks were played or how many were skipped, each period (day, week, month, year).
#' 
#' 
#' 
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param only_skipped A logical scalar indicating whether to show all played tracks or only those that were skipped.
#' @param by A character vector indicating for which periods to split the time for counting tracks played/skipped. 
#' Permitted values are: "year", "month", "week", "day".
#' 
#' @export
#' 
#' @import data.table
#' @import viridisLite


number_of_skipped_played_tracks <- function(streaming_history, only_skipped = FALSE, by = "year"){
  if (only_skipped){
    streaming_history <- streaming_history[(skipped),]
    y_lab = "Number of tracks skipped"
  }
  else{
    streaming_history[, .(skipped = factor(skipped, levels = c(TRUE, FALSE)),
                          end_time = end_time)]
    y_lab = "Number of tracks played"
  }
  vis <- ggplot(streaming_history, aes(x = as.Date(floor_date(end_time, by))))+
    labs(y = y_lab, x = "Date")+
    theme(legend.position = "bottom")
  
  
  if (only_skipped){
    vis <- vis + geom_bar(aes(y = ..count..))
    }
  else{
    vis <- vis + geom_bar(aes(y = ..count..,fill = skipped))+
      scale_fill_manual(name = "Was the track skipped", values = viridis(2, end = 0.8), labels = c("Yes", "No"))
    }
  
    vis <- switch(by,
      "year"  = vis + scale_x_date(date_labels = "%Y", date_breaks = ("1 year")),
      "month" = vis + scale_x_date(date_labels = "%b %Y", date_breaks = "2 months"),
      "week"  = vis + scale_x_date(date_labels = "%b %Y", date_minor_breaks = "1 month", date_breaks = "2 months"),
      "day"   = vis + scale_x_date(date_labels = "%d.%m.%y",date_minor_breaks = "1 month", date_breaks = "2 months"))
      
  vis
} 




