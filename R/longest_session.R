#' Longest session info
#'
#' Shows all information about longest session i.e. tracks, artists etc. Excludes skipped tracks.
#'
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param mins Number of minutes which determine distance between listenings.
#' @param for_view A logical scalar. If \code{TRUE} (defoult) returns a data.table that is easy to read for humans, with spaces in column names and time in minutes : seconds format
#'    otherwise returns a data.table data table that has the same columns (names, types) as streaming history with added column with the id number of the session.
#' 
#' 
#' @return A data table containg infromation about longest session.
#'
#' @export
#'
#' @import data.table





longest_session = function(streaming_history, mins, for_view = TRUE) {
  
  end_time = . = listening_number = s_played = session_time = skipped  = track_name  = artist_name = start_time =  NULL
  
  str_his = copy(streaming_history)
  
  con_list_dt = continuous_listening(str_his[skipped == FALSE, ], mins)
  
  sessions = con_list_dt[, .(session_time = sum(s_played)), by = listening_number]
  
  longest_session_number = sessions[session_time == max(session_time), ][[1, 1]]
  
  longest_session_dt = con_list_dt[listening_number == longest_session_number, ]
  
  if (for_view) {
    longest_session_dt <- longest_session_dt[, .(`Start` = lubridate::floor_date(start_time, "minutes" ),
                        `Artist name` = artist_name,`Track name` = track_name,
                        `Time played` = from_sec_to_min_sec(as.integer(s_played)))]
    }
      longest_session_dt
  
}
