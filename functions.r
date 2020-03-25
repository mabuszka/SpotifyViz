library(jsonlite)
library(lubridate)
library(dplyr)
library(tidyr)
##returns dataframe with streaming history data from spotify
Streaming_History_df <- function(folder_path){
  file_paths<- list.files(folder_path,"StreamingHistory")
  read_files <- lapply(file_paths, jsonlite::fromJSON)
  bind_rows(read_files)
}

##changes names 
names_change <- function(streaming_history, column_names = c("end_time", "artist_name", "track_name", "s_played")){
  names(streaming_history) <- column_names
  streaming_history
}

##returns streaming history with end time changed to date
#mutate(streaming_history, end_time = ymd_hm(end_time))

##returns streaming_history with end_time column changed from character to date
#mutate(streaming_history, s_played = dmilliseconds((s_played)))

##returns streaming_history with added start_time column using end_time and ms_played
add_start_time <- function(streaming_history){
  
  start_time <- streaming_history[["end_time"]] - streaming_history[["s_played"]]
  streaming_history <- cbind(streaming_history, start_time)
  streaming_history
  
}

##returns streaming history with added "skipped" column [true or false]
add_skipped <- function(streaming_history){
  skipped <- (streaming_history[["s_played"]] < duration(10, "seconds"))
  streaming_history <- cbind(streaming_history, skipped)
}

##returns streaming history with added weekdays column
add_weekday <- function(streaming_history){
  weekday <- wday(streaming_history[["start_time"]], label = TRUE)
  streaming_history <- cbind(streaming_history, weekday)
}

#### creating and preparing dataframe
Streaming_History_Complete <- function(folder_path)
  Streaming_History_df(folder_path) %>%
  names_change() %>% 
  mutate(end_time = ymd_hm(end_time)) %>% 
  mutate(s_played = dmilliseconds((s_played))) %>%
  add_start_time() %>%
  add_skipped() %>%
  add_weekday()


