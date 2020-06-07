#' Prepares the streaming history with playlists data table
#'
#'
#'
#' @param playlists_dt A data table containing the names of playlists and songs on them from spotify.
#' @param streaming_history A data table containing streaming history from spotify.
#' @return A data table containing streaming history from spotify with information on which playlists song is. Data table is in long format.
#' @export
#'
#' @import data.table



str_his_with_playlists_long <- function(playlists_dt, streaming_history) {
  
  str_his_comp <- copy(streaming_history)
  
  track_name = artist_name = NULL
  setkey(str_his_comp, track_name, artist_name)
  setkey(playlists_dt, track_name, artist_name)
  
  
  str_hist = playlists_dt[str_his_comp]
  full = unique(str_hist)
  
  setnames(full, c("playlist_name","track_name","artist_name", "end_time", "s_played", "start_time", "skipped", "weekday"))
  
  full
  
}

