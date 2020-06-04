#' Make and prepare the streaming history data table
#'
#'  Make data table with make_streaming_history_dt and do prepare_streaming_history with, that
#'  data table
#' 
#'
#' @param folder_path Path to a folder which contains file or files with 
#' Streaming History in json format. File(s) must contain "StreamingHistory" in the name.
#' 
#' @return A data table containg streaming history from spotify suited for being used in rest of the functions from the package.
#'
#' @export
#











complete_streaming_history <- function(folder_path)
 prepare_streaming_history(make_streaming_history_dt(folder_path))
  
  
