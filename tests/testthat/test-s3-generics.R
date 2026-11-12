generic_names <- c("df_envelopes", "extract_equations", "gof_tab", "pairwise_vuong_test",
                   "plot_envelope", "plot_ranef", "random_effects", "stepCriterion",
                   "summary_coef", "vuong_test", "write_methods")

test_that("all public generics preserve their S3 interfaces", {
  expect_true(all(generic_names %in% getNamespaceExports("regcore")))
  for (name in generic_names) {
    fun <- getExportedValue("regcore", name)
    expect_true(is.function(fun), info = name)
    expect_true(grepl(paste0('UseMethod("', name, '")'), paste(deparse(body(fun)), collapse = " "), fixed = TRUE), info = name)
  }
  expect_identical(names(formals(regcore::pairwise_vuong_test)), "...")
  expect_identical(names(formals(regcore::vuong_test)), c("object1", "object2", "..."))
})

test_that("every generic dispatches to a downstream S3 method", {
  namespace <- asNamespace("regcore")
  first <- structure(list(id = 1L), class = "regcore_test_model")
  second <- structure(list(id = 2L), class = "regcore_other_model")

  for (name in generic_names) {
    method <- local({ method_name <- name; function(...) list(name = method_name, arguments = list(...)) })
    registerS3method(name, "regcore_test_model", method, envir = namespace)

    args <- if (name == "vuong_test") list(object1 = first, object2 = second) else
            if (name == "pairwise_vuong_test") list(first, second) else list(object = first)
    result <- do.call(getExportedValue("regcore", name), args)

    expect_identical(result$name, name, info = name)
    expect_identical(result$arguments[[1L]], first, info = name)
    if (name %in% c("vuong_test", "pairwise_vuong_test")) {
      expect_identical(result$arguments[[2L]], second, info = name)
    }
  }
})

test_that("unsupported model classes report missing methods", {
  unknown <- structure(list(), class = "regcore_unsupported_model")
  expect_error(regcore::gof_tab(unknown), "no applicable method")
  expect_error(regcore::summary_coef(unknown), "no applicable method")
})
