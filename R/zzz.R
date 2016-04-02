
#-----------------------------------------------------------------------------
# Global State Vars (can be controlled globally with options(estimtr.optname = ))
#-----------------------------------------------------------------------------
gvars <- new.env(parent = emptyenv())
gvars$verbose <- FALSE      # verbose mode (print all messages)
gvars$opts <- list()        # named list of package options that is controllable by the user (estimtr_options())
gvars$misval <- NA_integer_ # the default missing value for observations (# gvars$misval <- -.Machine$integer.max)
gvars$misXreplace <- 0L     # the default replacement value for misval that appear in the design matrix
gvars$tolerr <- 10^-12      # tolerance error: assume for abs(a-b) < gvars$tolerr => a = b
gvars$sVartypes <- list(bin = "binary", cat = "categor", cont = "contin")

getopt <- function(optname) {
  opt <- gvars$opts
  if (!(optname %in% (names(opt)))) stop(optname %+% ": this options does not exist")
  return(opt[[optname]])
}

#' Print Current Option Settings for \code{estimtr}
#' @return Invisibly returns a list of \code{estimtr} options.
#' @seealso \code{\link{estimtr_options}}
#' @export
print_estimtr_opts <- function() {
  print(gvars$opts)
  invisible(gvars$opts)
}

#' Setting Options for \code{estimtr}
#'
#' Additional options that control the estimation algorithm in \code{estimtr} package
#' @param useglm Set to \code{FALSE} to estimate with \code{\link[speedglm]{speedglm.wfit}} and \code{TRUE} for
#' \code{\link[stats]{glm.fit}}.
#' @param bin.method The method for choosing bins when discretizing and fitting the conditional continuous summary
#'  exposure variable \code{sA}. The default method is \code{"equal.len"}, which partitions the range of \code{sA}
#'  into equal length \code{nbins} intervals. Method \code{"equal.mass"} results in a data-adaptive selection of the bins
#'  based on equal mass (equal number of observations), i.e., each bin is defined so that it contains an approximately
#'  the same number of observations across all bins. The maximum number of observations in each bin is controlled
#'  by parameter \code{maxNperBin}. Method \code{"dhist"} uses a mix of the above two approaches,
#'  see Denby and Mallows "Variations on the Histogram" (2009) for more detail.
#' @param parfit Default is \code{FALSE}. Set to \code{TRUE} to use \code{foreach} package and its functions
#'  \code{foreach} and \code{dopar} to perform
#'  parallel logistic regression fits and predictions for discretized continuous outcomes. This functionality
#'  requires registering a parallel backend prior to running \code{estimtr} function, e.g.,
#'  using \code{doParallel} R package and running \code{registerDoParallel(cores = ncores)} for integer
#'  \code{ncores} parallel jobs. For an example, see a test in "./tests/RUnit/RUnit_tests_04_netcont_sA_tests.R".
#' @param nbins Set the default number of bins when discretizing a continous outcome variable under setting
#'  \code{bin.method = "equal.len"}.
#'  If left as \code{NA} the total number of equal intervals (bins) is determined by the nearest integer of
#'  \code{nobs}/\code{maxNperBin}, where \code{nobs} is the total number of observations in the input data.
#' @param maxncats Max number of unique categories a categorical variable \code{sA[j]} can have.
#' If \code{sA[j]} has more it is automatically considered continuous.
#' @param poolContinVar Set to \code{TRUE} for fitting a pooled regression which pools bin indicators across all bins.
#' When fitting a model for binirized continuous outcome, set to \code{TRUE}
#' for pooling bin indicators across several bins into one outcome regression?
#' @param maxNperBin Max number of observations per 1 bin for a continuous outcome (applies directly when
#'  \code{bin.method="equal.mass"} and indirectly when \code{bin.method="equal.len"}, but \code{nbins = NA}).
#' @return Invisibly returns a list with old option settings.
#' @seealso \code{\link{print_estimtr_opts}}
#' @export
estimtr_options <- function(useglm = FALSE,
                            parfit = FALSE,
                            bin.method = c("equal.len", "equal.mass", "dhist"),
                            nbins = NA,
                            maxncats = 20,
                            poolContinVar = FALSE,
                            maxNperBin = 1000
                            ) {

  old.opts <- gvars$opts
  bin.method <- bin.method[1L]

  if (bin.method %in% "equal.len") {
  } else if (bin.method %in% "equal.mass") {
  } else if (bin.method %in% "dhist") {
  } else {
    stop("bin.method argument must be either 'equal.len', 'equal.mass' or 'dhist'")
  }

  opts <- list(
    useglm = useglm,
    bin.method = bin.method,
    parfit = parfit,
    nbins = nbins,
    maxncats = maxncats,
    poolContinVar = poolContinVar,
    maxNperBin = maxNperBin
  )
  gvars$opts <- opts
  invisible(old.opts)
}

# returns a function (alternatively a call) that tests for missing values in (sA, sW)
testmisfun <- function() {
  if (is.na(gvars$misval)) {
    return(is.na)
  } else if (is.null(gvars$misval)){
    return(is.null)
  } else if (is.integer(gvars$misval)) {
    return(function(x) {x==gvars$misval})
  } else {
    return(function(x) {x%in%gvars$misval})
  }
}

get.misval <- function() {
  gvars$misfun <- testmisfun()
  gvars$misval
}

set.misval <- function(gvars, newmisval) {
  oldmisval <- gvars$misval
  gvars$misval <- newmisval
  gvars$misfun <- testmisfun()    # EVERYTIME gvars$misval HAS CHANGED THIS NEEDS TO BE RESET/RERUN.
  invisible(oldmisval)
}
gvars$misfun <- testmisfun()

# Allows estimtr functions to use e.g., getOption("estimtr.verbose") to get verbose printing status
.onLoad <- function(libname, pkgname) {
  op <- options()
  op.estimtr <- list(
    estimtr.verbose = gvars$verbose
  )
  # reset all options to their defaults on load:
  estimtr_options()

  toset <- !(names(op.estimtr) %in% names(op))
  if(any(toset)) options(op.estimtr[toset])

  invisible()
}

# Runs when attached to search() path such as by library() or require()
.onAttach <- function(...) {
  if (interactive()) {
  	packageStartupMessage('estimtr')
  	packageStartupMessage('Version: ', utils::packageDescription('estimtr')$Version)
  	packageStartupMessage('Package created on ', utils::packageDescription('estimtr')$Date, '\n')
  	packageStartupMessage('Please note this package is still in its early stages of development. Check for updates and report bugs at http://github.com/osofr/estimtr.', '\n')
  	packageStartupMessage('To see the vignette use vignette("estimtr_vignette", package="estimtr"). To see all available package documentation use help(package = "estimtr") and ?estimtr.', '\n')
  	packageStartupMessage('To see the latest updates for this version, use news(package = "estimtr").', '\n')
  }
}

# Runs when loaded but not attached to search() path; e.g., when a package just Imports (not Depends on) estimtr
.onLoad <- function(libname, pkgname) {
    # Set estimtr package options, # estimtr.<argument name>
    opts = c("estimtr.verbose"="TRUE"
            )
    for (i in setdiff(names(opts),names(options()))) {
        eval(parse(text=paste("options(",i,"=",opts[i],")",sep="")))
    }
    invisible()
}

# .onUnload <- function(libpath) {
# }