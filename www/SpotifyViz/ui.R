

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
                               fileInput("streaming_history", "Choose JSON file(s) with Streaming History",
                                         multiple = TRUE,
                                         accept = c(".JSON"))
                           ),
                           box(
                               width = NULL,
                               fileInput("search_queries", "Choose JSON file with SearchQueries",
                                         multiple = FALSE,
                                         accept = c(".JSON"))
                           ),
                           box(
                               width = NULL,
                               fileInput("playlist", "Choose JSON file with Playlist",
                                         multiple = FALSE,
                                         accept = c(".JSON")) 
                           )
                           
                    ),

                    
                    column(9,
                        
                        tabBox(
                            width = NULL,
                            title = "See the data you've uploaded",
                            # The id lets us use input$tabset1 on the server to find the current tab
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
                                    ),
                            
                            tags$head(tags$style(HTML(tabs_color)))
                        )
                    )
                    
                )
                
        ),
        tabItem(tabName = "search_que",
                column(
                    3,
                    box(title = "Date range", status = "primary", solidHeader = TRUE, width = NULL,
                        
                        dateInput('start_date_plots_search_que',
                                  label = ('Start date: yyyy-mm-dd'),
                                  value = ymd("2019-10-01")
                        ),
                        dateInput('end_date_plots_search_que',
                                  label = ('End date: yyyy-mm-dd'),
                                  value = ymd("2019-10-30")
                        
                        )
                    ),
                    box(title = "Controls", status = "primary", solidHeader = TRUE, width = NULL,
                        radioButtons(
                            "radio_btn_plot_search_que", "Additional info",
                            choices = c("Platform" = "platform", "Country" = "country")
                        )
                        
                        
                    )
                ),
                column(9,
                       box(width = NULL,
                           plotOutput("plot_searches")
                       )
                )
                
            
        ),
        ## MAGDA
        
        tabItem(tabName = "tables",
                fluidRow(column(
                    width = 3,
                    box(
                        width = NULL,
                        solidHeader = TRUE,
                        title = "Date range",
                        status = "success",
                        uiOutput("start_date_tables_ui"),
                        uiOutput("end_date_tables_ui")
                        ),
                    box(
                        width = NULL,
                        solidHeader = TRUE,
                        title = "Controls",
                        status = "success",
                        radioButtons("track_or_artist_tables", label = ("Track or Artist"),
                                     choices = list("Artist" = "artist", "Track" = "track"),
                                     selected = "artist"),
                        sliderInput("how_many_tables", label = ("Show how many entries"),
                                    min = 0, max = 30, value = 10)
                        
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
                               fileInput("streaming_history_u2", "Choose JSON file(s) with Streaming History",
                                         multiple = TRUE,
                                         accept = c(".JSON"))
                           ),
                           box(
                               width = NULL,
                               fileInput("search_queries_u2", "Choose JSON file with SearchQueries",
                                         multiple = FALSE,
                                         accept = c(".JSON"))
                           ),
                           box(
                               width = NULL,
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

