dir.create("~/R/x86_64-pc-linux-gnu-library/4.1", showWarnings = FALSE, recursive = TRUE)
.libPaths("~/R/x86_64-pc-linux-gnu-library/4.1")

packages <- c("testthat", "ggplot2", "dplyr", "tidyr", "readr", "broom")

for (pkg in packages) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, repos = "http://cran.us.r-project.org")
  }
}

