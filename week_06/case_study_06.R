library(raster)
library(sp)
library(spData)
library(tidyverse)
library(sf)
library(ggplot2)

data(world)  #load 'world' data from spData package
tmax_monthly <- getData(name = "worldclim", var="tmax", res=10)
library(ncdf4)
setwd('C:\\Users\\shrut\\Downloads')
data <- nc_open('absolute.nc')
