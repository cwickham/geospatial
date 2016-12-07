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
