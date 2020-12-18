
library(tidyverse)
annual <- read_table("ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_annmean_mlo.txt", skip = 56)

library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
plot <- ggplot(annual, aes(year, mean)) + geom_line() +
  labs(x = "Year", y = "Annual", title = "Annual Mean Carbon dioxide 1958 - 2019") +
  theme_bw()

library(dplyr)

new<- annual %>%
  arrange(desc(year)) %>% 
  top_n(n = 10)

library(kableExtra)
kable(head(slice(new, desc(year))), format = "simple",
             align = "c", caption = 'Annual Means for new decade')


plot 