#' Most skipped tracks/artist
#'
#' Shows most frequently skipped artist or track in given time period and counts how many times were they skipped
#'
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param track_or_artist A character string that specifies whether to show most frequently skipped artists or tracks. 
#' Must be either "track" or "artist"
#' @param how_many A positive integer indicating how many most skipped tracks/artist to show, defaults to 10.
#' @param for_view A logical scalar. If \code{TRUE} (defoult) returns a data.table that is easy to read for humans,
#'    with spaces in column names and capitalized first letters
#' 
#'
#'
#' @export
#'
#' @import data.table

most_skipped <- function(streaming_history,track_or_artist,how_many = 10, for_view = TRUE){
  
  N <- skipped <- NULL
  
    most_skipped_dt <- streaming_history[skipped == TRUE, .N,
                      by = eval(paste(track_or_artist,"_name", sep = ""))
                      ][order(-N)][order(-N)][1:how_many,]
    if (for_view) { setnames(most_skipped_dt, c(paste(capitalize(track_or_artist),"name"), "Times skipped")) }
    most_skipped_dt

}