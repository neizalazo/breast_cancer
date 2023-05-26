#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# plot distribution
function(input, output) {
  output$dist  <-  renderPlot(
       data %>% filter((.data[[input$Characteristic]] >= input$size[1])
                       &(.data[[input$Characteristic]] <= input$size[2])) %>%
                ggplot(aes_string(x = input$Characteristic)) +
                geom_bar() +  
                ggtitle(paste(input$Characteristic, 'Distribution')) +
                xlab(paste(input$Characteristic, '(mm)')) +
                ylab('Sample count') +
                theme(plot.title = element_text(hjust = 0.5, size = 20),
                      axis.title = element_text(size = 15))
  )
  }


