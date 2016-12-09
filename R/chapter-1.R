#' House sales in Corvallis 2015
#'
#' Sales of houses in Corvallis, OR, USA in 2015 as provided by Benton County.
#'
#' This is a subset of all sales that:
#' \itemize{
#'   \item{occurred within a limited city bounding box: Latitude in (44.52538, 44.60366)
#'   Longitude in (-123.316845, -123.20698),}
#'   \item{had a sales price greater than $0,}
#'   \item{had a reported city of Corvallis, and}
#'   \item{had a reported address.}
#' }
#'
#' @format Data frame with 931 observations and 20 variables:
#' \describe{
#'  \item{lon, lat}{Longitude and latitude based on Geocoded address.}
#'  \item{price}{Sales price USD.}
#'  \item{finished_squarefeet}{Area of building that is finished (i.e. not garage) square feet.}
#'  \item{year_built}{Year building was built.}
#'  \item{date}{Date sale was recorded.}
#'  \item{address}{Street address.}
#'  \item{city, state, zip}{City, State and Zip code.}
#'  \item{acres}{Acres of land.}
#'  \item{num_dwellings}{Number of dwellings on property.}
#'  \item{class}{Class of property: Dwelling, Mobile Home, Commercial or RES Feature.}
#'  \item{condition}{Condition of property: "EX" = excellent, "AV" = average, "G" = good, "F" = fair, "VP" = very poor.}
#'  \item{total_squarefeet}{Area of building including unfinished space.}
#'  \item{bedrooms}{Number of bedrooms.}
#'  \item{full_baths}{Number of full bathrooms.}
#'  \item{half_baths}{Number of half bathrooms.}
#'  \item{month}{Month of sale.}
#'  \item{address_city}{Address used for geo-coding.}
#' }
#' @seealso \code{\link{ward_sales}}, \code{\link{preds}}
#' @source \url{https://www.co.benton.or.us/assessment/page/property-sales-data}
"sales"


#' Predicted prices for house sales in Corvallis
#'
#' Predicted sales price over a spatial grid for a sale that satisfies:
#' \itemize{
#'   \item{class = "Dwelling",}
#'   \item{bedrooms = 3,}
#'   \item{full_bathrooms = 2,}
#'   \item{finished_squarefeet = 1400,}
#'   \item{unfinished_squarefeet = 1800}
#' }
#'
#' The prediction is based on a regression model with linear terms for
#' \code{finished_squarefeet}, \code{class}, \code{bedrooms}, \code{full_baths},
#'  \code{half_baths}, \code{total_squarefeet} and \code{condition}, an
#'  interaction between \code{finished_squarefeet} and \code{class} and a smooth
#'   spatial term (using \code{mgcv::s()}).
#'
#' @format Data frame with 1600 rows and 3 variables:
#' \describe{
#'  \item{lon, lat}{Longitude and latitude or predicted sale.}
#'  \item{predicted_price}{Predicted sales price USD.}
#' }
#' @seealso \code{\link{sales}}, \code{\link{ward_sales}}
#' @source \url{https://www.co.benton.or.us/assessment/page/property-sales-data}
"preds"

#' Corvallis sales summarized at the ward level
#'
#' House sales in Corvallis summarized to the ward level.
#'
#' Wards describe roughly equal population subdivisions of the city that are each
#' represented by a councilor on the Corvallis City Council.  Sales are assigned
#' to each ward and then summarized. The sales included are those that satisfy:
#' \itemize{
#'   \item{had a sales price greater than $0,}
#'   \item{had a reported city of Corvallis, and}
#'   \item{had a reported address.}
#' }
#' (This is slightly more properties than in \code{sales} because there is
#' no bounding box restriction.)
#'
#' This dataset provides points on the boundaries of the wards and the relevant
#' summary statistics of the sales in each ward (i.e. enough to create a
#' choropleth plot of the wards).
#'
#' @format Data frame with 4189 rows and 8 variables:
#' \describe{
#'  \item{ward}{Ward number.}
#'  \item{lon, lat}{Longitude and latitude of a single point on a ward boundary.}
#'  \item{group, order}{The polygon group and order in which it should be drawn.}
#'  \item{num_sales}{The number of sales in this ward in 2015.}
#'  \item{avg_price}{The average sales price of properties in this ward in 2015.}
#'  \item{avg_finished_squarefeet}{The average finished square feet of sales in
#'    this ward in  2015}
#' }
#' @seealso \code{\link{sales}}, \code{\link{preds}}
#' @source \url{ftp://ftp.ci.corvallis.or.us/pw/gis/Published/Dynamic/Shapefile/Boundary.zip}
#' @source \url{https://www.co.benton.or.us/assessment/page/property-sales-data}
"ward_sales"
