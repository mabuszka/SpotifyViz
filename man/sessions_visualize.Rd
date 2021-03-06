% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sessions_visualize.R
\name{sessions_visualize}
\alias{sessions_visualize}
\title{Visualize sessions length}
\usage{
sessions_visualize(streaming_history, mins, as_percentage = TRUE)
}
\arguments{
\item{streaming_history}{A data.table containing streaming history, after 
'prepare_streaming_history' was used on it.}

\item{mins}{Number of minutes which determine distance between listenings.}

\item{as_percentage}{A logical value. If TRUE (default) bars show percentage of of all sessions.}
}
\description{
Visualize sessions length divided on intervals using bar plot.
}
