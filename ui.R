#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#




dashboardPage( 
  
  dashboardHeader(
    title = span(img(src='./ribbon2.png', width=25), "Breast Cancer Data" ) 
  ), # end Header
  
  dashboardSidebar(
    sidebarMenu(
      menuItem('Introduction', tabName='Introduction', icon=icon("home", lib = "glyphicon")),
      menuItem('Exploratory Analysis', tabName='Exploratory', icon=icon("stats", lib = "glyphicon")),
      menuItem('Modeling', tabName='Modeling', icon=icon("map-marker", lib = "glyphicon")),
      menuItem('About', tabName='About', icon=icon("user", lib = "glyphicon"))
          )
  ), #end Sidebar
  
  dashboardBody(
    #tabItems(tabName = 'Introduction'),
    tabItems(
      tabItem(tabName = 'Exploratory',
        fluidRow(
          tabBox(
            title = "Exploratory Analysis",
            # The id lets us use input$tabset1 on the server to find the current tab
            id = "tabset1", height = "1000px", width = "400px",
            tabPanel("Distribution", 
                column(4,
                       selectizeInput(inputId = 'Parameter',
                                      label = 'Parameter',
                                      choices = colnames(data)[-1]),
                       #uiOutput('slider')
                       sliderInput(inputId = 'bins',
                                   label = 'No. of bins',
                                   value = 20,
                                   min = 1,
                                   max = 50
                       )
                ), # end column(4,
                column(7,
                       plotOutput('dist'),
                       plotOutput('box')
                ) # end column(7,
            ),#Tab1
            
            tabPanel("Scatter Plots", 
                     column(4,
                            selectizeInput(inputId = 'Parameter1',
                                           label = 'Parameter1',
                                           choices = colnames(data)[-1]),
                            selectizeInput(inputId = 'Parameter2',
                                           label = 'Parameter2',
                                           choices = colnames(data)[-1])
                     ), # end column(4,
                     column(7,
                            plotOutput('scatter')
                     ) # end column(7,
            ),#tabPanel("Scatter Plots",  
            
            tabPanel("Correlation Matrix", 
               plotOutput('Correlation')
            )#tabPanel("Correlation Matrix",             
          )# tabBox
          

        ) # fluidRow
      )# tabItem(tabName = 'Exploratory'
    )#tabItems
  ) #end Body
)

