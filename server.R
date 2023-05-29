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
  ) #output$dist
  
  output$box  <-  renderPlot(
    data %>% ggplot(aes_string(x = input$Parameter)) +
      geom_boxplot() +  
      ggtitle(paste(input$Parameter, 'Box Plot')) +
      xlab(paste(input$Parameter, 'size (mm)')) +
      theme(plot.title = element_text(hjust = 0.5, size = 20),
            axis.title = element_text(size = 15))
  ) #output$box
  
  output$scatter  <-  renderPlot(
    data %>% ggplot(aes_string(x = input$Parameter1, y = input$Parameter2)) +
      geom_point() +  
      ggtitle(paste(input$Parameter1, 'vs', input$Parameter2)) +
      xlab(paste(input$Parameter1, 'size (mm)')) +
      ylab(paste(input$Parameter2, 'size (mm)')) +
      theme(plot.title = element_text(hjust = 0.5, size = 15),
            axis.title = element_text(size = 12))
  ) #output$scatter

  output$Correlation  <-  renderDataTable(
    corrplot(cor(data[3:6]), method="circle")   
  ) #output$Correlation
  
  observe(updateSliderInput(session, 'bins', max=length(unique(data[[input$Parameter]]))))
}
  



