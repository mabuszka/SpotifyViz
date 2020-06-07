#' Longest session info
#'
#' Shows all information about longest session i.e. tracks, artists etc. Excludes skipped tracks.
#'
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param mins Number of minutes which determine distance between listenings.
#' @return A data table containg infromation about longest session.
#'
#' @export
#'
#' @import data.table





longest_session = function(streaming_history, mins) {
  
  str_his = copy(streaming_history)
  
  con_list_dt = continuous_listening(str_his[skipped == FALSE, ], mins)
  
  sessions = con_list_dt[, .(session_time = sum(s_played)), by = listening_number]
  
  longest_session_number = sessions[session_time == max(session_time), ][[1, 1]]
  
  longest_session_dt = con_list_dt[listening_number == longest_session_number]
  
  longest_session_dt
  
}