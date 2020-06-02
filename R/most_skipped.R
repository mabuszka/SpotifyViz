#' Most skipped tracks/artist
#'
#' Shows most frequently skipped artist or track in given time period and counts how many times were they skipped
#'
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param start_date A POSIXt indicating start of the period of time.
#' @param end_date A POSIXt indicating end of the period of time.
#' @param track_or_artist A character string that specifies wheter to show most frequently skipped artists or tracks. 
#' Must be either "track" or "artist"
#' @param how_many A positive integer indicating how many most skipped tracks/artist to show, defoults to 10.
#'
#'
#' @export
#'
#' @import data.table

most_skipped <- function(streaming_history, start_date, end_date,track_or_artist,
                        how_many = 10){
    streaming_history[start_date <= start_time & end_date >= end_time & skipped == TRUE, .N,
                      by = eval(paste(track_or_artist,"_name", sep = ""))
                      ][order(-N)][order(-N)][1:how_many,]

}