#' Make data table with streaming history
#' 
#' Make data table with streaming history from Spotify data. 
#' 
#' @param folder_path Path to a folder which contains file or files with 
#' Streaming History in json format. File(s) must contain "StreamingHistory" in the name.
#' 
#' @return A data table with 4 columns(endTime, artistName, trackName, msPlayed) of characters 
#' containing details of Streaming History from spotify.
#' @export 
#' 
#' 
#' @import data.table
#' @import jsonlite



make_streaming_history_dt <- function(folder_path){
  files_path <- list.files(folder_path,"StreamingHistory.*\\.json$")
  if (folder_path != ".") 
    files_path <- paste(folder_path, files_path, sep = "/")
  rbindlist(lapply(files_path, jsonlite::fromJSON))
}
