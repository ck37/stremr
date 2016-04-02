#' Estimate the Survival of Intervention on Exposures and MONITORing Process for Right Censored Longitudinal Data.
#'
#' The \pkg{estimtr} R package is a tool for estimation of causal survival curve under various user-specified interventions
#' (e.g., static, dynamic, deterministic, or stochastic).
#' In particular, the interventions may represent exposures to treatment regimens, the occurrence or non-occurrence of right-censoring
#' events, or of clinical monitoring events. \pkg{estimtr} enables estimation of a selected set of the user-specified causal quantities of interest,
#' such as, treatment-specific survival curves and the average risk difference over time.
#'
#' @section Documentation:
#' \itemize{
#' \item To see the package vignette use: \code{vignette("estimtr_vignette", package="estimtr")}
#' \item To see all available package documentation use: \code{help(package = 'estimtr')}
#' }
#'
#' @section Routines:
#' The following routines will be generally invoked by a user, in the same order as presented below.
#' \describe{
#' \item{\code{\link{estimtr}}}{One function for performing estimation}
#' }
#'
#' @section Data structures:
#' The following most common types of output are produced by the package:
#' \itemize{
#' \item \emph{observed data} - input data.frame in long format (repeated measures over time).
#' }
#'
#' @section Updates:
#' Check for updates and report bugs at \url{http://github.com/osofr/estimtr}.
#'
#' @docType package
#' @name estimtr
#'
NULL







