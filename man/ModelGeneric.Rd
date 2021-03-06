% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ModelGeneric.R
\docType{class}
\name{ModelGeneric}
\alias{ModelGeneric}
\title{Generic R6 class for modeling (fitting and predicting) P(A=a|W=w) where A can be a multivariate (A[1], ..., A[k]) and each A[i] can be binary, categorical or continous}
\format{An \code{\link{R6Class}} generator object}
\usage{
ModelGeneric
}
\description{
This R6 class Class for defining, fitting and predicting the probability model
 \code{P(A|W)} under \code{g_star} or under \code{g_0} for variables
 (\code{A,W}). Defines and manages the factorization of the multivariate conditional
 probability model \code{P(A=a|...)} into univariate regression models
 \code{A[j] ~ A[j-1] + ... + A[1] + W}. The class \code{self$new} method automatically
 figures out the correct joint probability factorization into univariate conditional
 probabilities based on name ordering provided by (\code{A_nms}, \code{W_nms}).
 When the outcome variable \code{A[j]} is binary, this class will automatically call
 a new instance of \code{ModelBinomial} class.
 Provide \code{self$fit()} function argument \code{data} as a \code{\link{DataStorageClass}} class object.
 This data will be used for fitting the model \code{P(A|W)}.
 Provide \code{self$fit()} function argument \code{newdata} (also as \code{DataStorageClass} class) for predictions of the type
 \code{P(A=1|W=w)}, where \code{w} values are coming from \code{newdata} object.
 Finally, provide \code{self$predictAeqa} function \code{newdata} argument
 (also \code{DataStorageClass} class object) for getting the likelihood predictions \code{P(A=sa|W=w)}, where
 both, \code{sa} and \code{sw} values are coming from \code{newdata} object.
}
\details{
\itemize{
\item{\code{n_regs}} - .
}
}
\section{Methods}{

\describe{
  \item{\code{new(reg, ...)}}{...}
  \item{\code{length}}{...}
  \item{\code{getPsAsW.models}}{...}
  \item{\code{getcumprodAeqa}}{...}
  \item{\code{copy.fit(ModelGeneric)}}{...}
  \item{\code{fit(data)}}{...}
  \item{\code{predict(newdata)}}{...}
  \item{\code{predictAeqa(newdata, ...)}}{...}
}
}

\section{Active Bindings}{

\describe{
  \item{\code{wipe.alldat}}{...}
}
}

\keyword{R6}
\keyword{class}
