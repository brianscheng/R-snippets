#code for applying transformation by category
library(dplyr)

#create reproducible data first
category = factor(rep(c("blue","red","green"),each=10))
number   = rep(1:10, times = 3, each = 1)
data     = data.frame(category, number)

#dplyr solution
data$new_number <-data %>%
  mutate(new_number = case_when(category == "blue" ~ number*2,
                                category == "red"  ~ number*3,
                                category == "green"~ number*4))

