install.packages("reprex")
reprex::reprex({
  library(tidyverse)
  library(reprex)
  library(sf)
  library(spData)
  data(world)
  library(reprex)
  library(ggplot2)
  ggplot(world,aes(x=gdpPercap, color=continent))+
    geom_density(alpha=0.5,color=F)},venue = "html")


ggplot( world, aes(x=gdpPercap, fill = continent)) +
  geom_density(alpha=0.5)