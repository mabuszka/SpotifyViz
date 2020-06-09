#' Change format to min sec
#' 
#' Change format form number of seconds to number of minutes and seconds
#'
#' @param x An integer. Number of seconds
#'
#' @return A character vector with format "a min b s", where a < x/60 and b < 60
#' 
#' @export
#'
#' @examples
#' from_sec_to_min_sec(60)
#' from_sec_to_min_sec(134)



from_sec_to_min_sec <- function(x) {
  mins <- floor(x/60)
  secs <- x - mins * 60
  if (mins > 0) {
    time <- paste(mins, "min ", secs, "s", sep = "")
  }
  else {
    time <- paste(secs, "s", sep = "")
  }
  
  time
}
