#' Capitalize string
#' 
#' Capitelize first letter in the string
#' 
#' @param string A string that you want to capitalize. 
#' 
#' @export 



capitalize <- function(string){
  paste(toupper(substr(string, 1,1)), substr(string, 2, nchar(string)), sep = "")
}
