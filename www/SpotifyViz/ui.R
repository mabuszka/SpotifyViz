

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
## MAGDA
tabs_color <- '.nav-tabs-custom .nav-tabs li.active {
    border-top-color: #00a65a;
}
.nav-tabs-custom>.nav-tabs {
                            background-color: #00a65a;
                            }
.nav-tabs-custom > .nav-tabs > li.header {
                            color: #f4f4f4f4;
}
.nav-tabs-custom>.nav-tabs>li>a {
    color: #FFFFFF;
}
                            
.nav-tabs-custom>.nav-tabs>li.active:hover>a, .nav-tabs-custom>.nav-tabs>li.active>a {
    background-color: #FFFFFF;
    color: #333;
}'

## MAGDA

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
                                         accept = c(".JSON"))
                           ),
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("search_queries", "Choose JSON file with SearchQueries",
                                         multiple = FALSE,
                                         accept = c(".JSON"))
                           ),
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("playlist", "Choose JSON file with Playlist",
                                         multiple = FALSE,
                                         accept = c(".JSON")) 
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
                                    dataTableOutput("playlistDT")
                            )
                        )
                    )
                    
                )
                
        ),
        tabItem(tabName = "search_que",
                column(
                    3,
                    box(title = "Date range", solidHeader = TRUE, width = NULL,
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
                    box(title = "Controls", status = "success", solidHeader = TRUE, width = NULL,
                        radioButtons(
                            "radio_btn_plot_search_que", "Additional info",
                            choices = c("Platform" = "platform", "Country" = "country")
                        )
                        
                        
                    )
                ),
                column(9,
                       box(width = NULL, status = "success",
                           plotOutput("plot_searches")
                       )
                )
                
            
        ),
        #### ARTUR
        tabItem(tabName = "str_hist",
                fluidRow(
                    column(5,
                           box(title = "Date range", solidHeader = TRUE, width = NULL,
                               status = "success",
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
                fluidRow(
                    column(3,

                           box(title = "Controls", solidHeader = T, width = NULL,
                               status = "success", collapsible = T, collapsed = T,
                               radioButtons("as_per_str_his_play_time", "As percentage",
                                            choices = c("Yes" = TRUE, "No" = FALSE)
                               ),
                               radioButtons("t_or_c_play_time", "Additional info",
                                        choices = c("Time" = "time", "Count" = "count")
                               ),
                               uiOutput("ui_play_time",
                                   
                               )
                               
                           )
                    ),
                    column(9,
                           box(title = "Playtime", solidHeader = T, width = NULL,  collapsible = T,
                               status = "success", collapsed = T,
                               plotOutput("str_his_plot_play_time")
                           )
                    )
                )
            
        ),
        ### koniec ARTUR
        tabItem(tabName = "tables",
                fluidRow(column(
                    width = 3,
                    box(
                        width = NULL,
                        solidHeader = TRUE,
                        title = "Date range",
                        status = "success",
                        dateInput('start_date_tables',
                                               label = ('Start date: yyyy-mm-dd'),
                                               value = Sys.Date()),
                        dateInput('end_date_tables',
                                  label = ('End date: yyyy-mm-dd'),
                                  value = Sys.Date()),
                        ),
                    box(
                        width = NULL,
                        solidHeader = TRUE,
                        title = "Controls",
                        status = "success",
                        radioButtons("track_or_artist_tables", label = ("Track or Artist"),
                                     choices = list("Artist" = "artist", "Track" = "track"),
                                     selected = "artist"),
                        
                    )),
                    column(
                        width = 4,
                    
                    box(
                        width = 0,
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        status = "success",
                        title = "Most frequently skipped",
                        DTOutput("most_skipped"),
                    )
                    ),
                    column(
                        width = 4,
                    box(
                        width = 0,
                        solidHeader = TRUE,
                        collapsible = TRUE,
                        status = "success",
                        title = "Most frequently played",
                        DTOutput("most_played"),
                    )
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
                                         accept = c(".JSON"))
                           ),
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("search_queries_u2", "Choose JSON file with SearchQueries",
                                         multiple = FALSE,
                                         accept = c(".JSON"))
                           ),
                           box(
                               width = NULL,
                               status = "success",
                               fileInput("playlist_u2", "Choose JSON file with Playlist",
                                         multiple = FALSE,
                                         accept = c(".JSON")) 
                           )

                           
                    ),
                    
                    
                    column(9,
                           
                           tabBox(
                               width = NULL,
                               title = "See the data you've uploaded four second user",
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
        
        ## MAGDA
        
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

