#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#



# plot distribution
function(input, output, session) {
  
  output$dist  <-  renderPlot(
       data %>% ggplot(aes_string(x = input$Parameter)) +
                geom_histogram(bins = input$bins) +  
                ggtitle(paste(input$Parameter, 'Distribution')) +
                xlab(paste(input$Parameter, 'size (mm)')) +
                ylab('Frequency') +
                theme(plot.title = element_text(hjust = 0.5, size = 20),
                      axis.title = element_text(size = 15))
  )
  
  observe(updateSliderInput(session, 'bins', max=length(unique(data[[input$Parameter]]))))
}
  



