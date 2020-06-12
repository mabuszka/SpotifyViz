#' Common artists / artists and tracks for two users.
#'
#' Shows the same artists/ artists and tracks from history of two different users.
#'
#' @param streaming_history_1 A data.table containing streaming history, 
#' after 'prepare_streaming_history' was used on it from user 1.
#' @param streaming_history_2 A data.table containing streaming history, 
#' after 'prepare_streaming_history' was used on it from user 2.
#' @param by_track Logical value, whether comparison should include tracks. Default is FALSE.
#'
#' @export
#'
#' @import data.table


compare_history <- function(streaming_history_1, streaming_history_2, by_track = F) {
  
  skipped <- . <- track_name <- artist_name <- NULL
  str_h_1 <- streaming_history_1[, .(artist_name, track_name, skipped)]
  str_h_2 <- streaming_history_2[, .(artist_name, track_name, skipped)]
  
  if (by_track) {
    str_h_1 <- unique(str_h_1[skipped == F, .(track_name, artist_name)])
    str_h_2 <- unique(str_h_2[skipped == F, .(track_name, artist_name)])
    dt <- str_h_1[str_h_2, nomatch = 0, on = c("artist_name", "track_name")]
  } 
  
  else {
    str_h_1 <- unique(str_h_1[skipped == F, .(artist_name)])
    str_h_2 <- unique(str_h_2[skipped == F, .(artist_name)])
    dt <- str_h_1[str_h_2, nomatch = 0, on = c("artist_name")]
  }
  
  dt
}
