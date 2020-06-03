#' Preapare playlists data table
#'
#'
#'
#' @param folder_path Path to a folder which contains file with Playlists in json format. File must contain "Playlist" in the name.
#'
#' @return A data table containing the names of playlists and songs on them from spotify.
#' @export
#'
#' @import data.table
#' @import jsonlite

prepare_playlists <- function(folder_path) {
  song_names_function <- function(x) {
    return(df[[3]][[x]][[1]][[1]])
  }
  artist_names_function <- function(x) {
    return(df[[3]][[x]][[1]][[2]])
  }
  name = items = NULL
  
  files_path <- list.files(folder_path, "Playlist")
  if (folder_path != ".")
    files_path <- paste(folder_path, files_path, sep = "/")
  df <- jsonlite::fromJSON(files_path)
  df <- as.data.table(df)
  
  
  playlists = lapply(1 : nrow(df), function(x) {
    data.table(
      playlist_name = df[x, 1],
      track_name = song_names_function(x),
      artist_name = artist_names_function(x)
    )
  })
  
  playlists_dt = rbindlist(playlists)
  
  playlists_dt
}


