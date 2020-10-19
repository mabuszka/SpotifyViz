#' Visualize number of tracks played by period
#' 
#' Visualizes, using a bar chart, the number or percentage of songs that were played on different hours/weekdays. 
#' If split by hours, can be also faceted by weekday.
#' 
#' 
#' @param filtered A data.table containing streaming history, after 'prepare_streaming_history' 
#' was used on it.
#' @param period A character vector indicating for which periods to split the time for 
#' counting tracks played. 
#' Permitted values are: "weekday", "hour" 
#' @param as_percentage A logical scalar. If TRUE (default) bars show percentage 
#' of all tracks played for each weekday.
#' @param include_skipped A logical scalar indicating whether to include tracks that were skipped
#' @param by_weekday A logical scalar indicating whether to split the graph by weekdays 
#' if period is "hour"

#' @export
#' 
#' @import data.table
#' @import ggplot2
#' @import lubridate
#' 


plot_track_count_by_period <- function(filtered,
                                       period = "weekday",
                                       as_percentage = TRUE,
                                       include_skipped = FALSE,
                                       by_weekday = FALSE) {
  skipped <- end_time <- ..count.. <- ..PANEL.. <- NULL
  
  if (!include_skipped) {
    filtered <- filtered[skipped == FALSE,]
  }
  
  functions <- list(
    weekday = function(x) {
      lubridate::wday(x,
                      label = TRUE,
                      abbr = FALSE,
                      week_start = 1)
    },
    hour = lubridate::hour
  )
  
  viz <- ggplot(filtered, aes(x = functions[[period]](end_time))) +
    theme_spotifyviz()
  
  
  if (as_percentage) {
    if (by_weekday && period == "hour") {
      viz <- viz +
        geom_bar(aes(y = (..count..) / tapply(..count.., ..PANEL.., sum)[..PANEL..]),
                 fill = "#440154FF",
                 colour = "white") +
        facet_wrap( ~ weekday) +
        labs(x = "Hour", y = "Percentage (within each weekday) of tracks played ") +
        scale_y_continuous(
          labels = function(x)
            paste(x * 100, "%")
        )
    }
    else {
      viz <- viz +
        geom_bar(aes(y = (..count..) / sum(..count..)) , fill = "#440154FF", colour = "white") +
        xlab(capitalize(period)) +
        ylab("Percentage of all tracks played") +
        scale_y_continuous(
          labels = function(x)
            paste(x * 100, "%")
        )
    }
  }
  else{
    viz <- viz +
      geom_bar(fill = "#440154FF", colour = "white") +
      xlab(capitalize(period)) +
      ylab("Tracks played")
    
    if (by_weekday && period == "hour") {
      viz <- viz +
        facet_wrap( ~ weekday)
    }
  }
  
  
  viz
}


