#' Filter streaming history 
#' 
#' Filer streaming history data table to only contain information about a given period of time.
#' 
#' 
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param start_date A POSIXt,Date or string that can be coerced  into Date indicating start of the period of time.
#' @param end_date A POSIXt, Date or string that can be coerced into Date indicating end of the period of time.
#' 
#' @export

streaming_history_period_filter <-function(streaming_history, start_date, end_date){
    streaming_history[as_date(start_date) <= start_time & as_date(end_date) >= end_time,]
  }

