#' Make session stats table
#' 
#' Make a table containing stats about session - play time , number of tracks played, start and end.
#'
#' @param session_dt A data table conatining information about listenng session. Must have columns "artist_name", "track_name", "s_played", "start_time".
#'
#' @export
#'
#' 

make_session_stats <- function(session_dt) {
  
  stats <- c("Session start", "Session end", "Tracks played", "Play time")
  values <- c(substr(as.character(session_dt[,lubridate::floor_date(min(start_time), "minutes")]), start = 1, stop = 16),
              substr(as.character(session_dt[,lubridate::floor_date(max(end_time), "minutes")]), start = 1, stop = 16),
              as.character(session_dt[,.N]),
              as.character(session_dt[, .(from_sec_to_hms(as.integer(sum(s_played))))]))
  
  table <- data.table(Stat = stats, Value = values )
   table
 }



