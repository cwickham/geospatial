#' Countries of the world SpatialPolygons object
#'
#' Polygons for countries of the world. The polygons come straight from
#' \code{rnaturalearth::ne_countries()}.
#'
#' @format SpatialPolygons object with 177 features.
#' @seealso \code{\link{countries_spdf}}, \code{\link{tiny_countries_spdf}}
#' @source \url{https://github.com/ropenscilabs/rnaturalearth}
#' @source \url{http://naturalearthdata.com}
"countries_sp"

#' Countries of the world SpatialPolygonsDataFrame object
#'
#' Polygons for countries of the world along with data on basic properties for
#' each country. The polygons and data come from
#' \code{rnaturalearth::ne_countries()}, with some minimal processing to select
#' and tidy some variables.
#'
#' @format SpatialPolygonsDataFrame object with 177 features and 6 variables:
#' \describe{
#'  \item{name}{Country name.}
#'  \item{iso_a3}{Three letter country code, see: \url{https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3}.}
#'  \item{population}{Population of country.}
#'  \item{gdp}{Gross domestic product of country.}
#'  \item{region}{Region, one of: Asia, Africa, Europe, Americas, Antarctica, Seven seas (open ocean), Oceania.}
#'  \item{subregion}{Sub-region.}
#' }
#' @seealso \code{\link{countries_sp}}, \code{\link{tiny_countries_spdf}}
#' @source \url{https://github.com/ropenscilabs/rnaturalearth}
#' @source \url{http://naturalearthdata.com}
"countries_spdf"

#' Tiny countries of the world SpatialPointsDataFrame object
#'
#' Not used in DataCamp course.  Countries that a small enough they should be
#' represented by points not polygons, along with data on basic properties for
#' each country. The polygons and data come from
#' \code{rnaturalearth::ne_tiny_countries()}, with some minimal processing to
#' select and tidy some variables.
#'
#' @format SpatialPointsDataFrame object with 37 features and 6 variables:
#' \describe{
#'  \item{name}{Country name.}
#'  \item{iso_a3}{Three letter country code, see: \url{https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3}.}
#'  \item{population}{Population of country.}
#'  \item{gdp}{Gross domestic product of country.}
#'  \item{region}{Region, one of: Asia, Africa, Europe, Americas, Antarctica, Seven seas (open ocean), Oceania.}
#'  \item{subregion}{Sub-region.}
#' }
#' @seealso \code{\link{countries_spdf}}, \code{\link{countries_sp}}
#' @source \url{https://github.com/ropenscilabs/rnaturalearth}
#' @source \url{http://naturalearthdata.com}
"tiny_countries_spdf"
