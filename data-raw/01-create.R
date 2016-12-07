# Corvallis 2015 Sales Data
# https://www.co.benton.or.us/assessment/page/property-sales-data

# In particular: https://www.co.benton.or.us/sites/default/files/bc_assessor_sales/2015saleswithimpinfo.xls
library(readr)
library(dplyr)
library(readxl)

local <- "data-raw/corv-sales-2015.xls"
if(!file.exists(local)){
  download.file("https://www.co.benton.or.us/sites/default/files/bc_assessor_sales/2015saleswithimpinfo.xls", local)
}

sales <- read_excel(local, skip = 1)
bbox_map <- c(ll.lat = 44.5253890612624, ll.lon = -123.316845809937,
  ur.lat = 44.6036623073753, ur.lon = -123.206982528687)

# read and simplify sales data ---------------------------------------------

sales <- mutate(sales,
  price = parse_number(Consideration)
)

sales <- sales %>%
  select(Inst_Date, price, Situs_Addr1, Situs_City, Situs_State,
    Situs_Zip, Acres, `#Dwells`, Yr_Blt, `Improvement Class`,
    Condition, `Tot SF`, TotFinSF, BR, FBath, HBath)

sales <- sales %>% rename(
  date = Inst_Date,
  address = Situs_Addr1,
  city = Situs_City,
  state = Situs_State,
  zip = Situs_Zip,
  acres = Acres,
  num_dwellings = `#Dwells`,
  year_built = Yr_Blt,
  class = `Improvement Class`,
  condition = Condition,
  total_squarefeet = `Tot SF`,
  finished_squarefeet = `TotFinSF`,
  bedrooms = BR,
  full_baths = FBath,
  half_baths = HBath
)

sales_corv <- sales %>%
  filter(price > 0, city == "CORVALLIS",
    address != "UNASSIGNED")

sales_corv[sales_corv$year_built == 0, "year_built"] <- NA

sales_corv$month <- lubridate::month(sales_corv$date)

# geocode -----------------------------------------------------------------

sales_corv <- sales_corv %>%
  mutate(address_city = paste(address, city, state, sep = ", "))

# remove apt. #'s from addresses
sales_corv <- mutate(sales_corv,
  address_city = stringr::str_replace(address_city, "(GARAGE )?# ?[A-Z0-9]{1,3}", ""))

# may take some time
geocode_file <- "data-raw/corv-lon-lat.rds"
if(!file.exists(geocode_file) ){
  lon_lat <- ggmap::geocode(sales_corv$address_city)
  write_rds(lon_lat, geocode_file)
}

# TODO: Add checks so stop mismatches between sales and lon_lat
lon_lat <- read_rds(geocode_file)
sales_corv <- bind_cols(sales_corv, lon_lat)

# remove those that didn't geocode or bad geocodes
sales_corv <- filter(sales_corv, !is.na(lon), lon < -120)

sales <- sales_corv %>%
  filter(lon < bbox_map["ur.lon"], lon > bbox_map["ll.lon"],
    lat < bbox_map["ur.lat"], lat > bbox_map["ll.lat"]) %>%
  select(lon, lat, price, finished_squarefeet,
    year_built, everything())

devtools::use_data(sales, overwrite = TRUE)

# generate modelled raster data -------------------------------------------
library(mgcv)
library(modelr)

# model for home with > 0 finished squarefeet
# includes
#     * linear terms for:  finished_squarefeet, class, bedrooms, full_baths,
#         half_baths, total_squarefeet, condition
#     * interaction between finished_squarefeet and class
#     * smooth spatial term
sales_sub <- filter(sales_corv, finished_squarefeet > 0)

mod <- gam(price ~ finished_squarefeet*class +
    bedrooms + full_baths + half_baths + total_squarefeet +
    condition + s(lon, lat),
  data = sales_sub , na.action = na.exclude)

# predict price for:
# Dwelling, 3 bedroom, 2 bathroom, 1400 finished squareft + 200sqft garage
# at multiple locations

pred_grid <- data_grid(sales_sub,
  lon = seq(bbox_map["ll.lon"], bbox_map["ur.lon"], length.out = 40),
  lat = seq(bbox_map["ll.lat"], bbox_map["ur.lat"], length.out = 40),
  class = "Dwelling", condition = "AV",
  bedrooms = 3,
  full_baths = 2, half_baths = 0,
  finished_squarefeet = 1400, total_squarefeet = 1600)

pred_grid$preds <- predict(mod, pred_grid)

preds <- pred_grid %>%
  select(lon, lat, preds) %>%
  rename(predicted_price = preds)

devtools::use_data(preds)

# library(ggplot2)
# ggplot(pred_grid) +
#   geom_tile(aes(lon, lat, fill = preds), data = pred_grid, alpha = 0.8) +
#   scale_fill_distiller(palette = "YlGnBu")


# aggregate at the ward level ---------------------------------------------
# from: ftp://ftp.ci.corvallis.or.us/pw/gis/Published/Dynamic/Shapefile/Boundary.zip
library(rgdal)
library(sp)

if(!file.exists("data-raw/Boundary/Ward.shp")){
  base_path <- "data-raw/Boundary"
  download.file("ftp://ftp.ci.corvallis.or.us/pw/gis/Published/Dynamic/Shapefile/Boundary.zip", paste0(base_path, ".zip"))
  if(!dir.exists(base_path)) dir.create(base_path)
  unzip(paste0(base_path, ".zip"),
    files = paste0("Ward",
      c(".cpg", ".dbf", ".prj", ".sbn", ".sbx", ".shp", ".shp.xml", ".shx")),
    exdir = base_path)
  file.remove(paste0(base_path, ".zip"))
}

wards <- readOGR("data-raw/Boundary/", "Ward")

sales_sp <- SpatialPoints(sales_corv[, c("lon", "lat")],
  proj4string = CRS("+proj=longlat +ellps=WGS84"))

# needs transforming
coordinates(wards)
wards <- spTransform(wards, proj4string(sales_sp))

sales_sp$ward <- over(sales_sp, wards)$WARD

# library(tmap)
# ttm() # set to interactive
#
# tm_shape(wards) +
#   tm_borders() +
# tm_shape(sales_sp) +
#   tm_bubbles(col = "ward")

sales_corv$ward <- over(sales_sp, wards)$WARD

ward_sales <- sales_corv %>% group_by(ward) %>%
  summarise(
    num_sales = n(),
    avg_price = mean(price, na.rm = TRUE),
    avg_finished_squarefeet = mean(finished_squarefeet, na.rm = TRUE))

wards_sp <- sp::merge(wards, ward_sales, by.x = "WARD", by.y = "ward")

# library(tmap)
# ttm() # set to interactive
# tm_shape(wards_sp) +
#   tm_borders() +
#   tm_fill(col = "num_sales")

wards_df <- ggplot2::fortify(wards_sp)
wards_df$ward <- wards_sp$WARD[as.numeric(wards_df$id) + 1]

wards_df <- left_join(wards_df, ward_sales)

ward_sales <- wards_df %>%
  rename(lon = long) %>%
  select(ward, lon, lat, group, order, num_sales, avg_price, avg_finished_squarefeet)

devtools::use_data(ward_sales)

# library(ggplot2)
# qplot(long, lat, data = wards_df, group = group,
#   fill = ward, geom = "polygon")
#
# qplot(long, lat, data = wards_df, group = group,
#   fill = num_sales, geom = "polygon")
