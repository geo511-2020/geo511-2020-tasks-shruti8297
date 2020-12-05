#case study 05 

library(spData)
library(sf)
library(tidyverse)
library(units)
data(world) 
data(us_states)


#finding the crs 
st_crs(world)
albers="+proj=aea +lat_1=29.5 +lat_2=45.5 +lat_0=37.5 +lon_0=-96 +x_0=0 +y_0=0 +ellps=GRS80 +datum=NAD83 +units=m +no_defs"
world_filter<-st_transform(world,albers)
Canada<- world_filter %>%
  filter(name_long=='Canada')

Buffer<- st_buffer(Canada,dist=10000)
ggplot(Buffer)+
  geom_sf()
us_states_filter<-st_transform(us_states,albers)
New_York<- us_states_filter %>%
  filter(NAME=='New York')
border<-st_intersection(Buffer,New_York)
ggplot()+
  geom_sf(data=New_York)+
  geom_sf(data=border,aes(fill='red'))
total_area<-st_area(border)
set_units(total_area,km^2)