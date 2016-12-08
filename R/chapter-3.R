#' Population across North East USA
#'
#' Gridded population data obtained from NASA Socioeconomic Data and Applications  Center (SEDAC).  Population comes from the U.S. Census Grids (Summary File 1), 2000 subsetted to the North East of the U.S.A (latitude within (39, 43) and longitude within (-75, -69.5)).
#'
#' @format RasterLayer with 480 rows and 660 columns on one variable: \code{num_people}
#' the estimated absolute number of people living in the grid cell.
#' @seealso \code{\link{pop_by_age}}, \code{\link{prop_by_age}}
#' @source Seirup, L., and G. Yetman. 2006. U.S. Census Grids (Summary File 1), 2000. Palisades, NY: NASA Socioeconomic Data and Applications Center (SEDAC). \url{http://dx.doi.org/10.7927/H4B85623}. Accessed 7 12 2016.
#' @source \url{http://sedac.ciesin.columbia.edu/data/set/usgrid-summary-file1-2000}
"pop"

#' Population across North East USA by age group
#'
#' Gridded population data obtained from NASA Socioeconomic Data and Applications  Center (SEDAC).  Population comes from the U.S. Census Grids (Summary File 1), 2000  subsetted to the North East of the U.S.A (latitude within (39, 43) and longitude within (-75, -69.5)).
#'
#' @format RasterStack with 480 rows and 660 columns, and 7 layers:
#' \describe{
#'   \item{under_1}{estimated absolute number of people less than 1 year of age
#'     in the grid cell.}
#'   \item{age_1_4}{estimated absolute number of people between 1 and 4 years of
#'     age in the grid cell.}
#'   \item{age_5_17}{estimated absolute number of people between 5 and 17 years of
#'     age in the grid cell.}
#'   \item{age_18_24}{estimated absolute number of people between 18 and 24 years of
#'     age in the grid cell.}
#'   \item{age_25_64}{estimated absolute number of people between 24 and 64 years of
#'     age in the grid cell.}
#'   \item{age_65_79}{estimated absolute number of people between 65 and 79 years of
#'     age in the grid cell.}
#'   \item{age_80_over}{estimated absolute number of people over 80 years of age
#'     in the grid cell.}
#'   }
#' @seealso \code{\link{pop}}, \code{\link{prop_by_age}}
#' @source Seirup, L., and G. Yetman. 2006. U.S. Census Grids (Summary File 1), 2000. Palisades, NY: NASA Socioeconomic Data and Applications Center (SEDAC). \url{http://dx.doi.org/10.7927/H4B85623}. Accessed 7 12 2016.
#' @source \url{http://sedac.ciesin.columbia.edu/data/set/usgrid-summary-file1-2000}
"pop_by_age"

#' Population proportions across North East USA by age group
#'
#' Gridded population data obtained from NASA Socioeconomic Data and Applications Center (SEDAC).  Population comes from the U.S. Census Grids (Summary File 1), 2000 subsetted to the North East of the U.S.A (latitude within (39, 43) and longitude within (-75, -69.5)). Absolute counts for each age group were converted to proportions by dividing each age group count by the sum of the counts across age group, on a per grid cell basis.
#'
#' @format RasterStack with 480 rows and 660 columns, and 7 layers:
#' \describe{
#'   \item{under_1}{estimated proportion of people in grid cell that are less
#'     than 1 year of age.}
#'   \item{age_1_4}{estimated proportion of people in grid
#'     cell that are between 1 and 4 years of age in the grid cell.}
#'   \item{age_5_17}{estimated proportion of people in grid cell that are
#'     between 5 and 17 years of age in the grid cell.}
#'   \item{age_18_24}{estimated
#'     proportion of people in grid cell that are between 18 and 24 years of age
#'     in the grid cell.}
#'   \item{age_25_64}{estimated proportion of people in grid
#'     cell that are between 24 and 64 years of age in the grid cell.}
#'   \item{age_65_79}{estimated proportion of people in grid cell that are
#'     between 65 and 79 years of age in the grid cell.}
#'   \item{age_80_over}{estimated proportion of people in grid cell that are
#'     over 80 years of age in the grid cell.}
#'   }
#' @seealso \code{\link{pop}}, \code{\link{pop_by_age}}
#' @source Seirup, L., and G. Yetman. 2006. U.S. Census Grids (Summary File 1), 2000. Palisades, NY: NASA Socioeconomic Data and Applications Center (SEDAC). \url{http://dx.doi.org/10.7927/H4B85623}. Accessed 7 12 2016.
#' @source \url{http://sedac.ciesin.columbia.edu/data/set/usgrid-summary-file1-2000}
"prop_by_age"

#' U.S Net Migration
#'
#' Gridded estimates of migration between 1990 and 2000 from
#' NASA Socioeconomic Data and Applications Center (SEDAC).
#' The global data has been cropped to cover most of the contiguous US.
#'
#' @format RasterLayer with 49 rows and 116 columns on one variable:
#' \describe{
#'   \item{net_migration}{estimated number of people who left the grid
#'   cell between 1990 and 2000.}
#'   }
#' @source de Sherbinin, A., M. Levy, S. Adamo, K. MacManus, G. Yetman, V. Mara, L. Razafindrazay, B. Goodrich, T. Srebotnjak, C. Aichele, and L. Pistolesi. 2015. Global Estimated Net Migration Grids by Decade: 1970-2000. Palisades, NY: NASA Socioeconomic Data and Applications Center (SEDAC). \url{http://dx.doi.org/10.7927/H4319SVC}. Accessed 7 12 2016.
#' @source de Sherbinin, A., M. Levy, S. Adamo, K. MacManus, G. Yetman, V. Mara, L. Razafindrazay, B. Goodrich, T. Srebotnjak, C. Aichele, and L. Pistolesi. 2012. Migration and Risk: Net Migration in Marginal Ecosystems and Hazardous Areas. Environmental Research Letters 7(4): 045602. \url{http://iopscience.iop.org/1748-9326/7/4/045602}.
#' @source \url{http://sedac.ciesin.columbia.edu/data/set/popdynamics-global-est-net-migration-grids-1970-2000}
"migration"

#' Global Land Cover
#'
#' Data directly from the tmap package using \code{data(land, package = "tmap")}.
#' See \code{\link[tmap]{land}} for details, but note in particular that publication of these maps is only allowed when cited to Tateishi et al. (2014), and when "Geospatial Information Authority of Japan, Chiba University and collaborating organizations." is shown. See \url{http://www.iscgm.org/gm/glcnmo.html#use}."
#' @format An object of class SpatialGridDataFrame with 583200 cells and 4 variables.
#' @source tmap package \url{https://CRAN.R-project.org/package=tmap}
"land_cover"

