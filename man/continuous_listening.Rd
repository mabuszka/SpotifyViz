% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/continuous_listening.R
\name{continuous_listening}
\alias{continuous_listening}
\title{Divides streaming history into a groups of song which where listened one after another.}
\usage{
continuous_listening(streaming_history, mins)
}
\arguments{
\item{streaming_history}{A data table containing streaming history from spotify.}

\item{mins}{Number of minutes which determine distance between listening sessions.}
}
\value{
A data table containing streaming history with additional column about listening number.
}
\description{
The listening number indicates the session  number.
If distance between beginning of a song and end of a previous one is less than 
\code{mins} then listening number stays.
Otherwise increases. Counting begins from the oldest song in streaming history.
}
