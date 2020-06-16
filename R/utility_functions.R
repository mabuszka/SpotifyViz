#' Capitalize string
#' 
#' Capitalize first letter in the string.
#' 
#' @param string A string that you want to capitalize. 
#' 
capitalize <- function(string) {
  paste(toupper(substr(string, 1, 1)), 
        substr(string, 2, nchar(string)), 
        sep = "")
}


#' Change format to hours minutes seconds
#' 
#' Change format form number of seconds to number of hours, minutes and seconds.
#'
#' @param x An integer vector. Number of seconds.
#'
#' @return A character vector with format "X h Y min Z s", where Y < 60 and Z < 60
#' 
#' @export
#'
#' @examples
#' from_sec_to_hms(c(60, 134, 1257))
#' 
from_sec_to_hms <- function(x) {
  times <- sapply(x, from_sec_to_hms_single)
  times
}

#' from_sec_to_hms helper function.
#' 
#' Function to be applied to an integer, representing number of seconds,
#'  changes the format to "X h Y min Z s". Applied to each element of the vector by
#'   \code{from_sec_to_hms}.
#' @param x An integer vector. Number of seconds.
#'
from_sec_to_hms_single <- function(x) {
  hours <- floor(x / 3600)
  mins <- floor((x - 3600 * hours) / 60)
  secs <- x - mins * 60 - hours * 3600
  time <- ""
  if (hours > 0) time <- paste(time, hours, "h")
  if (mins > 0) time <- paste(time, mins, "min")
  if (secs > 0) time <- paste(time, secs, "s")
  if (time == "") time <- "0s"
  time
}