## First CRAN submission

This is the initial CRAN submission of `regcore`, a package providing S3 generic functions for regression model diagnostics, model comparison, coefficient summaries, random-effects extraction, and reporting.

The package provides common interfaces that can be implemented by other R packages, including `betamodal` and `unitregTMB`. It has no runtime dependencies beyond R.


## Check results

- Ubuntu Linux (R 4.4.2): 0 errors, 0 warnings, 0 notes.
- Windows R-devel (WinBuilder): 0 errors, 0 warnings, 1 note.
- Linux R-devel (GitHub Actions): 0 errors, 0 warnings, 1 note.

The local Ubuntu check was performed with the external system
clock verification disabled.

The only note reported by the R-devel checks was:

    New submission

This note is expected because this is the first submission
of regcore to CRAN.


## Reverse dependencies

There are no reverse dependencies on CRAN, as this is the initial submission. Packages under development that use the S3 generic interfaces are not required dependencies of `regcore`.