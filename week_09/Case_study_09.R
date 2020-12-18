library(sf)
library(tidyverse)
library(ggmap)
library(rnoaa)
library(spData)
library(dplyr)

#world data 
data(world)
data(us_states)

#loading the url 

data="https://www.ncei.noaa.gov/data/international-best-track-archive-for-climate-stewardship-ibtracs/v04r00/access/shapefile/IBTrACS.NA.list.v04r00.points.zip"
tdir=tempdir()
download.file(url,destfile=file.path(tdir,"temp.zip"))
unzip(file.path(tdir,"temp.zip"),exdir = tdir)
list.files(tdir)

# Reading the storm data 
storm_data <- read_sf(list.files(tdir,pattern=".shp",full.names = T))

# took groups help in this section 
#Wrangle the Data
(a2 <- as_tibble(storm_data))

storms <- storm_data %>%
  filter(year>= 1950) %>%
  mutate_if(is.numeric, function(x) ifelse(x==-999.0,NA,x)) %>%
  mutate(decade=(floor(year/10)*10))

region <- st_bbox(storms)

