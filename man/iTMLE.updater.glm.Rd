% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/TMLE_updaters.R
\name{iTMLE.updater.glm}
\alias{iTMLE.updater.glm}
\alias{predict.iTMLE.updater.glm}
\title{iTMLE glm learner / updater}
\usage{
iTMLE.updater.glm(Y, X, newX, family, obsWeights, ...)

\method{predict}{iTMLE.updater.glm}(object, newdata, offset, ...)
}
\arguments{
\item{Y}{Input outcomes}

\item{X}{Input design matrix with training data.
Must contain a column named "offset", which contains the offsets converted to logit-linear scale.}

\item{newX}{Input design matrix with test data.
Same requirement as for \code{X}: must contain a column named "offset",
which contains the offsets converted to logit-linear scale.}

\item{family}{Link function (ignored).}

\item{obsWeights}{Row-specific weights}

\item{...}{Additional arguments to be passed on to \code{origami} package.}

\item{object}{Results of calling \code{iTMLE.updater.glm}.}

\item{newdata}{Design matrix with test data for which predictions should be obtained.
May contain a column named "offset", instead of it being passed as a separate argument.}

\item{offset}{Offset (on logit scale if using logistic regression update).}
}
\description{
Performs an SDR update using a main-terms GLM (logistic regression with \code{stats::glm}).
This function is passed along as a separate learner
to the SuperLearner implementation in \code{origami} package
}
