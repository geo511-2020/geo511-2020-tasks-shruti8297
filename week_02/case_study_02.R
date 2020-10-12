#Case study 2 
#My grandfather says climate is cooling

library(tidyverse)

data_url <- 'c:/Users/Baloo/Desktop/station.csv'
temp <- read_csv(data_url, skip=1,na='999.90',
                 col_names = c('YEAR','JAN','FEB','MAR','APR','MAY',
                               'JUN','JUL','AUG','SEP','OCT','NOV','DEC','DJF',
                               'MAM','JJA','SON'))

plot <- ggplot(temp,aes(YEAR,JJA))+geom_line()+geom_smooth(color='red')

plot+labs(title='Mean Summer Temperatures in Buffalo,NY',subtitle = 
            'Summer includes June, July, and August
Data from the Global Historical Climate Network',caption= 'Red line is a LOESS smooth',
          x='Year',y='Mean Summer Temperatures (C)')
ggsave('Mean_temp_JJA.png')
