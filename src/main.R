
# Biostatistics-Research-Platform-R - Professional R Implementation
# Advanced Biostatistics for data analysis

# Load necessary libraries
library(ggplot2)
library(dplyr)
library(tidyr)
library(readr) # For reading CSV files
library(broom) # For tidying model outputs

# Function to load data
load_data <- function(file_path) {
  if (!file.exists(file_path)) {
    stop(paste("Error: File not found at", file_path))
  }
  data <- read_csv(file_path)
  return(data)
}

# Main analysis function
perform_analysis <- function(data) {
  if (is.null(data) || nrow(data) == 0) {
    stop("Error: No data provided for analysis.")
  }
  
  # Ensure data has numeric columns for statistical tests
  numeric_data <- select_if(data, is.numeric)
  if (ncol(numeric_data) < 2) {
    stop("Error: Not enough numeric columns for statistical analysis.")
  }

  # Descriptive statistics
  desc_stats <- data %>% 
    select_if(is.numeric) %>% 
    summarise_all(list(mean = mean, sd = sd, median = median), na.rm = TRUE)

  
  # Correlation matrix
  correlation_matrix <- cor(numeric_data, use = "pairwise.complete.obs")
  
  # Example: T-test (assuming at least two groups in a 'group' column and a 'value' column)
  t_test_results <- NULL
  if ("group" %in% colnames(data) && "value" %in% colnames(data) && length(unique(data$group)) == 2) {
    t_test_results <- t.test(value ~ group, data = data) %>% tidy()
  }
  
  # Example: ANOVA (assuming a 'group' column with >2 groups and a 'value' column)
  anova_results <- NULL
  if ("group" %in% colnames(data) && "value" %in% colnames(data) && length(unique(data$group)) > 2) {
    anova_results <- aov(value ~ group, data = data) %>% tidy()
  }
  
  # Example: Linear Regression (assuming 'y_var' and 'x_var' numeric columns)
  regression_results <- NULL
  if ("y_var" %in% colnames(data) && "x_var" %in% colnames(data) && is.numeric(data$y_var) && is.numeric(data$x_var)) {
    regression_results <- lm(y_var ~ x_var, data = data) %>% tidy()
  }

  # Visualization: Scatter plot with regression line if applicable
  plot <- NULL
  if ("y_var" %in% colnames(data) && "x_var" %in% colnames(data) && is.numeric(data$y_var) && is.numeric(data$x_var)) {
    plot <- ggplot(data, aes(x = x_var, y = y_var)) +
      geom_point(aes(color = as.factor(group))) + 
      geom_smooth(method = "lm", se = FALSE) + 
      theme_minimal() + 
      labs(title = "Biostatistics Analysis: Scatter Plot",
           x = "Independent Variable", y = "Dependent Variable")
  } else if (ncol(numeric_data) >= 2) {
    # Fallback for general scatter plot if specific y_var/x_var not found
    plot <- ggplot(data, aes_string(x = colnames(numeric_data)[1], y = colnames(numeric_data)[2])) +
      geom_point() + theme_minimal() + labs(title = "Biostatistics Analysis: Scatter Plot")
  }
  
  results <- list(
    descriptive_statistics = desc_stats,
    correlation_matrix = correlation_matrix,
    t_test = t_test_results,
    anova = anova_results,
    regression = regression_results,
    plot = plot
  )
  
  return(results)
}

# Function to save results
save_results <- function(results, output_dir = "results") {
  if (!dir.exists(output_dir)) {
    dir.create(output_dir)
  }
  
  # Save descriptive statistics
  write_csv(as.data.frame(results$descriptive_statistics), file.path(output_dir, "descriptive_statistics.csv"))
  
  # Save correlation matrix
  write_csv(as.data.frame(results$correlation_matrix), file.path(output_dir, "correlation_matrix.csv"))
  
  # Save t-test results
  if (!is.null(results$t_test)) {
    write_csv(as.data.frame(results$t_test), file.path(output_dir, "t_test_results.csv"))
  }
  
  # Save ANOVA results
  if (!is.null(results$anova)) {
    write_csv(as.data.frame(results$anova), file.path(output_dir, "anova_results.csv"))
  }
  
  # Save regression results
  if (!is.null(results$regression)) {
    write_csv(as.data.frame(results$regression), file.path(output_dir, "regression_results.csv"))
  }
  
  # Save plot
  if (!is.null(results$plot)) {
    ggsave(file.path(output_dir, "analysis_plot.png"), results$plot, width = 10, height = 7)
  }
  
  cat(paste0("Results saved to ", output_dir, "/\n"))
}

# Command-line argument parsing
# Rscript src/main.R --input data/sample_data.csv --output results
args <- commandArgs(trailingOnly = TRUE)

if (length(args) > 0) {
  input_file <- NULL
  output_dir <- "results"
  
  for (i in 1:length(args)) {
    if (args[i] == "--input") {
      input_file <- args[i+1]
    } else if (args[i] == "--output") {
      output_dir <- args[i+1]
    }
  }
  
  if (is.null(input_file)) {
    stop("Error: --input file path is required when running from command line.")
  }
  
  cat(paste0("Loading data from ", input_file, "...\n"))
  data <- load_data(input_file)
  
  cat("Performing analysis...\n")
  analysis_results <- perform_analysis(data)
  
  cat("Saving results...\n")
  save_results(analysis_results, output_dir)
  
  cat("Analysis completed successfully!\n")
} else {
  cat("Running in interactive mode or with default sample data (if implemented).\n")
  cat("Please provide --input and --output arguments for command-line execution.\n")
  
  # For demonstration in interactive mode, create dummy data
  cat("Generating sample data for interactive demonstration...\n")
  sample_data <- data.frame(
    value = rnorm(100, mean = 10, sd = 2),
    group = factor(sample(c("Control", "Treatment1", "Treatment2"), 100, replace = TRUE)),
    x_var = runif(100, 0, 10),
    y_var = 2 * runif(100, 0, 10) + rnorm(100, 0, 1)
  )
  
  # Create dummy data directory and file for interactive testing
  if (!dir.exists("data")) dir.create("data")
  write_csv(sample_data, "data/sample_data_interactive.csv")
  
  cat("Performing analysis on sample data...\n")
  analysis_results_interactive <- perform_analysis(sample_data)
  
  cat("Saving interactive results...\n")
  save_results(analysis_results_interactive, "results_interactive")
  
  cat("Interactive analysis completed successfully!\n")
}

