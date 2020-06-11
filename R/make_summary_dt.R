#' Summarize streaming history
#' 
#' Make table with summary stats about streaming history in given data period.
#'
#' @param streaming_history A data.table containing streaming history, after 'prepare_streaming_history' was used on it.
#' @param start_date A POSIXt,Date or string that can be coerced into Date by \code{\link{as_date}} indicating start of the period of time.
#' @param end_date A POSIXt,Date or string that can be coerced into Date by \code{\link{as_date}} indicating end of the period of time.
#' @param as_percentage A logical scalar. If \code{TRUE} (default) tracks skipped and time listened to will be a percentegae of all tracks and whole time period.
#' 
#'
#' @return A data table with summarized streaming history 
#' @export




make_summary_dt <- function(streaming_history, start_date, end_date, as_percentage = TRUE) {
  . = track_name = artist_name = NULL
  
  filtered <- filter_streaming_history(streaming_history, start_date, end_date)
  hm_tracks <- filtered[,.N]
  hm_different_tracks <- uniqueN(filtered[,.(track_name)])
  hm_skipped <- how_many_skipped(streaming_history, start_date, end_date, as_percentage)
  hm_different_artists <- uniqueN(filtered[,.(artist_name)])
  hl_listened <- how_long_listened(streaming_history, start_date, end_date, as_percentage)
  
  summary <- data.table(`Tracks played` = hm_tracks,
                        `Different tracks` = hm_different_tracks,
                        `Different artists` = hm_different_artists,
                        `Skipped tracks` = hm_skipped,
                        `How long listened` = hl_listened)
  
  summary
                                 
  
}

