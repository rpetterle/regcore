#' Extract Mathematical Equations from Fitted Models
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{extract_equations.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{extract_equations.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{extract_equations.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
extract_equations <- function(object, ...) {
  UseMethod("extract_equations")
}

#' Extract Goodness-of-Fit Statistics
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{gof_tab.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{gof_tab.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{gof_tab.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
gof_tab <- function(object, ...) {
  UseMethod("gof_tab")
}

#' Plot Simulated Envelope for Residuals
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{plot_envelope.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{plot_envelope.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{plot_envelope.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
plot_envelope <- function(object, ...) {
  UseMethod("plot_envelope")
}

#' Extract and Format Summary Coefficients
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{summary_coef.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{summary_coef.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{summary_coef.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
summary_coef <- function(object, ...) {
  UseMethod("summary_coef")
}

#' Plot Random Effects (Caterpillar Plot)
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{plot_ranef.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{plot_ranef.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{plot_ranef.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
plot_ranef <- function(object, ...) {
  UseMethod("plot_ranef")
}

#' Automatically Generate Methods Section Text
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{write_methods.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{write_methods.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{write_methods.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
write_methods <- function(object, ...) {
  UseMethod("write_methods")
}

#' Extract Random Effects
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{random_effects.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{random_effects.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{random_effects.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
random_effects <- function(object, ...) {
  UseMethod("random_effects")
}

#' Vuong Test for Non-Nested Models
#'
#' @param object1 A fitted model object.
#' @param object2 Another fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{vuong_test.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{vuong_test.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{vuong_test.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
vuong_test <- function(object1, object2, ...) {
  UseMethod("vuong_test")
}

#' Pairwise Vuong Test for Multiple Models
#'
#' @param ... Fitted model objects.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{pairwise_vuong_test.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{pairwise_vuong_test.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{pairwise_vuong_test.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
pairwise_vuong_test <- function(...) {
  UseMethod("pairwise_vuong_test")
}

#' Stepwise Variable Selection
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{stepCriterion.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{stepCriterion.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{stepCriterion.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
stepCriterion <- function(object, ...) {
  UseMethod("stepCriterion")
}

#' Extract Envelope Data into a Data Frame
#'
#' @param object A fitted model object.
#' @param ... Additional arguments passed to specific methods.
#'
#' @seealso 
#' For details on specific methods, see the documentation in their respective packages:
#' \itemize{
#'   \item \code{\link[betamodal]{df_envelopes.betamodal}} for betamodal models.
#'   \item \code{\link[unitregTMB]{df_envelopes.unitregTMB}} for unitregTMB models.
#'   \item \code{\link[uigTMB]{df_envelopes.uigTMB}} for uigTMB models.
#' }
#' 
#' @export
df_envelopes <- function(object, ...) {
  UseMethod("df_envelopes")
}