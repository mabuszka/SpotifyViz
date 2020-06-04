#' Prepares the streaming history with playlists data table
#'
#'
#'
#' @param playlists_dt A data table containing the names of playlists and songs on them from spotify.
#' @param streaming_history A data table containg streaming history from spotify.
#' @return A data table containg streaming history from spotify with information on which playlists song is. Data table is in wide format.
#' @export
#'
#' @import data.table



str_his_with_playlists_wide <- function(playlists_dt, streaming_history) {
  
  str_his_comp <- copy(streaming_history)
  
  track_name = artist_name = NULL
  setkey(str_his_comp, track_name, artist_name)
  setkey(playlists_dt, track_name, artist_name)
  
  
  str_hist = playlists_dt[str_his_comp]
  full = unique(str_hist)
  
  wide = dcast(full, end_time + artist_name + track_name + s_played + start_time + skipped + weekday ~ playlist_name.playlists.name,
               value.var = "playlist_name.playlists.name")
  
  wide[is.na(wide)] = 0
  wide[, ("NA"):= NULL]
  wide[, 8: ncol(wide) := lapply(.SD, function(x) {!(x == 0)}), .SDcols = 8 : ncol(wide)]
  
  wide
}
