library(foreach)
library(lwgeom)
library(tidyverse)
library(spData)
library(doParallel)
library(dplyr)
library(sf)
library(mapview) 


registerDoParallel(4)
getDoParWorkers()
library(tidycensus)
census_api_key("d6ae3c670a71b562298f31f6a5c775153e90c872", install = TRUE)
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


fil_1 <- 
  foreach(r = unique(fil$variable), .combine='rbind') %dopar% {
    filter(fil, variable == r) %>%
      st_sample(size=.$value) %>%
      st_as_sf() %>%
      mutate(variable = r)
  }
mapview(bfil_1, zcol="variable", cex=1, lwd=0)

#worked with group 

