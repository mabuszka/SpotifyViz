#' Filter spotify searh queries
#' 
#' Filter spotify search queries data table to contain only entries from specified time period
#'
#' @param search_queries A data table with search queries, made with \code{\link{make_search_queries_dt}}
#' @param start_date A POSIXt,Date or string that can be coerced into Date by \code{\link{ymd}} indicating start of the period of time.
#' @param end_date A POSIXt, Date or string that can be coerced into Date by \code{\link{ymd}} indicating end of the period of time.
#' 
#' @return A search queries data table containing only entries between \code{start_date} and \code{end_date}
#'
#' @export
#'
#' @seealso \code{\link{filter_streaming_history}}
#' 
#' 
#' 

filter_search_queries <- function(search_queries, start_date, end_date) {
  search_queries[date <= Date(end_date)  & date >= start_date,]
  
}
  