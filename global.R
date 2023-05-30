library(shiny)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(shinydashboard)
library(ggcorrplot)
library(ggforce)
library(GGally)
library(shinycssloaders)

#load data set: https://www.kaggle.com/datasets/uciml/breast-cancer-wisconsin-data?select=data.csv&page=3
data = read.csv("data.csv") 
data = data %>% select('diagnosis':'fractal_dimension_mean')

#str(data)
data$diagnosis = as.factor(data$diagnosis)




