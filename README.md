# geospatial

An R package with the data sets used in the DataCamp course [Working with Geospatial Data in R](https://www.datacamp.com/courses/working-with-geospatial-data-in-r).

## Installation

`geospatial` isn't on CRAN but you can get it with:

```R
# install.packages("devtools")
devtools::install_github("cwickham/geospatial")
```

## Usage

```R
library(geospatial)
?sales
head(sales)  # Chapter 1 sales data
```

## Contents

This package is currently under development, and so far only contains the data
sets listed below.

Chapter 1:

* `sales` - point data on sales in Corvallis
* `ward_sales` - sales summarized at the ward level
* `preds` - a grid of predictions over Corvallis

Chapter 2:

* `countries_sp`
* `countries_spdf`
* `tiny_countries_spdf`

Chapter 3:

* `pop`
* `pop_by_age`
* `prop_by_age`
* `migration`
* `land_cover` imported from `tmap`

## Data generation

If you are interested in how the data sets were constructed you'll find the
scripts in the `data-raw` directory.
