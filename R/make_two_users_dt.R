#' Make data table to use in \code{plot_day_comparison}
#' 
#' Make data table with data about play time of two users on given day, 
#' for further use in \code{\link{plot_day_comparison}}
#'
#' @param user1_data A data.table containing streaming history from first user, 
#' made with \code{\link{complete_streaming_history}}.
#' 
#' @param user2_data A data.table containing streaming history from second user, 
#' made with \code{\link{complete_streaming_history}}.
#' 
#' @param day end_date A POSIXt, Date or string that can be coerced into 
#' Date by \code{\link{as_date}} indicating the day for witch to create the data table.
#'
#' @export

make_two_users_dt <- function(user1_data, user2_data, day) {
  . <- end_time <- start_time <- NULL
  
  user1_data <- user1_data[as_date(day) <= start_time
                           &
                             as_date(day) + duration(86399, "second") >= end_time,
                           .(start_time, end_time)][, `:=`(
                             start_time = floor_date(start_time, "minutes"),
                             end_time = ceiling_date(end_time, "minutes"),
                             user = 1
                           )]
  user2_data <- user2_data[as_date(day) <= start_time
                           &
                             as_date(day) + duration(86399, "second") >= end_time,
                           .(start_time, end_time)][, `:=`(
                             start_time = floor_date(start_time, "minutes"),
                             end_time = ceiling_date(end_time, "minutes"),
                             user = 2
                           )]
  rbindlist(list(user1_data, user2_data))
}





