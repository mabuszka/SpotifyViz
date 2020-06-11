

sidebar = dashboardSidebar(
    width = 320,
    sidebarMenu(
        menuItem("Input user data", tabName = "input_user_data", icon = icon("fas fa-upload")),
        menuItem("Tables", tabName = "tables", icon = icon("fas fa-table")),
        menuItem("Plots", tabName = "plots", icon = icon("fas fa-chart-bar"),
                 menuSubItem(
                     "Search queries", "search_que", icon = icon("fas fa-search")
                 ),
                 menuSubItem(
                     "Streaming history", "str_hist", icon = icon('history')
                 )
        ),
        menuItem("Compare with another user", tabName = "compare", icon = icon("fas fa-user-friends"),
                 menuSubItem(
                     "Other user data input", "oth_us_data_in", icon = icon("fas fa-upload")
                 ),
                 menuSubItem("Plots", "plot_compare", icon = icon("fas fa-chart-bar")
                             
                 ),
                 menuSubItem("Tables", "tables_compare", icon = icon("fas fa-table"))
                 
                 
        ),
        menuItem("About", tabName = "about", icon = icon("fas fa-info"))
    )
)
## color options 
tabs_color <- '.nav-tabs-custom .nav-tabs li.active {
    border-top-color: #00a65a;
}
.nav-tabs-custom>.nav-tabs {
                            background-color: #00a65a;
                            }
.nav-tabs-custom > .nav-tabs > li.header {
                            color: #FFFFFF;
}
.nav-tabs-custom>.nav-tabs>li>a {
    color: #FFFFFF;
}
                            
.nav-tabs-custom>.nav-tabs>li.active:hover>a, .nav-tabs-custom>.nav-tabs>li.active>a {
    background-color: #FFFFFF;
    color: #333;
}'


