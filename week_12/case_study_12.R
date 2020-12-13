library(dplyr)
library(ggplot2)
library(ggmap)
library(htmlwidgets)
install.packages('widgetframe')
library(widgetframe)

library(tidyverse)

library(rnoaa)
install.packages('xts')
library(xts)
install.packages('dygraphs')
library(dygraphs)

# sorting data 
d=meteo_tidy_ghcnd("USW00014733",
                   date_min = "2016-01-01", 
                   var = c("TMAX"),
                   keep_flags=T) %>% 
  mutate(date=as.Date(date),
         tmax=as.numeric(tmax)/10)

d_time_series <- xts(d$tmax, order.by = d$date)

# creating a plot 
dygraph(d_time_series, main = "Daily Maximum Temperature in Buffalo, NY") %>%
  dyRangeSelector(dateWindow = c("2020-01-01", "2020-10-31")) %>%
  dyOptions(axisLabelFontSize = 12)


