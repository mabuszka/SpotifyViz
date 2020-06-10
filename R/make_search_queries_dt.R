#' Make data table with search queries
#' 
#' Make data table with search queries from Spotify data. 
#' 
#' @param folder_path Path to a folder which contains file with 
#' search queries in json format. File must contain 'SearchQueries" in the name.
#' 
#' @return A data table with 3 columns(date, platform, country) 
#' containing details of Search Queries from spotify.
#' @export 
#' 
#' 
#' @import data.table
#' @import jsonlite
#' @importFrom lubridate ymd

make_search_queries_dt <- function(folder_path){
  
  platform <- country <- NULL
  
  files_path <- list.files(folder_path,"SearchQueries")
  if (folder_path != ".") {
    file_path <- paste(folder_path, files_path, sep = "/")
  }
  read_files <- data.table(jsonlite::fromJSON(file_path))
  read_files[,list(date=ymd(date),platform,country)]
}