#' Sessions length
#'
#' Infromation about length of every session. Excludes skipped tracks.
#'
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param mins Number of minutes which determine distance between listenings.
#' @return A data table containg infromation about length of every session.
#'
#' @export
#'
#' @import data.table





sessions_length = function(streaming_history, mins) {
  
  listening_number = NULL
  
  session_time = skipped = . = s_played = listening_number
  
  con_list_dt = continuous_listening(streaming_history[skipped == FALSE, ], mins)
  
  sessions = con_list_dt[, .(session_time = sum(s_played)), by = listening_number]
  
  sessions
  
}