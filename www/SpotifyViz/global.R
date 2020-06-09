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
