#Case study 1 
data(iris)
library(ggplot2)
data("iris")
petal_length_mean <- mean(iris$Petal.Length)
(petal_length_mean)
ggplot(data=iris,aes(Petal.Length))+
  geom_histogram()
