# Chapter 2 - Data Generation

library(sp)
library(rnaturalearth)
library(dplyr)

ne_world <- ne_countries()

# clean up data frame, but don't mess with order!
world_df <- ne_world@data

world_df <- world_df %>%
  select(
    name, iso_a3, pop_est, gdp_md_est, region_un, subregion) %>%
  mutate_all(as.character) %>%
  mutate_at(c("pop_est", "gdp_md_est"), as.numeric) %>%
  mutate_at(c("pop_est", "gdp_md_est"), function(x) na_if(x, -99))  %>%
  rename(population = pop_est, gdp = gdp_md_est, region = region_un)

ne_world@data <- world_df

# to avoid boundary issue in tmap_save to html
ne_world <- raster::crop(ne_world, raster::extent(-180, 180, -89.9999, 89.9999))
summary(ne_world)

# same for tiny countries
ne_tiny <- ne_countries(type = "tiny_countries")
tiny_df <- ne_tiny@data

tiny_df <- tiny_df %>%
  select(
    name, iso_a3, pop_est, gdp_md_est, region_un, subregion) %>%
  mutate_all(as.character) %>%
  mutate_at(c("pop_est", "gdp_md_est"), as.numeric) %>%
  mutate_at(c("pop_est", "gdp_md_est"), function(x) na_if(x, -99))%>%
  rename(population = pop_est, gdp = gdp_md_est, region = region_un)

ne_tiny@data <- tiny_df
summary(ne_tiny)

countries_sp <- geometry(ne_world)
countries_spdf <- ne_world
tiny_countries_spdf <- ne_tiny

devtools::use_data(countries_sp, overwrite = TRUE)
devtools::use_data(countries_spdf, overwrite = TRUE)
devtools::use_data(tiny_countries_spdf, overwrite = TRUE)
