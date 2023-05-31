#function to color correlation boxes in matrix
my_fn <- function(data, mapping, method="p", use="pairwise", ...){
  # grab data
  x <- eval_data_col(data, mapping$x)
  y <- eval_data_col(data, mapping$y)
  
  # calculate correlation
  corr <- cor(x, y, method=method, use=use)
  
  # calculate colour based on correlation value
  # Here I have set a correlation of minus one to blue, 
  # zero to white, and one to red 
  # Change this to suit: possibly extend to add as an argument of `my_fn`
  colFn <- colorRampPalette(c("#66CCFF", "white", "#FFCCCC"), interpolate ='spline')
  fill <- colFn(100)[findInterval(corr, seq(-1, 1, length=100))]
  
  ggally_cor(data = data, mapping = mapping, ...) + 
    theme_void() +
    theme(panel.background = element_rect(fill=fill))
}


#LOGISTIC REGRESSION 
library(ggplot2)
library(cowplot)
#logistic <- glm(diagnosis~perimeter_mean, data, family='binomial')
logistic <- glm(diagnosis~., data, family='binomial')
logistic_sum <- summary(logistic)

predicted_data <- data.frame(
  prob_of_cancer = logistic$fitted.values, diagnosis=data$diagnosis)
predicted_data <- predicted_data[order(predicted_data$prob_of_cancer, decreasing=FALSE),]

predicted_data$rank = 1:nrow(predicted_data)

prob_log <- ggplot(data=predicted_data, aes(x=rank, y=prob_of_cancer)) +
  geom_point(aes(color=diagnosis), alpha=1, shape=5, stroke=2) +
  xlab('Index') +
  ylab('Predicted probability of Cancer')


