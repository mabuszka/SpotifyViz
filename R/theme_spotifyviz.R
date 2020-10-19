#' Spotifyviz theme for ggplot2
#' 
#' Theme used in plots.
#'
#' @param base_size Base font size, given in pts.
#' @param base_family Base font family.
#' @param base_line_size Base size for line elements
#' @param base_rect_size Base size for rect elements
#'
#' @export
#'
theme_spotifyviz <- function(base_size = 16, base_family = "",
                          base_line_size = base_size / 22,
                          base_rect_size = base_size / 22) {
  # Starts with theme_bw and then modify some parts
  theme_bw(
    base_size = base_size,
    base_family = base_family,
    base_line_size = base_line_size,
    base_rect_size = base_rect_size
  ) %+replace%
    theme(strip.background = element_rect(colour = "black", fill = "white"),
          plot.title = element_text(hjust = 0.5),
          plot.subtitle = element_text(hjust = 0.5),
          complete = TRUE
    )
}
