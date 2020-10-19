#' Visualize search queries
#'
#' @param search_queries A data table containing spotify search queries, made with \code{\link{make_search_queries_dt}}   
#' @param additional A character vector, additional information to be visualized, can be either "country" or "platform". 
#'
#' @export
plot_searches <- function(search_queries, additional = "country") {
  
  . <- N <- country <- platform <- NULL
  
  count <- search_queries[, .N, by = .(date, country, platform)]
  max <- count[, max(N)]
  
  viz <- ggplot(count) +
    geom_point(aes(
      y = N,
      x = date,
      colour = eval(as.name(additional))
    ),
    size = 3,
    shape = "circle") +
    theme_spotifyviz() +
    scale_x_date(date_minor_breaks = "1 day") +
    scale_y_continuous(breaks = seq(0, max + 1 , by = 2),
                       minor_breaks = 0:max) +
    theme(legend.position = "bottom") +
    labs(x = "Date", y = "Searches") +
    scale_color_manual(name = paste(capitalize(additional), ":"),
                       values = c("#440154FF", "#7AD151FF"))
  
  viz
  
}
