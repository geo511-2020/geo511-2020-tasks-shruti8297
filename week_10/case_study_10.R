
# performed the task with groups help 

library(raster)
library(rasterVis)
library(rgdal)
library(ggmap)
library(tidyverse)
library(knitr)

# New Packages
library(ncdf4) # to import data from netcdf format

# Land use Land cover 
# Create afolder to hold the downloaded data
dir.create("data",showWarnings = F) #create a folder to hold the data

lulc_url="https://github.com/adammwilson/DataScienceData/blob/master/inst/extdata/appeears/MCD12Q1.051_aid0001.nc?raw=true"
lst_url="https://github.com/adammwilson/DataScienceData/blob/master/inst/extdata/appeears/MOD11A2.006_aid0001.nc?raw=true"

# download them
download.file(lulc_url,destfile="data/MCD12Q1.051_aid0001.nc", mode="wb")
download.file(lst_url,destfile="data/MOD11A2.006_aid0001.nc", mode="wb")

# loading data into R 

lulc=stack("data/MCD12Q1.051_aid0001.nc",varname="Land_Cover_Type_1")
lst=stack("data/MOD11A2.006_aid0001.nc",varname="LST_Day_1km")

# exploring lulc data 
lulc=lulc[[13]]
plot(lulc)

# process landcover data 

Land_Cover_Type_1 = c(
  Water = 0, 
  `Evergreen Needleleaf forest` = 1, 
  `Evergreen Broadleaf forest` = 2,
  `Deciduous Needleleaf forest` = 3, 
  `Deciduous Broadleaf forest` = 4,
  `Mixed forest` = 5, 
  `Closed shrublands` = 6,
  `Open shrublands` = 7,
  `Woody savannas` = 8, 
  Savannas = 9,
  Grasslands = 10,
  `Permanent wetlands` = 11, 
  Croplands = 12,
  `Urban & built-up` = 13,
  `Cropland/Natural vegetation mosaic` = 14, 
  `Snow & ice` = 15,
  `Barren/Sparsely vegetated` = 16, 
  Unclassified = 254,
  NoDataFill = 255)

lcd=data.frame(
  ID=Land_Cover_Type_1,
  landcover=names(Land_Cover_Type_1),
  col=c("#000080","#008000","#00FF00", "#99CC00","#99FF99", "#339966", "#993366", "#FFCC99", "#CCFFCC", "#FFCC00", "#FF9900", "#006699", "#FFFF00", "#FF0000", "#999966", "#FFFFFF", "#808080", "#000000", "#000000"),
  stringsAsFactors = F)
# colors from https://lpdaac.usgs.gov/about/news_archive/modisterra_land_cover_types_yearly_l3_global_005deg_cmg_mod12c1
kable(head(lcd))

# convert to raster (easy)
lulc=as.factor(lulc)

# update the RAT with a left join
levels(lulc)=left_join(levels(lulc)[[1]],lcd)

# plot it
gplot(lulc)+
  geom_raster(aes(fill=as.factor(value)))+
  scale_fill_manual(values=levels(lulc)[[1]]$col,
                    labels=levels(lulc)[[1]]$landcover,
                    name="Landcover Type")+
  coord_equal()+
  theme(legend.position = "bottom")+
  guides(fill=guide_legend(ncol=1,byrow=TRUE))

# plot land surface temperature 
plot(lst[[1:12]])

# convert lst to degrees c 
offs(lst)=-273.15
plot(lst[[1:10]])

# adding dates to z dimension 
names(lst)[1:5]
tdates=names(lst)%>%
  sub(pattern="X",replacement="")%>%
  as.Date("%Y.%m.%d")

names(lst)=1:nlayers(lst)
lst=setZ(lst,tdates)

# part 1 - Extract time series for a point 
lw <- SpatialPoints(data.frame(x= -78.791547,y=43.007211))
projection(lw) = "+proj=longlat"
lw_transform <- spTransform(lw, "+proj=longlat")
Extract <- raster::extract(lst, lw, buffer=1000,fun=mean,na.rm=T)
Transpose <- t(Extract)
Dates <- getZ(lst)
time_series <- bind_cols(Transpose, Dates)
t_series <- time_series %>%
  rename(y_col = ...1, x_col = ...2)
ggplot(t_series, aes(x = x_col, y = y_col)) +
  geom_point() +
  geom_smooth(method = 'loess', span =0.02) +
  labs(x = "date", y = "Monthly Mean Land Surafce Temperature")

# Part 2: Summarize weekly data to monthly climatologies 
tmonth <- as.numeric(format(getZ(lst),"%m"))
lst_month <- stackApply(x = lst, fun = mean, indices = tmonth)
names(lst_month)=month.name


gplot(lst_month) + geom_raster(aes(fill=value)) +
  scale_fill_gradientn(colours = c(low = "blue", mid = "grey", high = "red")) +
  facet_wrap(~variable)

# part 3 : 

lulc2 <- resample(lulc, lst, method = "ngb")
lcds1=cbind.data.frame(
  values(lst_month),
  ID=values(lulc2[[1]]))%>%
  na.omit()


my_data <- gather(lcds1, key='month',value='value',-ID) %>%
  mutate(ID = as.numeric(ID)) %>%
  mutate(month = factor(month, levels = month.name, ordered=T))

left <- left_join(my_data, lcd)
plot2 <- left %>% 
  filter(landcover%in%c("Urban & built-up","Deciduous Broadleaf forest"))















