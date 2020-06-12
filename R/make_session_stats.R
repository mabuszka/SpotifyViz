#' Make session stats table
#' 
#' Make a table containing stats about session - play time , number of tracks played, start and end.
#'
#' @param session_dt A data table containing information about listening session. 
#' Must have columns "artist_name", "track_name", "s_played", "start_time".
#'
#' @export
#'
#' 

make_session_stats <- function(session_dt) {
  start_time <- end_time <- . <- s_played <- NULL
  table <- data.table(
    `Session start` = c(substr(
      as.character(session_dt[, lubridate::floor_date(min(start_time), "minutes")]),
      start = 1,
      stop = 16
    )),
    `Session end`  = c(substr(
      as.character(session_dt[, lubridate::floor_date(max(end_time), "minutes")]),
      start = 1,
      stop = 16
    )),
    `Tracks played` = c(session_dt[, .N]),
    `Play time`  = c(session_dt[, .(from_sec_to_hms(as.integer(sum(s_played))))])
  )
  table
}


