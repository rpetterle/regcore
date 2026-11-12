test_that("model-specific implementations receive additional arguments", {
  namespace <- asNamespace("regcore")
  method <- function(object, ...) list(object = object, options = list(...))
  registerS3method("gof_tab", "regcore_test_options", method, envir = namespace)

  fit <- structure(list(id = 3L), class = "regcore_test_options")
  result <- regcore::gof_tab(fit, digits = 3, order_by = "AIC")
  expect_identical(result$object, fit)
  expect_identical(result$options, list(digits = 3, order_by = "AIC"))
})

test_that("two-argument comparison preserves argument ordering", {
  namespace <- asNamespace("regcore")
  method <- function(object1, object2, ...) list(first = object1, second = object2, options = list(...))
  registerS3method("vuong_test", "regcore_test_comparison", method, envir = namespace)

  first <- structure(list(id = 1L), class = "regcore_test_comparison")
  second <- structure(list(id = 2L), class = "regcore_test_other")
  result <- regcore::vuong_test(first, second, alternative = "greater")
  expect_identical(result$first, first)
  expect_identical(result$second, second)
  expect_identical(result$options$alternative, "greater")
})
