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
    tabItems(
      tabItem(tabName = 'Introduction',
        fluidRow()),
    

      tabItem(tabName = 'Exploratory',
          tabBox(
            title = "Exploratory Analysis",
            # The id lets us use input$tabset1 on the server to find the current tab
            id = "tabset1", height = "1000px", width = "1000px",
            tabPanel("Distribution", 
                fluidRow( #SELECT parameter for distribution tab
                    column(4,
                           selectizeInput(inputId = 'Parameter',
                                          label = 'Parameter',
                                          choices = colnames(data)[-1]))
                ), #fluidRow
                fluidRow( #Histogram
                    column(4,
                           sliderInput(inputId = 'bins',
                                       label = 'No. of bins',
                                       value = 20,
                                       min = 1,
                                       max = 50)),
                    column(7, plotOutput('dist')),
                ), # end fluidRow
                fluidRow( #Violin and box
                    column(4,
                           radioButtons(inputId = 'dis_opt',
                                       label = 'Graph Options',
                                       choices = c('boxplot'='geom_boxplot', 'violin'='geom_violin'),
                                       selected = 'geom_boxplot')),
                     column(7, plotOutput('box_vio')),
                )#fluidRow
            ),#tabPanel Distribution
            
            tabPanel("Scatter Plots", 
                 column(4,
                        selectizeInput(inputId = 'Parameter1',
                                       label = 'Parameter1',
                                       choices = colnames(data)[-1]),
                        selectizeInput(inputId = 'Parameter2',
                                       label = 'Parameter2',
                                       selected = 'texture_mean',
                                       choices = colnames(data)[-1]),
                        checkboxInput("line", label = "Line of Best Fit", value = TRUE),
                 ), # end column(4,
                 column(7,
                        plotOutput('scatt')
                 ) # end column(7,
            ),#tabPanel("Scatter Plots",  
            
            tabPanel("Correlation Matrix",
               plotOutput('Correlation', height = "1000px") %>%
                 withSpinner(color="#0dc5c1")
            )#tabPanel("Correlation Matrix",
 
          )# tabBox
      ),# tabItem(tabName = 'Exploratory'
   
      
      tabItem(tabName = 'Modeling',
          tabBox(
            title = "Modeling",
            # The id lets us use input$tabset1 on the server to find the current tab
            id = "tabset2", height = "1000px", width = "1000px",
            tabPanel("Regression Output", 
                     verbatimTextOutput('logistic_sum')),
            tabPanel("Probability Plot", 
                     plotOutput('prob_log')))),

      
      tabItem(tabName = 'About',
              fluidRow())
      )

  ) #end Body
)

