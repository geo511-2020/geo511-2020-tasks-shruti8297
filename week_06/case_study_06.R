library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)
library(ggplot2)
library(ncdf4)
library(dplyr)



# Accessing data 
download.file("https://crudata.uea.ac.uk/cru/data/temperature/absolute.nc","absolute.nc")
tmean=raster("absolute.nc")
plot(tmean)

# filtering data 
data(world)  
data_1 <- world %>% 
  filter(continent != 'Antarctica')

world_1 <- as(data_1, 'Spatial')
plot(world_1)


Temp_1 <- raster::extract(tmean, world_1, fun = max, na.rm = 1, 
                         smal = 1, sp = 1)
Temp_2 <- st_as_sf(Temp_1)
Temp_2

# Plotting 

My_plot <- ggplot() + geom_sf(data = Temp_2, 
                                 aes(fill = Temp_2$CRU_Global_1961.1990_Mean_Monthly_Surface_Temperature_Climatology)) +
  scale_fill_viridis_c(name="Annual\nMaximum\nTemperature (C)")+theme(legend.position = 'bottom')



