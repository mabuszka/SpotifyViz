#' Change format to hours minutes seconds
#' 
#' Change format form number of seconds to number of hours, minutes and seconds
#'
#' @param x An integer vector. Number of seconds
#'
#' @return A character vector with format "X h Y min Z s", where Y < 60 and Z < 60
#' 
#' @export
#'
#' @examples
#' from_sec_to_min_sec(60)
#' from_sec_to_min_sec(134)



from_sec_to_hms <- function(x) {
  
  
  hours <- floor(x / 3600)
  mins <- floor((x - 3600 * hours)/60)
  secs <- x - mins * 60 - hours * 3600

  time <- ""

  
  if ( hours > 0) time <- paste(time, hours, "h")
  if (mins > 0) time <- paste(time, mins, "min" )
  if (secs > 0) time <- paste(time, secs, "s")
  if (time == "") time <- "0s"

  
  time
}
