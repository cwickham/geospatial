#' Median Income in NYC census tracts
#'
#' Income data comes from the American Community Survey via the \code{acs} package. Specfically, the ACS 5-year estimates ending in 2014, for Table B19013: Median Household Income in the Past 12 Months (in 2014 Inflation-Adjusted Dollars), for tracts in New York County.
#'
#' @format data.frame with 288 rows and 6 variables:
#' \describe{
#'  \item{name}{Census tract name.}
#'  \item{state}{State.}
#'  \item{county}{County.}
#'  \item{tract}{Census tract ID.}
#'  \item{estimate}{Estimate of median income.}
#'  \item{se}{Standard error on the estimate of median income.}
#'   }
#' @seealso \code{\link{neighborhoods}}, \code{\link{water}}, \code{\link{income_grid}}
#' @source acs pacakge \url{https://CRAN.R-project.org/package=acs}
#' @source \url{https://www.census.gov/programs-surveys/acs/}
"nyc_income"

#' Water areas around NYC
#'
#' Polygons that describe areas of water in and around NYC.  Data come from a Open Street Map extract provided by Mapzen at \url{https://mapzen.com/documentation/metro-extracts/}.  The New York extract is cropped to the area of New York Country census tracts. Small water areas have been discarded.
#'
#' @format SpatialPolygonsDataFrame with 3508 features.  Each polygon describes an area of water.
#' @seealso \code{\link{neighborhoods}}, \code{\link{nyc_income}}, \code{\link{income_grid}}
#' @source Extract downloaded from: \url{https://mapzen.com/data/metro-extracts/metro/new-york_new-york/}
"water"

#' Neighborhoods of NYC
#'
#' New York City Neighborhood Tabulation Areas.
#'
#' @format SpatialPolygonsDataFrame with 195 features.  Each polygon describes an neighborhood tabulation area.
#' @seealso \code{\link{neighborhoods}}, \code{\link{water}}, \code{\link{income_grid}}
#' @source Shapefile downloaded from NYC Open Data: \url{https://www1.nyc.gov/site/planning/data-maps/open-data.page}
#' @examples
#' \dontrun{
#' # To emulate reading in a shapefile as in Exercise 2 in Chapter 4
#' # This creates the nynta_16c/ directory in your current working directory
#' # and contains the neccessary shapefiles.
#' rgdal::writeOGR(neighborhoods, "nynta_16c/", "nynta", driver="ESRI Shapefile")
#' }
"neighborhoods"

#' Gridded income in New York
#'
#' Gridded median income for New York. Data obtained from NASA Socioeconomic Data and Applications  Center (SEDAC).  Median income comes from the U.S. Census Grids (Summary File 3: Metropolitan Statistical Areas, v1 (2000)) for New York--Northern New Jersey--Long Island, NY--NJ--CT--PA CMSA.
#'
#' @format SpatialGridDataFrame with 1920 rows and 2400 columns.
#' @seealso \code{\link{neighborhoods}}, \code{\link{nyc_income}}, \code{\link{water}}
#' @source Seirup, L., and G. Yetman. 2006. U.S. Census Grids (Summary File 3), 2000: Metropolitan Statistical Areas. Palisades, NY: NASA Socioeconomic Data and Applications Center (SEDAC). \url{http://dx.doi.org/10.7927/H4Z31WJ0.}
#' @source \url{http://sedac.ciesin.columbia.edu/data/set/usgrid-summary-file3-2000-msa}
#' @examples
#' \dontrun{
#' # To emulate reading in a raster file as in Exercise 3 in Chapter 4
#' # This creates the nyc_grid_data/ directory in your current working directory
#' # and contains the neccessary raster file.
#' dir.create("nyc_grid_data")
#' rgdal::writeGDAL(income_grid, "nyc_grid_data/m5602ahhi00.tif", drivername = "GTiff")
#' }
"income_grid"
