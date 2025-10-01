
# Test script for main.R

# Source the main analysis script
source("src/main.R")

# Define paths relative to the project root
input_file <- "data/sample_data.csv"
output_dir <- "results"

# Run the analysis
cat("Running main analysis with sample data...\n")

# Load data
data <- load_data(input_file)

# Perform analysis
analysis_results <- perform_analysis(data)

# Save results
save_results(analysis_results, output_dir)

# Check if output files exist
expected_files <- c(
  file.path(output_dir, "descriptive_statistics.csv"),
  file.path(output_dir, "correlation_matrix.csv"),
  file.path(output_dir, "analysis_plot.png")
)

all_files_exist <- all(file.exists(expected_files))

if (all_files_exist) {
  cat("All expected output files were created successfully!\n")
} else {
  cat("Error: Some output files were not created.\n")
  print(expected_files[!file.exists(expected_files)])
}

# Clean up generated files for a clean test environment
# unlink(output_dir, recursive = TRUE)

cat("Test completed.\n")

