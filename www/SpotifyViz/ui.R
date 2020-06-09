

sidebar = dashboardSidebar(
    sidebarMenu(
        menuItem("Input user data", tabName = "input_user_data", icon = icon("fas fa-upload")),
        menuItem("Tables", tabName = "tables", icon = icon("fas fa-table")),
        menuItem("Plots", tabName = "tables", icon = icon("fas fa-chart-bar"),
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
    tabItems(
        tabItem(tabName = "input_user_data",
                sidebarLayout(
                    
                    # Sidebar panel for inputs ----
                    column(3,
                        
                        # Input: Select a file ----
                        box(
                            fileInput("StreamingHistory", "Choose JSON file(s) with Streaming History",
                                      multiple = TRUE,
                                      accept = c(".JSON"))
                        ),
                        box(
                            fileInput("SearchQueries", "Choose JSON file with SearchQueries",
                                      multiple = FALSE,
                                      accept = c(".JSON"))
                        ),
                         box(
                             fileInput("Playlist", "Choose JSON file with Playlist",
                                       multiple = FALSE,
                                       accept = c(".JSON")) 
                         )   
   
                        

                    ),
                    
                    # Main panel for displaying outputs ----
                    column(9,
                        
                        # Output: Data file ----

                        tabBox(
                            title = "See the data you've uploaded",
                            # The id lets us use input$tabset1 on the server to find the current tab
                            id = "tabset1", height = "450px", width = "640px",
                            tabPanel(
                                    title = "Streaming history",
                                    dataTableOutput("StreamingHistoryDT")
                            ),
                            tabPanel(
                                        title = "Search queries",
                                        dataTableOutput("SearchQueries")
                                    ),
                            tabPanel(
                                    title = "Playlists",
                                    dataTableOutput("Playlist")
                            )
                        )
                    )
                    
                )
                
        ),
        
        tabItem(tabName = "tables",
                h2("Blabla")
            
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

