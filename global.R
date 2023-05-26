library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)

#load data set: https://www.kaggle.com/datasets/uciml/breast-cancer-wisconsin-data?select=data.csv&page=3
data = read.csv("data.csv") 
data = data %>% select('diagnosis':'fractal_dimension_mean')

#str(data)
data$diagnosis = as.factor(data$diagnosis)

# 
# #transform first and last columns as factors
# data$Class= as.factor(data$Class)
# data$Bare_Nuclei = as.integer(data$Bare_Nuclei)
# 
# #remove na
# data = data %>% filter(!is.na(Bare_Nuclei))
