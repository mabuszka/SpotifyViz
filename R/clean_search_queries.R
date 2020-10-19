#' Clean search queries
#' 
#'
#' A dataset with search queries,result of using make_search_queries_dt() on JSON file, 
#' selected from Wiktor's data from spotify, prepared for testing and vignettes.
#
#' @format A data table with 10 rows and 3 variables:
#' \describe{
#'   \item{date}{Date, the day the search was performed }
#'   \item{platform}{Platform on which the search was performed}
#'   \item{country}{Country in which the search was performed}
#' }
"clean_search_queries"