library(shiny)
library(data.table)
library(lubridate)
library(shinydashboard)
library(DT)
library(ggplot2)
library(spotifyviz)


playlist_shiny = function(playlist_raw) {
  song_names_function <- function(x) {
    return(df[[3]][[x]][[1]][[1]])
  }
  artist_names_function <- function(x) {
    return(df[[3]][[x]][[1]][[2]])
  }
  df <- jsonlite::fromJSON(playlist_raw)
  df <- as.data.table(df)
  playlists = lapply(1:nrow(df), function(x) {
    data.table(playlist_name = df[x, 1], track_name = song_names_function(x), 
               artist_name = artist_names_function(x))
  })
  playlists_dt = rbindlist(playlists)
  playlists_dt
}

##Functions for min and max date calculation for defoult value in date input 
## for serach queries use end_and_start = FALSE

min_date <- function(data, end_and_start = TRUE){
  if (end_and_start) {
  min_date <- as_date(data[, min(start_time)])
  }
  else {
    min_date <- as_date(data[, min(date)])
  }
  min_date
}

max_date <- function(data, end_and_start = TRUE){
  if (end_and_start) {
    max_date <- as_date(data[, max(end_time)])
  }
  else {
    max_date <- as_date(data[, max(date)])
  }
}


  



