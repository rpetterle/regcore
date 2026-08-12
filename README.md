# unitcore: Core Generic Functions for Unit Interval Regression Packages <img src="man/figures/Logo2.png" align="right" width="309" />

<!-- badges: start -->
[![R-CMD-check](https://github.com/rpetterle/unitcore/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/rpetterle/unitcore/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

**unitcore** provides the foundational infrastructure and S3 generic functions for a suite of R packages dedicated to regression modeling of continuous bounded responses (such as `unitregTMB`, `betamodal`, and `uigTMB`). 

By centralizing these generic methods, `unitcore` ensures a consistent, standardized user interface and seamless interoperability across different modeling frameworks for unit interval data, whether working with mean, quantile, or modal regression.

## Provided S3 Generics

This package exports a set of generic functions that downstream packages implement. They are categorized into four main areas:

### 1. Model Selection & Comparison
* **`vuong_test()`**: Performs the Vuong test to rigorously compare two non-nested competing models.
* **`pairwise_vuong_test()`**: Conducts pairwise Vuong tests across multiple competing models.
* **`stepCriterion()`**: Performs stepwise variable selection based on information criteria.

### 2. Model Summaries & Extraction
* **`extract_equations()`**: Extracts the full mathematical equations from fitted models (useful for generating LaTeX formulas for academic papers).
* **`summary_coef()`**: Extracts and formats summary coefficients into clean, standard tables.
* **`random_effects()`**: Extracts the predicted random effects from mixed-effects models.

### 3. Diagnostics & Goodness-of-Fit
* **`gof_tab()`**: Computes, extracts, and formats goodness-of-fit statistics.
* **`plot_envelope()`**: Generates simulated half-normal plots (envelopes) for model residuals.
* **`df_envelopes()`**: Extracts the simulated envelope data into a standard `data.frame`, allowing users to build custom, publication-ready grayscale plots using `ggplot2` and `ggh4x`.
* **`plot_ranef()`**: Creates caterpillar plots to visualize random effects and their uncertainties.

### 4. Automated Reporting
* **`write_methods()`**: Automatically generates draft text for the methods section based on the fitted model structure, streamlining academic reporting.

## Installation

You can install the development version of `unitcore` from GitHub using the `remotes` package. 

```r
# install.packages("remotes")
remotes::install_github("rpetterle/unitcore")
```

## Usage for Package Developers

If you are developing a new regression package for bounded data and want to utilize these standardized generics, simply import `unitcore` in your `DESCRIPTION` file and define the respective methods for your model object class. 

For example, in your new package:

```r
#' @export
extract_equations.my_new_model <- function(object, ...) {
  # Implementation for your specific model class
}
```

For details on specific methods already implemented, see the documentation in their respective packages (`unitregTMB`, `betamodal`, `uigTMB`).

## License

This package is licensed under the MIT License.
