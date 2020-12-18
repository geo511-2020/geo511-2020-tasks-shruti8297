library(foreach)
library(lwgeom)
library(tidyverse)
library(spData)
library(doParallel)
library(dplyr)
library(sf)
library(mapview) 
#worked with group  

registerDoParallel(4)
getDoParWorkers()
library(tidycensus)


census_api_key("a83bf6cd5f61481c976b1097d8e3a00a9c497c09", install = TRUE, overwrite=TRUE)
racevars <- c(White = "P005003", 
              Black = "P005004", 
              Asian = "P005006", 
              Hispanic = "P004003")

options(tigris_use_cache = TRUE)
erie <- get_decennial(geography = "block", variables = racevars, 
                      state = "NY", county = "Erie County", geometry = TRUE,
                      summary_var = "P001001", cache_table=T)

points <- c(xmin=-78.9,xmax=-78.85,ymin=42.888,ymax=42.92)
fil <- st_crop(erie, points)


# help from zaque in this section 

var <- as.factor(fil$variable)

points <- foreach(i = 1:4, .combine='rbind') %dopar% {
  races <- levels(var)[i]
  fil %>%
    filter(variable == races) %>%
    st_sample(size = .$value) %>%
    st_as_sf() %>%
    mutate(variable = races)
} 





plot <- mapview(points, zcol = "variable", cex = 1, lwd=0) 
plot



