estimtr
==========

[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/estimtr)](http://cran.r-project.org/package=estimtr)
[![](http://cranlogs.r-pkg.org/badges/estimtr)](http://cran.rstudio.com/web/packages/estimtr/index.html)
[![Travis-CI Build Status](https://travis-ci.org/osofr/estimtr.svg?branch=master)](https://travis-ci.org/osofr/estimtr)
[![Coverage Status](https://coveralls.io/repos/osofr/estimtr/badge.svg?branch=master&service=github)](https://coveralls.io/github/osofr/estimtr?branch=master)

The `estimtr` R package implementes the Inverse Probability Weighted Estimator (IPTW) of the causal survival hazard function for longitudinal right-censored data. The user-specified interventions on time-varying exposures and monitoring variables can be either stochastic, dynamic or static. The exposure, monitoring and censoring can be binary, categorical or multivariate (e.g., can use more than one column of dummy indicators for different censoring events or can code such censoring events with a single categorical censoring variable). The output includes the estimated survival curve, which is obtained as a mapping from the estimated discrete hazard function. When several interventions for exposure/monitoring are specified, the package will produce one survivial estimate for each intervention. The input data needs to be in long format, with a specific **fixed** temporal ordering of the variables (see documentation in `?estimtr` for additional details.

### Installation

<!-- To install the CRAN release version of `estimtr`: 

```R
install.packages('estimtr')
```
 -->

To install the development version (requires the `devtools` package):

```R
devtools::install_github('osofr/estimtr', build_vignettes = FALSE)
```

### Documentation

...
<!-- Once the package is installed, see the [vignette](http://cran.r-project.org/web/packages/estimtr/vignettes/estimtr_vignette.pdf), consult the internal package documentation and examples. 

* To see the vignette in R:

```R
vignette("estimtr_vignette", package="estimtr")
```

* To see all available package documentation:

```R
?estimtr
help(package = 'estimtr')
```

* To see the latest updates for the currently installed version of the package:

```r
news(package = "estimtr")
```
 -->

### Brief overview

....
<!-- Below is an example simulating data with 4 covariates specified by 4 structural equations (nodes). New equations are added by using successive calls to `+ node()` function and data are simulated by calling `sim` function:

```R
library(estimtr)
D <- DAG.empty() + 
  node("CVD", distr="rcategor.int", probs = c(0.5, 0.25, 0.25)) +
  node("A1C", distr="rnorm", mean = 5 + (CVD > 1)*10 + (CVD > 2)*5) +
  node("TI", distr="rbern", prob = plogis(-0.5 - 0.3*CVD + 0.2*A1C)) +
  node("Y", distr="rbern", prob = plogis(-3 + 1.2*TI + 0.1*CVD + 0.3*A1C))
D <- set.DAG(D)
dat <- sim(D,n=200)
```

To display the above SEM object as a directed acyclic graph:

```R
plotDAG(D)
```

To allow the above nodes `A1C`, `TI` and `Y` to change over time, for time points t = 0,...,7, and keeping `CVD` the same, simply add `t` argument to `node` function and use the square bracket `[...]` vector indexing to reference time-varying nodes inside the `node` function expressions:

```R
library(estimtr)
D <- DAG.empty() + 
  node("CVD", distr="rcategor.int", probs = c(0.5, 0.25, 0.25)) +
  node("A1C", t=0, distr="rnorm", mean=5 + (CVD > 1)*10 + (CVD > 2)*5) + 
  node("TI", t=0, distr="rbern", prob=plogis(-5 - 0.3*CVD + 0.5*A1C[t])) +

  node("A1C", t=1:7, distr="rnorm", mean=-TI[t-1]*10 + 5 + (CVD > 1)*10 + (CVD > 2)*5) +
  node("TI", t=1:7, distr="rbern", prob=plogis(-5 - 0.3*CVD + 0.5*A1C[t] + 1.5*TI[t-1])) +
  node("Y", t=0:7, distr="rbern", prob=plogis(-6 - 1.2*TI[t] + 0.1*CVD + 0.3*A1C[t]), EFU=TRUE)
D <- set.DAG(D)
dat.long <- sim(D,n=200)
```

The `+ action` function allows defining counterfactual data under various interventions (e.g., static, dynamic, deterministic, or stochastic), which can be then simulated by calling `sim` function. In particular, the interventions may represent exposures to treatment regimens, the occurrence or non-occurrence of right-censoring events, or of clinical monitoring events.

In addition, the functions `set.targetE`, `set.targetMSM` and `eval.target` provide tools for defining and computing a few selected features of the distribution of the counterfactual data that represent common causal quantities of interest, such as, treatment-specific means, the average treatment effects and coefficients from working marginal structural models. 
 -->

### Citation

...
<!-- To cite `estimtr` in publications, please use:
> Sofrygin O, van der Laan MJ, Neugebauer R (2015). *estimtr: Simulating Longitudinal Data with Causal Inference Applications.* R package version 0.1.
 -->

### Funding

...
<!-- The development of this package was partially funded through internal operational funds provided by the Kaiser Permanente Center for Effectiveness & Safety Research (CESR). This work was also partially supported through a Patient-Centered Outcomes Research Institute (PCORI) Award (ME-1403-12506) and an NIH grant (R01 AI074345-07).
 -->

### Copyright
This software is distributed under the GPL-2 license.
