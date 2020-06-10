

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
    tabItems(
        tabItem(tabName = "input_user_data",
                sidebarLayout(
                    
                    # Sidebar panel for inputs ----
                    column(3,
                        
                        # Input: Select a file ----
                        box(
                            width = NULL,
                            status = "success",
                            fileInput("StreamingHistory", "Choose JSON file(s) with Streaming History",
                                      multiple = TRUE,
                                      accept = c(".JSON"))
                        ),
                        box(
                            width = NULL,
                            status = "success",
                            fileInput("SearchQueries", "Choose JSON file with SearchQueries",
                                      multiple = FALSE,
                                      accept = c(".JSON"))
                        ),
                         box(
                             width = NULL,
                             status = "success",
                             fileInput("Playlist", "Choose JSON file with Playlist",
                                       multiple = FALSE,
                                       accept = c(".JSON")) 
                         )   
   
                        

                    ),
                    
                    # Main panel for displaying outputs ----
                    column(9,
                        
                        # Output: Data file ----

                        tabBox(
                            width = NULL,
                            title = "See the data you've uploaded",
                            # The id lets us use input$tabset1 on the server to find the current tab
                            id = "tabset1",
                            height = "450px",
                            side = "right",
                            tabPanel(
                                    title = "Streaming history",
                                    dataTableOutput("StreamingHistoryDT")
                            ),
                            tabPanel(
                                        title = "Search queries",
                                        dataTableOutput("SearchQueriesDT")
                                    )
                            ,
                            tabPanel(
                                    title = "Playlists",
                                    dataTableOutput("PlaylistDT")
                            ),
                            
                            tags$head(tags$style(HTML(tabs_color
                                                      )))
                        )
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

