Case Study 06
================
Your Name
August 1, 2020

\#case stydy 06 library(raster) library(sp) library(spData)
library(tidyverse) library(sf) library(ncdf4) \# Data Download
download.file(“<https://crudata.uea.ac.uk/cru/data/temperature/absolute.nc>”,“absolute.nc”)
tmean=raster(“absolute.nc”) plot(tmean) \# World Filter data(world)
\#load ‘world’ data from spData package data\_poly \<- world %\>%
filter(continent \!= ‘Antarctica’) sp\_world \<- as(data\_poly,
‘Spatial’) plot(sp\_world)

\#Prep Climate Data TempC \<- raster::extract(tmean, sp\_world, fun =
max, na.rm = 1, smal = 1, sp = 1) TempC\_sf \<- st\_as\_sf(TempC)
TempC\_sf \# Plot Final\_plot \<- ggplot() + geom\_sf(data = TempC\_sf,
aes(fill =
TempC\_sf$CRU\_Global\_1961.1990\_Mean\_Monthly\_Surface\_Temperature\_Climatology))
+ scale\_fill\_viridis\_c(name=“Annual(C)”) + theme(legend.position =
‘bottom’) \# Communicate the Results library(dplyr) \#view(TempC\_sf)
Results \<- TempC\_sf %\>% group\_by(continent) %\>%
arrange(desc(CRU\_Global\_1961.1990\_Mean\_Monthly\_Surface\_Temperature\_Climatology))

\#Worked with group to figure the final results table out

Results\_table \<- Results %\>% top\_n(1,
CRU\_Global\_1961.1990\_Mean\_Monthly\_Surface\_Temperature\_Climatology)

Final\_Results\_Table \<- Results\_table %\>% st\_set\_geometry(NULL)
%\>% select(‘name\_long’, ‘continent’,
‘CRU\_Global\_1961.1990\_Mean\_Monthly\_Surface\_Temperature\_Climatology’)
view(Final\_Results\_Table)
