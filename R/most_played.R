#' Most played tracks/artist
#'
#' Shows most frequently played artist or track and counts how many times were they played.
#'
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param track_or_artist A character string that specifies whether to show most frequently played artists or tracks. 
#' Must be either "track" or "artist"
#' @param how_many A positive integer indicating how many most frequent tracks/artist to show, defaults to 10.
#' @param show_skipped A logic scalar indicating whether to include tracks that were skipped in counting.
#'
#'
#' @export
#'
#' @import data.table


most_played <- function(streaming_history, track_or_artist,
                        how_many = 10, show_skipped = TRUE){
  
  N <- skipped <- NULL
  
  if (show_skipped) {
    most_played_dt <- streaming_history[, .N,
                      by = eval(paste(track_or_artist,"_name", sep = ""))
                      ][order(-N)][1:how_many,]
  }
  else {
    most_played_dt <- streaming_history[skipped == FALSE, .N,
                      by = eval(paste(track_or_artist,"_name", sep = ""))
                      ][order(-N)][order(-N)][1:how_many,]
  }
  
  setnames(most_played_dt, c(paste(capitalize(track_or_artist),"name"), "Times played"))
  
  most_played_dt
}
