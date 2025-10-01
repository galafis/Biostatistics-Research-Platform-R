library(testthat)
library(readr)

current_dir <- getwd()
setwd("..") # Move up to the root of the repository
source("src/main.R")
setwd(current_dir) # Restore original working directory

# Define a temporary directory for test outputs
test_output_dir <- "test_results"

# Helper function to clean up test outputs
cleanup_test_outputs <- function() {
  if (dir.exists(test_output_dir)) {
    unlink(test_output_dir, recursive = TRUE)
  }
}

# Run cleanup before tests
cleanup_test_outputs()

# Test suite for main.R functions
# test_check("Biostatistics-Research-Platform-R") # This is for package testing, not direct script testing

# Test load_data function
test_that("load_data loads data correctly", {
  # Create a dummy CSV file for testing
  if (!dir.exists("data")) dir.create("data")
  dummy_data <- data.frame(col1 = 1:3, col2 = c("A", "B", "C"))
  write_csv(dummy_data, "data/dummy_test_data.csv")
  
  data <- load_data("data/dummy_test_data.csv")
  expect_s3_class(data, "data.frame")
  expect_equal(nrow(data), 3)
  expect_equal(colnames(data), c("col1", "col2"))
  
  # Clean up dummy file
  file.remove("data/dummy_test_data.csv")
})

test_that("load_data throws error for non-existent file", {
  expect_error(load_data("non_existent_file.csv"), "File not found")
})

# Test perform_analysis function
test_that("perform_analysis returns expected structure", {
  sample_data <- data.frame(
    value = rnorm(100, mean = 10, sd = 2),
    group = factor(sample(c("Control", "Treatment"), 100, replace = TRUE)),
    x_var = runif(100, 0, 10),
    y_var = 2 * runif(100, 0, 10) + rnorm(100, 0, 1)
  )
  results <- perform_analysis(sample_data)
  expect_type(results, "list")
  expect_named(results, c("descriptive_statistics", "correlation_matrix", "t_test", "anova", "regression", "plot"))
  expect_s3_class(results$plot, "ggplot")
})

test_that("perform_analysis handles empty data", {
  empty_data <- data.frame()
  expect_error(perform_analysis(empty_data), "No data provided for analysis.")
})

# Test save_results function
test_that("save_results creates output files", {
  sample_data <- data.frame(
    value = rnorm(100, mean = 10, sd = 2),
    group = factor(sample(c("Control", "Treatment"), 100, replace = TRUE)),
    x_var = runif(100, 0, 10),
    y_var = 2 * runif(100, 0, 10) + rnorm(100, 0, 1)
  )
  results <- perform_analysis(sample_data)
  
  cleanup_test_outputs() # Ensure clean state
  save_results(results, test_output_dir)
  
  expect_true(dir.exists(test_output_dir))
  expect_true(file.exists(file.path(test_output_dir, "descriptive_statistics.csv")))
  expect_true(file.exists(file.path(test_output_dir, "correlation_matrix.csv")))
  expect_true(file.exists(file.path(test_output_dir, "analysis_plot.png")))
  
  cleanup_test_outputs() # Clean up after test
})

# Run cleanup after all tests
# on.exit(cleanup_test_outputs())

