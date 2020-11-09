# CO2 Annual Mean Data

library(tidyverse)
annual_mean <- read_table("ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_annmean_mlo.txt", skip = 56)

# Data Plotted


library(ggplot2)
install.packages("ggthemes")
library(ggthemes)
figure <- ggplot(annual_mean, aes(year, mean)) + geom_line() +
  labs(x = "Year", y = "Annual Mean", title = "Annual Mean CO2 1958 - 2019") +
  theme_bw()

figure

library(dplyr)
recent_decade <- annual_mean %>%
  arrange(desc(year)) %>% 
  top_n(n = 10)


library(kableExtra)
kable(head(slice(recent_decade, desc(year))), format = "simple",
             align = "c", caption = 'Annual Means for the Last Decade')
