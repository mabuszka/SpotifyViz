#' Sessions length by intervals.
#'
#'
#' Shows table with sessions divided into listening intervals.
#' Sessions length are divided into categories: <10min, 10-30min, 0.5-1h, 1-2h, 2-4h, 4-6h, 6h+,
#'
#'
#' @param streaming_history A data.table containing streaming history, after 
#' 'prepare_streaming_history' was used on it.
#' @param mins Number of minutes which determine distance between listenings.
#' @export
#'
#' @import data.table



sessions_intervals <- function(streaming_history, mins) {
  sum <- frac <- . <- NULL
  
  sessions <- sessions_length(streaming_history, mins)
  
  sessions$interval <- cut(
    sessions$session_time,
    breaks = c(1, 10 * 60, 30 * 60,  60 * 60, 2 * 60 * 60, 4 * 60 * 60, 6 * 60 * 60,
               (max(
                 sessions$session_time
               ) + 1)),
    labels = c("<10min", "10-30min", "0.5-1h", "1-2h", "2-4h", "4-6h", "6h+")
  )
  
  sessions_groupped <- sessions[, .(sum = .N), by = interval][, frac := 100 * round(sum / sum(sum), 3)]
  
  sessions_groupped
}