#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


source('functions.R')

# plot distribution
function(input, output, session) {
  #Plot DISTRIBUTION
  observe(updateSliderInput(session, 'bins', max=length(unique(data[[input$Parameter]]))))
  output$dist  <-  renderPlot(
       data %>% ggplot(aes_string(x = input$Parameter)) +
                geom_histogram(bins = input$bins, aes(fill=diagnosis)) +  
                ggtitle(paste(input$Parameter, 'Distribution')) +
                xlab(paste(input$Parameter, 'size (mm)')) +
                ylab('Frequency') +
                scale_fill_discrete(labels = c("Benign", "Malignant")) + 
                theme(plot.title = element_text(hjust = 0.5, size = 20),
                      axis.title = element_text(size = 15)) 
  ) #output$dist
  
  #Plot BOX and VIOLIN
  box_vio <- eventReactive(c(input$Parameter,input$dis_opt), {
    plot_input = get(input$dis_opt)
    data %>% ggplot(aes_string(x = input$Parameter, y = data[['diagnosis']])) +
      plot_input(aes(fill=diagnosis)) +  
      ggtitle(paste(input$Parameter, 'Box Plot')) +
      xlab(paste(input$Parameter, 'size (mm)')) +
      scale_fill_discrete(labels = c("Benign", "Malignant")) + 
      theme(plot.title = element_text(hjust = 0.5, size = 20),
            axis.title = element_text(size = 15)) 
  })
  output$box_vio  <-  renderPlot(
    if (input$dis_opt == 'geom_violin') {box_vio()+geom_sina(alpha=0.5)} else
    box_vio()
  ) #output$box

  #Plot SCATTER  
  scatt <-  eventReactive(c(input$Parameter1, input$Parameter2), {
    data %>% ggplot(aes_string(x = input$Parameter1, y = input$Parameter2)) +
      geom_point(aes(color=diagnosis)) +
      ggtitle(paste(input$Parameter1, 'vs', input$Parameter2)) +
      xlab(paste(input$Parameter1, 'size (mm)')) +
      ylab(paste(input$Parameter2, 'size (mm)')) +
      scale_colour_discrete(labels = c("Benign", "Malignant")) +
      theme(plot.title = element_text(hjust = 0.5, size = 20),
            axis.title = element_text(size = 15))
  })
  output$scatt  <-  renderPlot(
    if (input$line) {scatt()+geom_smooth(method=lm)} else {scatt()}
  ) #output$scatt

  #Plot CORRELATION Matrix  
  output$Correlation  <- renderPlot(
    ggpairs(data, columns = 2:ncol(data), 
            title = "Bivariate analysis Breast Cancer Outcome",
            #upper = list(continuous = wrap("cor", size=5)),
            upper = list(continuous = wrap(my_fn, size=5)),
            lower = list(continuous = wrap("smooth",
                                           alpha = 0.3,
                                           size = 0.1)),
            mapping = aes(color = diagnosis, alpha =0.5)) +
    theme(strip.text.x = element_text(size = 12),
          strip.text.y = element_text(size = 12)))
  
  #Plot prob_log  
  output$logistic_sum  <- renderPrint(
    logistic_sum) 
  
  #Plot prob_log  
  output$prob_log  <- renderPlot(
            prob_log)
  
}
  



