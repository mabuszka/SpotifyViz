#' Filter streaming history 
#'
#' Filer streaming history data table to only contain information about a given period of time.
#'
#' @param streaming_history A data.table containing streaming history, made with \code{\link{complete_streaming_history}}.
#' @param start_date start_date A POSIXt,Date or string that can be coerced into Date by \code{\link{as_date}} indicating start of the period of time.
#' @param end_date end_date A POSIXt, Date or string that can be coerced into Date by \code{\link{as_date}} indicating end of the period of time.
#'
#' @return A streaming history data table containing only entries between \code{start_date} and \code{end_date}
#' @export
#'
#' 
#' @seealso \code{\link{filter_search_queries}}
#' 
#' 
filter_streaming_history <- function(streaming_history, start_date, end_date) {
  
  start_time <- end_time <- NULL
  
    streaming_history[as_date(start_date) <= start_time & as_date(end_date) >= end_time,]
  }
