#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define UI for application that draws a histogram
fluidPage(
  #title
  titlePanel("Breast Cancer Data"), 

  # Sidebar with a slider input for number of bins
  sidebarLayout(
      sidebarPanel(
        img(src='./ribbon.jpg', width='10%'),
      ),

      # Show a plot of the generated distribution
      mainPanel(
        fluidRow(
          column(4,
            selectizeInput(inputId = 'Characteristic',
                           label = 'Characteristic',
                           choices = colnames(data)),
            
            sliderInput("size",
                        "size in mm:",
                        min = 1,
                        max = 10,
                        value = c(3,7))
          ),
          column(7,
            plotOutput('dist')
          )
        )
      )
  )
)
