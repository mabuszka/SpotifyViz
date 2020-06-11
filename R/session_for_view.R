#'Change session data table for viewing
#'
#'Changes the data table containing informations about a session (for example  form \code{\link{longest_session}}) to be in a format
#'    good for reading - spaces instead of "_" in column names, time of playing in "Xh Ymin Zs" format, and have only columns with artist name, track name, track start and time played. 
#'
#' @param session_dt A data table conatining information about listenng session. Must have columns "artist_name", "track_name", "s_played", "start_time".
#'
#' @export
#'
#'
#' 
#' 
session_for_view <- function(session_dt){
  
  . = NULL
  
  track_name <- artist_name <- s_played <- start_time <- NULL
  
  session_dt <- session_dt[, .(`Start` = lubridate::floor_date(start_time, "minutes" ),
                                               `Artist name` = artist_name,`Track name` = track_name,
                                               `Time played` = from_sec_to_hms(as.integer(s_played)))]
  session_dt
}