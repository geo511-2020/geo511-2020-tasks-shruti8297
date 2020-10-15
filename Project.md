Statistical Comparision of NASA-TROPOMI - Satellite and GEOS-CF - Model
Data
================
Shruti Jagini
October 15, 2020

# INTRODUCTION

### PROJECT GOAL:

The project is about statistical comparison of satellite data
(NASA-TROPOMI), and model data (GEOS-CF) with respect to NO<sub>2</sub>
concentrations emitted from California wildfires. Since GEOS-CF model
works on reactions and equations, the goal of the project is to
determine how closely is the model data related with satellite data.

### NASA-TROPOMI

The TROPOspheric Monitoring Instrument (TROPOMI) is a satellite
instrument which is on board the Copernicus Sentinel-5 Precursor
satellite. The Sentinel-5 Precursor (S5P) is the first of the
atmospheric composition Sentinels, launched on 13 October 2017 by the
European Space Agency (ESA), planned for a mission of seven years.This
instrument has a nadir-viewing 108-degree Field-of-View push-broom
grating hyperspectral spectrometer which covers the wavelength of
ultraviolet-visible (270 nm to 495 nm), near infrared region (675 nm to
775 nm), and shortwave infrared (2305 nm - 2385 nm). It has a swath of
2600 km, a repeat cycle of 16 days and a desired lifetime of 7 years.
The Sentinel-5P is the first of the Atmospheric Composition Sentinels,
it provides measurements on concentrations of various pollutants and
components of atmosphere like ozone, NO<sub>2</sub>, SO<sub>2</sub>,
CH<sub>4</sub>, CO, formaldehyde, aerosols and clouds \[1\].

### GEOS-CF

The GEOS-Chem is a global 3-D model which is used for monitoring
atmospheric chemistry, it is driven by assimilated meteorological
observations from the Goddard Earth Observing System (GEOS) of the NASA
Global Modeling Assimilation Office (GMAO). It is developed and used by
research groups worldwide as an advantageous tool for application to a
wide range of atmospheric composition problems. The GEOS-CF model is a
part of GEOS-Chem, this model gives a 3-dimensional distribution of
atmospheric compositions. This model takes into account about 220
reactive species and 720 reactions. GEOS-CF works by taking into account
atmospheric dynamics such as wind speed and chemistry of pollutants
(such as their chemical reactions, dispersion, reactivity) in predicting
their concentrations \[2\].

### FIRE DATA

In order to have a better understanding on the days where fires were
significant, the MODIS tool is used. This helps us in detecting the
location and time of fires all over the world.

# DATA SOURCES

  - NASA-TROPOMI data for NO<sub>2</sub> is obtained from [GES-DISC
    Website](https://disc.gsfc.nasa.gov/)
  - GEOS-CF model data for NO<sub>2</sub> is obtained from [GEOS-CF
    Website](https://portal.nccs.nasa.gov/datashare/gmao/geos-cf/v1/das/)
  - Wildfire data can be accessed from the [MODIS
    Website](https://firms.modaps.eosdis.nasa.gov/download/) and from
    the [World View Website](https://worldview.earthdata.nasa.gov/)

# METHODS

| Tools Used           | Description                                                                       | Package                                                                                              |
| -------------------- | --------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------- |
| Data Conversion      | Converting the satellite into a proper form for comparison with the model data    | library(lubridate) - Converts into manageable date formats.                                          |
| Data Interpolation   | Interpolating the model data at satellite locations for better understanding      | interpp() - point wise interpolates irregular gridded data.                                          |
| Data Visualization   | Plotting satellite and interpolated model data to have a better understanding     | library(sf), library(raster), library(ggplot2) - Helps in managing and visualization of raster data. |
| Statistical Analysis | Using tools like regression models, bias and error calculations for data analysis |                                                                                                      |

# PLOTS

![Distribution of Wildfires in North America in August 2018
\[3\]](https://github.com/geo511-2020/geo511-2020-tasks-shruti8297/blob/master/image.png)

# RESULTS

Results from this project would be represented in the form of plots
(spatial maps) which show regions where wildfires have occurred ans also
distribution of NO<sub>2</sub> concentration (predicted and actual).
Results from statistical analysis would be in the form of regression
plots, and error analysis plots.

1.  Zeng, Jian, Vollmer Bruce E, Ostrenga, Dana M. Gerasimov, Irina V,
    Air Quality Satellite Monitoring by TROPOMI on Sentinel-5P, 2018,
    NASA Goddard Space Flight Center.

2.  NASA-GEOS-CF Retrieved from
    <https://gmao.gsfc.nasa.gov/weather_prediction/GEOS-CF/>.

3.  [NASA-WORLD VIEW](https://worldview.earthdata.nasa.gov/)
