
#' Compare two users day play time
#' 
#' Compare on which times two users were listening to spotify during a specified day.
#'
#' @param two_users_dt A data table with two users play times on a specific day, made with \code{\link{make_two_users_dt}}
#' @param user1_name A character vector, name to display for the first user.
#' @param user2_name A character vector, name to display for the second user.
#'
#' @export
#'
#'
plot_day_comparison <- function(two_users_dt, user1_name = "User 1", user2_name = "User 2") {
  
  end_time <- start_time <- user <- NULL
  
  
  breaks <- pretty_dates(two_users_dt$end_time, 10)

  vis <-  ggplot(two_users_dt) +
    geom_rect(aes(xmin = start_time, xmax = end_time,
                  ymin = user - 0.5, ymax = user + 0.5 , fill = as.factor(user) )) +
    scale_x_datetime(breaks = breaks, date_labels = "%H:%M", guide = guide_axis(n.dodge = 2) ) +
    scale_y_continuous(limits = c(-0.1,3), breaks = c(1,2), minor_breaks = NULL, labels = c(user1_name, user2_name)) +
    labs(x = "Hour") +
    scale_fill_manual(values = c("#440154FF" ,"#7AD151FF")) +
    theme_spotifyvis() +
    theme(legend.position = "None")
  
  vis
}


