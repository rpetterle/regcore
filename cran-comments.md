## First CRAN submission

This is the initial CRAN submission of regcore, a package containing S3 generic
interfaces for regression modeling packages. Model-specific methods are
implemented by downstream packages; regcore has no runtime dependencies.

## Check results

The maintainer reported 0 errors, 0 warnings, and 0 notes for the **previous**
package source archive on Ubuntu Linux using R CMD check --as-cran, with the
external clock check disabled. The revised source included here still requires
fresh local and cross-platform checks before submission.

- Ubuntu Linux (R release): PENDING
- Windows (R release/devel): PENDING
- macOS (R release): PENDING
- R-devel: PENDING

## Reverse dependencies

None on CRAN for the initial submission. Development packages relying on the
S3 generic interfaces are not listed as mandatory dependencies.
