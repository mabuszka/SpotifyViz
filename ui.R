ui <- fluidPage(
  theme = shinythemes::shinytheme("sandstone"),
  
  titlePanel("Spotify"),
  # inputPanel() here there will be options for importing user Spotify data in the future
  
  tabsetPanel(
    tabPanel("Charts", 
             sidebarLayout(
               sidebarPanel(width = 3,
                            selectInput("which_plots", "Which plots to show", c("Platform used", "Country", "Number of songs")),
                            dateInput('start_date_plots',
                                      label = ('Start date: yyyy-mm-dd'),
                                      value = ymd("2019-10-01")
                            ),
                            dateInput('end_date_plots',
                                      label = ('End date: yyyy-mm-dd'),
                                      value = ymd("2019-10-30")
                            ),
                            uiOutput("ui2"),
                            uiOutput("ui3"),
                            uiOutput("ui4"),
                            uiOutput("ui5")),
               
               mainPanel(width = 9, 
                         uiOutput("ui_header_1"),
                         uiOutput("ui_plot1"),
                         uiOutput("ui_header_2"),
                         uiOutput("ui_plot2"),
                         uiOutput("ui_header_3"),
                         uiOutput("ui_plot3")
                         
               ))),
    tabPanel("Tables",
             sidebarLayout(
               sidebarPanel(width = 3,
                            dateInput('start_date_tables',
                                      label = ('Start date: yyyy-mm-dd'),
                                      value = ymd("2019-10-01")),
                            dateInput('end_date_tables',
                                      label = ('End date: yyyy-mm-dd'),
                                      value = ymd("2019-10-30")),
                            radioButtons("track_or_artist_tables", label = ("Track or Artist"),
                                         choices = list("Artist" = "artist_name", "Track" = "track_name"),
                                         selected = "artist_name"),
                            radioButtons("skipped_or_played_tables", label = ("Skipped or played"),
                                         choices = list("Played" = FALSE, "Skipped" = TRUE),
                                         selected = FALSE),
                            sliderInput("how_many_tables", label = ("Show how many entries"),
                                        min = 0, max = 50, value = 10)),
               mainPanel(width = 9,dataTableOutput("Table2"))
             )),
    tabPanel("Summary",
             sidebarLayout(sidebarPanel(width = 3,
                                        radioButtons("as_percentage_summary", label = ("Show as a percentage"),
                                                     choices = list("Yes" = TRUE, "No" = FALSE), selected = FALSE ),
                                        dateInput('start_date_summary',
                                                  label = ('Start date: yyyy-mm-dd'),
                                                  value = ymd("2019-10-01")),
                                        dateInput('end_date_summary',
                                                  label = ('End date: yyyy-mm-dd'),
                                                  value = ymd("2019-10-30"))),
                           mainPanel(h4("Summary table"),tableOutput("summary_table"))
             )))
)