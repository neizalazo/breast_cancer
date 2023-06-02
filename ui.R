#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

source('functions.R')

dashboardPage( 
  
  dashboardHeader(
    title = span(img(src='./ribbon2.png', width=25), "Breast Cancer Data" ) 
  ), # end Header
  
  dashboardSidebar(
    sidebarMenu(
      menuItem('Home', tabName='Home', icon=icon("home", lib = "glyphicon")),
      menuItem('Exploratory Analysis', tabName='Exploratory', icon=icon("stats", lib = "glyphicon")),
      menuItem('Modeling', tabName='Modeling', icon=icon("map-marker", lib = "glyphicon")),
      menuItem('About', tabName='About', icon=icon("user", lib = "glyphicon"))
          )
  ), #end Sidebar
  
  dashboardBody(
    tabItems(
        tabItem(tabName = 'Home',
                tabBox(
                  title = "Home",
                  # The id lets us use input$tabset1 on the server to find the current tab
                  id = "Home", height = "1000px", width = "1000px",
                  tabPanel("Breast Cancer", 
                        fluidRow(
                          # A static BOX
                          box(title=h1("1"),
                              width = 4,
                              solidHeader = TRUE,
                             background = "maroon",
                             height = 250,
                              h4("Breast cancer is the most 
                             commonly diagnosed cancer among 
                             American women.")),
                          # A static BOX
                          box(title=h1("13%"),
                              width = 4,
                              solidHeader = TRUE,
                              background = "maroon",
                              height = 250,
                              h4("About 13% (about 1 in 8) of U.S. 
                              women are going to develop 
                              invasive breast cancer in the 
                              course of their life.")),
                          box(title=h1("300,590"),
                              width = 4,
                              solidHeader = TRUE,
                              background = "maroon",
                              height = 250,
                              h4("In 2023, an estimated 300,590 
                             people will be diagnosed with 
                             breast cancer in the U.S.")),
                        ),
                        h1('Welcome!', align ='center' ),
                        br(),
                        h4('Breast cancer is a complex and widely studied disease 
                           affecting millions of women and some men worldwide. 
                           Breast cancer is of immense importance and concern, as it 
                           is the most common cancer among women in the US. Receiving a 
                           breast cancer diagnosis can be overwhelming and bring about a 
                           wide range of emotions. '),
                        br(),
                        h4('This website analyzes a breast cancer dataset,  aiming to 
                           extract meaningful insights and contribute to the existing 
                           knowledge of this illness.'),
                        br(),
                        h4('The objective of this project is multifaceted. Firstly, I 
                           conduct exploratory data analysis to enhance our understanding 
                           of this disease by dissecting the dataset and its various 
                           attributes and identifying correlations and patterns. Secondly, 
                           I aim to develop a predictive model utilizing machine learning 
                           algorithms, specifically logistic regression.'),
                        br(),
                        h4('This website contains analysis reports, visualizations, and 
                           interactive tools that present my findings and insights. I 
                           encourage you to explore the various sections, engage with the 
                           data, and gain a deeper understanding of the complexities of 
                           breast cancer.')

                  ),
                  tabPanel("Data Set",
                           br(),
                           h4('Features are computed from a digitized image of a fine 
                              needle aspirate (FNA) of a breast mass. They describe 
                              characteristics of the cell nuclei present in the image.'),
                           h4('This database is also available through the UW CS ftp server:'),
                           h4(a("Breast Cancer Wisconsin (Diagnostic) Data Set", href="https://archive.ics.uci.edu/ml/datasets/Breast+Cancer+Wisconsin+%28Diagnostic%29")),
                           br(),
                           h3('Attribute Information:'),
                           h4('1) ID number'),
                           h4('2) Diagnosis (M = malignant, B = benign)'),
                           br(),
                           h4('Ten real-valued features are computed for each cell nucleus:'),
                           br(),
                           h4('a) radius (mean of distances from center to points on the perimeter)'),
                           h4('b) texture (standard deviation of gray-scale values)'),
                           h4('c) perimeter'),
                           h4('d) area'),
                           h4('e) smoothness (local variation in radius lengths)'),
                           h4('f) compactness (perimeter^2 / area - 1.0)'),
                           h4('g) concavity (severity of concave portions of the contour)'),
                           h4('h) concave points (number of concave portions of the contour)'),
                           h4('i) symmetry'),
                           h4('j) fractal dimension ("coastline approximation" - 1)'))
                )),
    

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
        fluidRow(
           column(4,
              checkboxGroupInput(inputId = 'var1',
                             label = 'Select dependent variables:',
                             choices = colnames(data)[-1]),
           ), # end column(4,
           column(7,
              tabBox(
                  title = "Modeling",
                  # The id lets us use input$tabset1 on the server to find the current tab
                  id = "tabset2", width = "700px",
                  tabPanel("Regression Output",
                      verbatimTextOutput('logistic_sum')),
                  tabPanel("Probability Plot",
                      plotOutput('prob_log'))
                  )
           ), # end column(7,
        ),
           fluidRow(
             box(
               width = 12,
               height = 200,
               h5('How to choose a good model')
             ),
           )
        ),# tabItem Modeling
  
        
        tabItem(tabName = 'About',
          column(12,
            box(
              title = h3("More Information about this project"),
              status = "primary", 
              solidHeader = TRUE,
              width = 12,
              height = 200,
              h4('You can find the code for this and other of my projects in my 
                 Github: ', a('Github', href='https://github.com/neizalazo'))
            ),
            box(
              title = h3("About me"),
              status = "primary", 
              solidHeader = FALSE,
              width = 12,
              height = 270,
              img(src='./Neiza.jpg', width=54),
              h4('Neiza Lazo is a data scientist passionate about uncovering the 
                 story behind the data. Neiza worked 10 years as a CPU designer 
                 at Intel. She earned a Bachelor and a Master of Science in 
                 Electrical Engineering from the University of Kansas. ', 
                 a('LinkedIn', href='https://www.linkedin.com/in/neizalazo/'))
              
            )#box
        )#column(12,
      )#tabItem(tabName = 'About',
    )
  ) #end Body
)



