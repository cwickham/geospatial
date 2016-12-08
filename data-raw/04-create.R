# Chapter 4 - Data Generation

library(readr)
library(dplyr)
library(raster)
library(tigris)
library(rgeos)
library(rgdal)

# median income from acs --------------------------------------------------

library(acs)

# look for table number at http://factfinder.census.gov/faces/nav/jsf/pages/searchresults.xhtml?refresh=t
# all tracts in new york
nyc_acs <- acs.fetch(endyear = 2014, span = 5,
  geography = geo.make(state = "NY", county = "New York", tract = "*"),
  table.number = "B19013")
# "B19013. Median Household Income in the Past 12 Months (in 2014 Inflation-Adjusted
# Dollars)"

nyc_income <- bind_cols(nyc_acs@geography,
  as.data.frame(nyc_acs@estimate),
  as.data.frame(nyc_acs@standard.error))

names(nyc_income) <- c("name", "state", "county", "tract", "estimate", "se")

devtools::use_data(nyc_income, overwrite = TRUE)


# water areas  ------------------------------------------------------------
nyc_tracts <- tracts(state = "NY", county = "New York", cb = TRUE)

# download shape file if it doesn't exist
# it is 144MB, so it will take some time!
local_water <- "data-raw/nywater"
if(!dir.exists(local_water)){
  download.file("https://s3.amazonaws.com/metro-extracts.mapzen.com/new-york_new-york.imposm-shapefiles.zip", paste0(local_water, ".zip"))
  dir.create(local_water)
  unzip(paste0(local_water, ".zip"),
    files = paste0("new-york_new-york_osm_waterareas",
      c(".dbf", ".prj", ".shp", ".shx")),
    exdir = local_water)
  file.remove(paste0(local_water, ".zip"))
}

water <- readOGR(local_water, "new-york_new-york_osm_waterareas")

# crop to census tract extent
water_tr <- spTransform(water, proj4string(nyc_tracts))
water_crop <- crop(water_tr, extent(nyc_tracts))

# drop small areas
water_big <- water_crop[water_crop$area > 1e-5, ]
water <- water_big

devtools::use_data(water, overwrite = TRUE)

# Neighborhood data -----------------------------------------------------
# from https://www1.nyc.gov/site/planning/data-maps/open-data/dwn-nynta.page

remote <- "https://www1.nyc.gov/assets/planning/download/zip/data-maps/open-data/nynta_16c.zip"

# download shape file if it doesn't exist
local_neigh <- "data-raw/nynta_16c"
if(!dir.exists(local_neigh)){
  download.file("https://www1.nyc.gov/assets/planning/download/zip/data-maps/open-data/nynta_16c.zip",
    paste0(local_neigh, ".zip"))
  unzip(paste0(local_neigh, ".zip"), junkpaths = TRUE,
    exdir = local_neigh)
  file.remove(paste0(local_neigh, ".zip"))
}

neighborhoods <- readOGR(local_neigh, "nynta")

devtools::use_data(neighborhoods)

# census grid -------------------------------------------------------------

# codify to make more reproducible
income_grid <- rgdal::readGDAL("data-raw/nyc_grid_data/m5602ahhi00.tif")
devtools::use_data(income_grid)

