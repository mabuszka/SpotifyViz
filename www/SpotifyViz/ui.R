

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
                           ),
                           box("Plot my habits",
                               width = NULL,
                               actionButton("do_plots", "Plot")
                           )
                           
                    ),

                    
                    column(9,
                        
                        tabBox(
                            width = NULL,
                            title = "See the data you've uploaded",
                            id = "tabset1",
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
                box(width = NULL,
                    plotOutput("plot_searches")
                )
            
        ),
        
        tabItem(tabName = "tables",
                h2("Blabla")
            
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
        
        tabItem(tabName = "about",
                h2("About this app"),
                fluidRow(infoBox(title = "Visits this site to see more",
                                 value = "Github", href = "https://github.com/StatsIMUWr/SpotifyViz"))
        )
    )
)

# Put them together into a dashboardPage
dashboardPage(
    dashboardHeader(title = "SpotifyViz"),
    sidebar,
    body
)

