print("Test Test Test ... ... ...")

# Install the data.table package from CRAN
install.packages("data.table", repos = "https://cran.rstudio.com/")

# Load the package (should be pre-installed in the image)
library("data.table")

# Print Hello world!
print("Hello world!")

# Optional: Show that data.table is working
cat("data.table version:", as.character(packageVersion("data.table")), "\n")

# Read CSV file into a data.table object
cat("\nReading CSV file into data.table...\n")
dt <- fread("sample_data.csv")

# Get command line arguments
args <- commandArgs(trailingOnly = TRUE)

# Check if column names were provided
if (length(args) > 0) {
  # Split comma-separated column names
  requested_cols <- unlist(strsplit(args[1], ","))
  # Remove any whitespace
  requested_cols <- trimws(requested_cols)
  
  # Check which columns exist in the data
  available_cols <- names(dt)
  valid_cols <- requested_cols[requested_cols %in% available_cols]
  invalid_cols <- requested_cols[!requested_cols %in% available_cols]
  
  if (length(invalid_cols) > 0) {
    cat("Warning: The following columns do not exist:", paste(invalid_cols, collapse = ", "), "\n")
  }
  
  if (length(valid_cols) > 0) {
    cat("Displaying columns:", paste(valid_cols, collapse = ", "), "\n")
    # Select only the requested columns
    dt_selected <- dt[, ..valid_cols]
    cat("\nFirst few rows of the selected columns:\n")
    print(head(dt_selected))
  } else {
    cat("Error: No valid column names provided. Available columns are:", paste(available_cols, collapse = ", "), "\n")
    cat("Showing all columns instead:\n")
    print(head(dt))
  }
} else {
  # No arguments provided, show all columns
  cat("No column names specified. Showing all columns:\n")
  cat("Available columns:", paste(names(dt), collapse = ", "), "\n")
  cat("\nFirst few rows of the data.table:\n")
  print(head(dt))
}