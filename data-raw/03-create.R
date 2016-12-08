# Chapter 3 Data Generation

library(raster)
library(readr)

# population --------------------------------------------------------------

# http://sedac.ciesin.columbia.edu/data/set/usgrid-summary-file1-2000/metadata
# Use Constraints:
#   Users are free to use, copy, distribute, transmit, and adapt the work for commercial and non-commercial purposes, without restriction, as long as clear attribution of the source is provided.

# TODO: codify this step to download if missing
total_pop <- raster("data-raw/census-grids/uspop300.tif")

# # get bounding box for smaller region
# states <- rnaturalearth::ne_states(country = "United States of America")
# ny_sp <- states[states$name == "New York", ]

# boston and nyc
ex <- extent(c(-75, -69.5, 39, 43))

total_pop <- crop(total_pop, ex)
names(total_pop) <- c("num_people")

pop <- total_pop

devtools::use_data(pop)

# library(tmap)
# tm_shape(total_pop) +
#   tm_raster()
#
# tm_shape(total_pop) +
#   tm_raster(style = "quantile")

# TODO: codify this step to download if missing
age_rasters <- purrr::map(
  paste0("data-raw/census-grids/usa", 1:7, "00.tif"),
  ~ raster(.))

age_rasters <- purrr::map(age_rasters, ~ crop(., ex))
age_stack <- do.call(stack, age_rasters)

names(age_stack) <- c("under_1", "age_1_4", "age_5_17", "age_18_24",
  "age_25_64", "age_65_79", "age_80_over")

# tm_shape(age_stack) +
#   tm_raster("age_1_4")

# convert to proportions
age_sum <- sum(age_stack)
age_prop_stack <- stack(age_stack / age_sum)

names(age_prop_stack) <- c("under_1", "age_1_4", "age_5_17", "age_18_24",
  "age_25_64", "age_65_79", "age_80_over")

# tm_shape(age_prop_stack) +
#   tm_raster(col = "age_18_24")
#
# tm_shape(age_prop_stack) +
#   tm_raster(col = c("age_18_24", "age_25_64"))
#
# tm_shape(age_prop_stack) +
#   tm_raster(col = c("under_1", "age_1_4", "age_5_17", "age_18_24",
#     "age_25_64", "age_65_79", "age_80_over"))
#

pop_by_age <- age_stack
prop_by_age <- age_prop_stack

devtools::use_data(pop_by_age)
devtools::use_data(prop_by_age)

# migration ---------------------------------------------------------------

# Global Migration Data
# de Sherbinin, A., M. Levy, S. Adamo, K. MacManus, G. Yetman, V. Mara, L. Razafindrazay, B. Goodrich, T. Srebotnjak, C. Aichele, and L. Pistolesi. 2015. Global Estimated Net Migration Grids by Decade: 1970-2000. Palisades, NY: NASA Socioeconomic Data and Applications Center (SEDAC). http://dx.doi.org/10.7927/H4319SVC. Accessed DAY MONTH YEAR.  ENW (EndNote & RefWorks)†
# RIS (Others) de Sherbinin, A., M. Levy, S. Adamo, K. MacManus, G. Yetman, V. Mara, L. Razafindrazay, B. Goodrich, T. Srebotnjak, C. Aichele, and L. Pistolesi. 2012. Migration and Risk: Net Migration in Marginal Ecosystems and Hazardous Areas. Environmental Research Letters 7(4): 045602. http://iopscience.iop.org/1748-9326/7/4/045602.
# Use Constraints:
#   Users are free to use, copy, distribute, transmit, and adapt the work for commercial and non-commercial purposes, without restriction, as long as clear attribution of the source is provided.

migration <- raster("data-raw/migration/halfdegree-net-migration-1990-2000.tif")

us_extent <- extent(c(-125.0011,-66.9326, 24.9493, 49.5904))
migration_us <- crop(migration, us_extent)
names(migration_us) <- "net_migration"

# library(tmap)
# tm_shape(migration_us) +
#   tm_raster(style = "quantile", n = 10)

migration <- migration_us
devtools::use_data(migration, overwrite = TRUE)


# grabbing land cover from tmap -------------------------------------------
data(land, package = "tmap")
land_cover <- land
use_data(land_cover)
