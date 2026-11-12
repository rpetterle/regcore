#' Extract Mathematical Equations from Fitted Models
#'
#' @description
#' Extracts the mathematical formulation of a fitted model. Downstream methods
#' typically support generating both theoretical (symbolic with Greek letters)
#' and fitted (numeric with estimated coefficients) equations formatted in LaTeX.
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods (e.g., specifying
#'        "symbolic" or "numeric" modes, or selecting specific submodels).
#'
#' @details
#' This is an S3 generic. It is designed to bridge the gap between statistical
#' modeling and academic reporting. Methods usually identify random effects,
#' multiple linear predictors, and assign proper indices for longitudinal data.
#'
#' @return
#' Generally expected to return a character string containing the LaTeX code
#' for the equations, and to print the output directly to the console.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @export
extract_equations <- function(object, ...) {
  UseMethod("extract_equations")
}

#' Goodness-of-Fit Table for Regression Models
#'
#' @description
#' Computes, compiles, and compares standard goodness-of-fit metrics
#' (such as log-likelihood, AIC, and BIC) for one or multiple fitted models.
#'
#' @param object A fitted model object.
#' @param ... Additional fitted model objects for side-by-side comparison.
#'
#' @details
#' This S3 generic acts as a unified interface to evaluate model performance.
#' When multiple models are provided via \code{...}, downstream methods typically
#' align the metrics into a clear comparative table.
#'
#' @return
#' Generally returns a structured object (e.g., a list or data frame) containing
#' the computed metrics for each evaluated model, along with custom print methods.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @examples
#' fit <- structure(list(aic = 12.5), class = "demo_regression")
#' gof_tab.demo_regression <- function(object, ...) data.frame(AIC = object$aic)
#' gof_tab(fit)
#'
#' @export
gof_tab <- function(object, ...) {
  UseMethod("gof_tab")
}

#' Diagnostic Plots with Simulated Envelopes
#'
#' @description
#' Generates a (half-)normal probability plot with a simulated envelope for model
#' residuals. It is a visual diagnostic tool to assess goodness-of-fit and
#' distributional assumptions.
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods (e.g., number of
#'        simulations, confidence level, parallel computing cores).
#'
#' @details
#' Class-specific methods evaluate whether observed residuals behave as expected under the
#' fitted model by comparing them with simulated confidence bands. Methods may
#' support different residual types (e.g., randomized quantile, Cox-Snell).
#'
#' @return
#' Invisibly returns a list or data frame containing the envelope coordinates,
#' while producing a plot as a side effect.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @export
plot_envelope <- function(object, ...) {
  UseMethod("plot_envelope")
}

#' Extract and Format Summary Coefficients
#'
#' @description
#' Extracts, formats, and compiles fixed-effects coefficients and their standard
#' errors from one or multiple fitted models, facilitating side-by-side comparisons.
#'
#' @param object A fitted model object.
#' @param ... Additional fitted model objects for comparison, and other arguments
#'        passed to specific methods (e.g., selecting submodels, LaTeX table prep).
#'
#' @details
#' This S3 generic streamlines the creation of clean, publication-ready tables.
#' Downstream methods usually handle multiple predictors, align identical variables
#' across models, and can format the output as a LaTeX tabular environment.
#'
#' @return
#' Typically returns a structured object containing the compiled coefficients
#' and standard errors, accompanied by a custom print method.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @examples
#' fit <- structure(list(beta = c(intercept = 0.3, slope = -0.2)), class = "demo_coef")
#' summary_coef.demo_coef <- function(object, ...) object$beta
#' summary_coef(fit)
#'
#' @export
summary_coef <- function(object, ...) {
  UseMethod("summary_coef")
}

#' Plot Random Effects (Caterpillar Plot)
#'
#' @description
#' Produces a caterpillar plot of the predicted conditional modes of the random
#' effects from a fitted mixed-effects model, optionally with uncertainty intervals.
#'
#' @param object A fitted model object containing random effects.
#' @param ... Additional graphical arguments passed to specific plotting methods.
#'
#' @details
#' Visualizes unobserved heterogeneity at the group level. The generic delegates
#' the extraction and sorting of the estimates to class-specific methods.
#'
#' @return
#' Invisibly returns a data frame containing the sorted estimated random effects
#' and their confidence bounds, while generating a plot.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @export
plot_ranef <- function(object, ...) {
  UseMethod("plot_ranef")
}

#' Automatically Generate Methods Section Text
#'
#' @description
#' Translates the structure of a fitted model into boilerplate draft text for
#' the "Methods" section of academic papers or reports.
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods (e.g., language
#'        selection like English or Portuguese).
#'
#' @details
#' This generic automates academic reporting by dynamically detecting the
#' distribution family, link functions, inflation structures, and random effects,
#' outputting standardized descriptive text and the software citation.
#'
#' @return
#' Invisibly returns a list containing the generated text and the BibTeX
#' citation, while printing them to the console.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @export
write_methods <- function(object, ...) {
  UseMethod("write_methods")
}

#' Extract Predicted Random Effects
#'
#' @description
#' Extracts predicted random effects (typically conditional modes) from
#' a fitted mixed-effects model.
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @details
#' This S3 generic provides a unified way to retrieve conditional modes. Methods
#' typically organize the output by grouping factors, handling multiple random terms.
#'
#' @return
#' Typically returns a list (one element per grouping variable) containing
#' data frames of the estimated random effects.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @export
random_effects <- function(object, ...) {
  UseMethod("random_effects")
}

#' Vuong Test for Non-Nested Models
#'
#' @description
#' Performs the Vuong likelihood ratio test to compare two non-nested competing
#' regression models to determine which is closer to the true data-generating process.
#'
#' @param object1 A fitted model object.
#' @param object2 Another fitted model object to be compared with \code{object1}.
#' @param ... Additional arguments passed to specific methods (e.g., alternative hypothesis).
#'
#' @details
#' The Vuong test utilizes conditional pointwise log-likelihoods. This S3 generic
#' dispatches the extraction and statistical testing to specific model implementations.
#'
#' @return
#' Generally returns an object of class \code{htest} containing the test statistic,
#' p-value, and the conclusion regarding model preference.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @export
vuong_test <- function(object1, object2, ...) {
  UseMethod("vuong_test")
}

#' Pairwise Vuong Test for Multiple Models
#'
#' @description
#' Conducts pairwise Vuong likelihood ratio tests across multiple non-nested
#' competing models.
#'
#' @param ... Fitted model objects to be compared.
#'
#' @details
#' Downstream methods can compare more than two models simultaneously,
#' returning a matrix of comparisons (and, when supported, adjusted p-values) to assess
#' relative model fit.
#'
#' @return
#' The return value depends on the class-specific method, often a structured
#' collection of pairwise statistics and p-values.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @export
pairwise_vuong_test <- function(...) {
  UseMethod("pairwise_vuong_test")
}

#' Stepwise Variable Selection (Backward Elimination)
#'
#' @description
#' Performs backward variable selection to identify the most parsimonious model,
#' removing predictors iteratively based on Wald test p-values or Information
#' Criteria (AIC, BIC).
#'
#' @param object A fitted model object representing the starting full model.
#' @param ... Additional arguments passed to specific methods (e.g., criterion choice,
#'        p-value thresholds).
#'
#' @details
#' Methods for this generic generally focus on optimizing the main location
#' (mean/quantile) submodel, keeping random effects and auxiliary parameters
#' (like precision or zero-inflation) intact during the elimination process.
#'
#' @return
#' Typically returns a fitted model object representing the final selected model
#' after the backward elimination completes.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @export
stepCriterion <- function(object, ...) {
  UseMethod("stepCriterion")
}

#' Extract Envelope Data into a Tidy Data Frame
#'
#' @description
#' Extracts the coordinates of simulated envelopes from one or more fitted models,
#' returning a tidy data frame in long format.
#'
#' @param object A fitted model object.
#' @param ... Additional fitted model objects, and arguments passed to specific
#'        methods (e.g., number of simulations).
#'
#' @details
#' Unlike graphical methods such as \code{plot_envelope()}, \code{df_envelopes()}
#' delegates the extraction of envelope data to class-specific methods. Such methods
#' may return envelope bounds and observed residuals suitable for graphics
#' in other packages.
#'
#' @return
#' A \code{data.frame} containing columns for theoretical quantiles, observed residuals,
#' envelope bounds, and a factor column indicating the source model.
#'
#' @seealso
#' The generic is implemented here; class-specific behavior is defined in
#' downstream packages that provide S3 methods.
#'
#' @export
df_envelopes <- function(object, ...) {
  UseMethod("df_envelopes")
}