body = dashboardBody(
    tags$head( 
        tags$style(HTML(".main-sidebar { font-size: 18px; }")) #change the font size to 20
    ),
    tabItems(
        tabItem(tabName = "input_user_data",
                sidebarLayout(
                    
                    column(3,
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("streaming_history", "Choose JSON file(s) with Streaming History",
                                         multiple = TRUE,
                                         accept = c(".JSON")),
                               actionButton("submit_streaming_history", label = "Submit" )
                           ),
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("search_queries", "Choose JSON file with SearchQueries",
                                         multiple = FALSE,
                                         accept = c(".JSON")),
                               actionButton("submit_search_queries", label = "Submit" )
                           ),
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("playlist", "Choose JSON file with Playlist",
                                         multiple = FALSE,
                                         accept = c(".JSON")),
                               actionButton("submit_playlist", label = "Submit" )
                           )
                           
                    ),
                    
                    
                    column(9,
                           
                           tabBox(
                               width = NULL,
                               title = "See the data you've uploaded",
                               id = "tabset1",
                               height = "450px",
                               side = "right",
                               tabPanel(
                                   title = "Streaming history",
                                   dataTableOutput("streaming_historyDT")
                               ),
                               tabPanel(
                                   title = "Search queries",
                                   dataTableOutput("search_queriesDT")
                               ),
                               tabPanel(
                                   title = "Playlists",
                                   dataTableOutput("playlistDT"),
                                   tags$head(tags$style(HTML(tabs_color)))
                               )
                           )
                           
                    )
                    
                )
                
        ),
        tabItem(tabName = "search_que",
                column(
                    3,
                    box(title = "Date range", 
                        solidHeader = TRUE,
                        width = NULL,
                        status = "success",
                        dateInput('start_date_plots_search_que',
                                  label = ('Start date: yyyy-mm-dd'),
                                  value = ymd("2019-10-01")
                        ),
                        dateInput('end_date_plots_search_que',
                                  label = ('End date: yyyy-mm-dd'),
                                  value = ymd("2019-10-30")
                                  
                        )
                    ),
                    box(title = "Controls",
                        status = "success", 
                        solidHeader = TRUE, 
                        width = NULL,
                        radioButtons(
                            "radio_btn_plot_search_que", "Additional info",
                            choices = c("Platform" = "platform", "Country" = "country")
                        )
                        
                        
                    )
                ),
                column(9,
                       box(width = NULL,
                           status = "success",
                           title = "Plot search queries",
                           solidHeader = TRUE,
                           plotOutput("plot_searches")
                       )
                )
                
                
        ),
        tabItem(tabName = "str_hist",
                fluidRow(
                    column(4,
                           box(title = "Date range", solidHeader = TRUE, width = NULL, 
                               collapsible = TRUE, status = "success",
                               dateInput('start_date_plots_str_his',
                                         label = ('Start date: yyyy-mm-dd'),
                                         value = ymd("2019-10-01")
                               ),
                               dateInput('end_date_plots_str_his',
                                         label = ('End date: yyyy-mm-dd'),
                                         value = ymd("2019-10-30")
                               )
                           )
                    )
                    
                ),
                h2("Playlists plots"),
                fluidRow(
                    column(3,
                           box(title = "Controls", solidHeader = TRUE, width = NULL,
                               status = "success", collapsible = TRUE, collapsed = FALSE,
                               radioButtons("as_per_str_his_play_time", "As percentage",
                                            choices = list("Yes" = TRUE, "No" = FALSE),
                                            selected = FALSE
                               ),
                               radioButtons("t_or_c_play_time", "Number of tracks or playtime",
                                            choices = c("Number of tracks" = "count", "Playtime" = "time")
                               ),
                               uiOutput("ui_play_time"
                                        
                               )
                               
                           )
                    ),
                    column(9,
                           box(title = "Playtime", solidHeader = TRUE, width = NULL,  collapsible = TRUE,
                               status = "success", collapsed = FALSE,
                               plotOutput("str_his_plot_play_time")
                           )
                    )
                ),
                fluidRow(
                    column(3,
                           box(title = "Controls", solidHeader = TRUE, width = NULL,
                               status = "success", collapsible = TRUE, collapsed = FALSE,
                               radioButtons("t_or_c_pop_playlists", "Number of tracks or playtime",
                                            choices = c("Number of tracks" = "count", "Playtime" = "time")
                               ),
                               uiOutput("ui_pop_playlists"
                                        
                               )
                               
                           )  
                    ),
                    column(9,
                           box(title = "Popular playlists", solidHeader = TRUE, width = NULL,  collapsible = TRUE,
                               status = "success", collapsed = FALSE,
                               plotOutput("str_his_plot_pop_playlists")
                           )
                           
                    )
                ),
                h2("Tracks plots"),
                fluidRow(
                    column(3,
                           box(title = "Controls", solidHeader = TRUE, width = NULL,
                               status = "success", collapsible = TRUE, collapsed = FALSE,
                               radioButtons("skipped_track_count", "Only skipped",
                                            choices = c("Yes" = TRUE, "No" = FALSE)
                                            
                               ),
                               radioButtons("time_track_count", "Time division",
                                            choices = c("Year" = "year", "Month" = "month", "Week" = "week", "Day" = "day" )
                                            
                               )
                               
                           )
                    ),
                    column(9,
                           box(title = "Track count", solidHeader = TRUE, width = NULL,
                               status = "success", collapsible = TRUE, collapsed = FALSE,
                               plotOutput("str_his_plot_track_count")
                               
                           )
                           
                    )
                ),
                fluidRow(
                    column(3,
                           box(title = "Controls", solidHeader = TRUE, width = NULL,
                               status = "success", collapsible = TRUE,
                               radioButtons("skipped_track_period", "Include skipped",
                                            choices = c("Yes" = TRUE, "No" = FALSE)
                                            
                               ),
                               radioButtons("percentage_track_period", "As percentage",
                                            choices = c("Yes" = TRUE, "No" = FALSE)
                                            
                               ),
                               radioButtons("by_track_period", "Distribution",
                                            choices = c("Daily" = "weekday", "Hourly" = "hour"),
                                            selected = c("Hourly" = "hour")
                               ),
                               uiOutput("ui_track_period")
                           )
                    ),
                    column(9,
                           box(title = "Track count by period", solidHeader = TRUE, width = NULL,
                               status = "success", collapsible = TRUE, collapsed = FALSE,
                               plotOutput("str_his_plot_track_period")
                           )
                           
                    )
                ),
                h2("Sessions Plot"),
                fluidRow(
                    column(3,
                           box(title = "Controls", solidHeader = TRUE, width = NULL,
                               status = "success", collapsible = TRUE,
                               radioButtons("session_plot", "As percentage",
                                            choices = c("Yes" = TRUE, "No" = FALSE)
                               )
                           )
                    ),
                    column(9,
                           box(title = "Sessions distribution", solidHeader = TRUE, width = NULL,
                               status = "success", collapsible = TRUE,
                               plotOutput("str_his_plot_session")
                           )
                    )
                )
        ),
        tabItem(tabName = "tables",
                fluidRow(column(
                    width = 3,
                    box(
                        width = NULL,
                        solidHeader = TRUE,
                        title = "Date range - for all tables",
                        status = "success",
                        dateInput('start_date_tables',
                                  label = ("Start date: yyyy-mm-dd")),
                        dateInput('end_date_tables',
                                  label = ("End date: yyyy-mm-dd"))
                    ),
                ),
                column(
                    width = 2,
                    box(title = "Summary control", solidHeader = TRUE, width = NULL,
                        collapsible = TRUE, status = "success",
                        radioButtons("as_percentage_summary", "As percentage",
                                     choices = list("Yes" = TRUE, "No" = FALSE),
                                     selected = FALSE
                        )
                    )
                ),
                column(
                    width = 7,
                    box(title = "Summary table", width = NULL, solidHeader = TRUE,
                        status = "success", collapsible = TRUE,
                        tableOutput("summary_dt")
                    )
                )
                ),
                h2("Most frequent"),
                fluidRow(
                    
                    column(
                        width = 3,
                        box(
                            width = NULL, solidHeader = TRUE, title = "Controls",
                            status = "success", collapsible = TRUE,
                            radioButtons("track_or_artist_tables", label = ("Track or Artist"),
                                         choices = list("Artist" = "artist", "Track" = "track"),
                                         selected = "artist"),
                            sliderInput("how_many_tables", label = ("Show how many entries"),
                                        min = 1, max = 30, value = 10)
                            
                        )
                    ),
                    column(width = 4,
                           box(
                               width = NULL, solidHeader = TRUE, collapsible = TRUE,
                               status = "success",
                               title = "Most frequently skipped",
                               DTOutput("most_skipped"),
                           )
                    ),
                    column(
                        width = 4,
                        box(
                            width = NULL, solidHeader = TRUE, collapsible = TRUE,
                            status = "success",
                            title = "Most frequently played",
                            DTOutput("most_played"),
                        )
                    )
                    
                ),
                h2("Longest session of playing with less than 5 minutes breaks between tracks"),
                fluidRow(
                    box(width = 5, title = "Longest session summary",
                        solidHeader = TRUE, collapsible = TRUE,
                        status = "success",
                        tableOutput("longest_session_summ")
                        
                    ),
                    box(width = 7, title = "Longest session",
                        solidHeader = TRUE, collapsible = TRUE,
                        status = "success",
                        DTOutput("longest_session")
                    )
                    
                )
                
        ),
        tabItem(tabName = "oth_us_data_in",
                sidebarLayout(
                    
                    column(3,
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("streaming_history_u2", "Choose JSON file(s) with Streaming History",
                                         multiple = TRUE,
                                         accept = c(".JSON")),
                               actionButton("submit_streaming_history_u2", label = "Submit" )
                           )
                           ##other data input for later 
                           ,
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("search_queries_u2", "Choose JSON file with SearchQueries",
                                         multiple = FALSE,
                                         accept = c(".JSON")),
                               actionButton("submit_search_queries_u2", label = "Submit" )
                           ),
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("playlist_u2", "Choose JSON file with Playlist",
                                         multiple = FALSE,
                                         accept = c(".JSON")),
                               actionButton("submit_playlist_u2", label = "Submit" )
                           )
                           
                           
                    ),
                    
                    
                    column(9,
                           
                           tabBox(
                               width = NULL, side = "right", title = "See the data you've uploaded for second user",
                               id = "tabset1",
                               tabPanel(
                                   title = "Streaming history",
                                   dataTableOutput("streaming_historyDT_u2")
                               ),
                               tabPanel(
                                   title = "Search queries",
                                   dataTableOutput("search_queriesDT_u2")
                               ),
                               tabPanel(
                                   title = "Playlists",
                                   dataTableOutput("playlistDT_u2")
                               )
                           )
                    )
                    
                )
                
        ),
        tabItem(tabName = "plot_compare",
                fluidRow(
                    column(width = 4,
                           box(
                               width = NULL,
                               solidHeader = TRUE,
                               title = "Select day",
                               status = "success",
                               dateInput("date_day_compare",
                                         label = ('Select day: yyyy-mm-dd'),
                                         value = ymd("2019-10-01")
                               )
                           ),
                           box(
                               solidHeader = TRUE, width = NULL, title = "Names",
                               status = "success", 
                               textInput("u1_name", label = "Input name for first user", 
                                         placeholder = "user 1"),
                               textInput("u2_name", label = "Input name for second user", 
                                         placeholder = "user 2"),
                               actionButton("take_names", label = "Set names" )
                               ,
                               
                               
                           )
                    ),
                    column(width = 8,
                           box(
                               width = NULL, status = "success",
                               solidHeader = TRUE, title = "Playtime comparison on selected day",
                               plotOutput("day_compare")
                           )
                           
                    )
                )
        ),
        tabItem(
            tabName = "tables_compare",
            fluidRow(
                     box(title = "Controls", solidHeader = TRUE,
                         status = "success", width = 4,
                         radioButtons("tracks_common", "Show common",
                                      choices = list("Tracks" = TRUE, "Artists" = FALSE),
                                      selected = FALSE
                         )

                     ),
                box(title = "Show common", solidHeader = TRUE, status = "success",
                    width = 8,
                    DTOutput("common_dt")
                )
            )
        ),
        
        
        tabItem(tabName = "about",
                h2("About this app"),
                fluidRow(infoBox(title = "Visits this site to see more",
                                 value = "Github", href = "https://github.com/StatsIMUWr/SpotifyViz"))
        )
    )
)

# Put them together into a dashboardPage
dashboardPage(
    skin = "green",
    dashboardHeader(title = "SpotifyViz"),
    sidebar,
    body
)

