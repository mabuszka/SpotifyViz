#' Prepares the streaming history with playlists data table
#'
#'
#'
#' @param playlists_dt A data table containing the names of playlists and songs on them from spotify. 
#' @param streaming_history A raw data table containing streaming history from spotify.
#' @return A data table containg streaming history from spotify with information whether song is on user playlist. If it is not, the relevant information will appear.
#' @export
#'
#' @import data.table
#' @import tidyr



str_his_with_playlists <- function(playlists_dt, streaming_history) {
  
  str_his_comp <- prepare_streaming_history(streaming_history)
  
  track_name = artist_name = NULL
  setkey(str_his_comp, track_name, artist_name)
  setkey(playlists_dt, track_name, artist_name)
  
  
  str_hist = playlists_dt[str_his_comp]
  
  str_hist = replace_na(str_hist, list(playlist_name = "It is not in any playlist"))

  unique(str_hist)
}
