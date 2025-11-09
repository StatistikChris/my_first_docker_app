library(plumber)
library(data.table)
library(jsonlite)

# Read CSV file into a data.table object at startup
cat("Loading CSV file into data.table...\n")
dt <- fread("sample_data.csv")
cat("Data loaded. Available columns:", paste(names(dt), collapse = ", "), "\n")

#* @apiTitle My R Data API
#* @apiDescription A simple API to display data.table data with optional column filtering

#* Health check endpoint
#* @get /health
function() {
  list(
    status = "healthy",
    message = "Hello world!",
    data_table_version = as.character(packageVersion("data.table")),
    available_columns = names(dt)
  )
}

#* Get all data or filtered columns
#* @param columns Comma-separated list of column names to display
#* @get /data
function(columns = NULL) {
  if (is.null(columns) || columns == "") {
    # No columns specified, return all columns
    result <- list(
      message = "Showing all columns",
      available_columns = names(dt),
      data = head(dt, 10)  # Show first 10 rows
    )
  } else {
    # Split comma-separated column names
    requested_cols <- unlist(strsplit(columns, ","))
    requested_cols <- trimws(requested_cols)
    
    # Check which columns exist in the data
    available_cols <- names(dt)
    valid_cols <- requested_cols[requested_cols %in% available_cols]
    invalid_cols <- requested_cols[!requested_cols %in% available_cols]
    
    if (length(valid_cols) > 0) {
      # Select only the requested columns
      dt_selected <- dt[, ..valid_cols]
      result <- list(
        message = paste("Displaying columns:", paste(valid_cols, collapse = ", ")),
        requested_columns = valid_cols,
        data = head(dt_selected, 10)
      )
      
      if (length(invalid_cols) > 0) {
        result$warning <- paste("Invalid columns ignored:", paste(invalid_cols, collapse = ", "))
      }
    } else {
      result <- list(
        error = "No valid column names provided",
        available_columns = available_cols,
        invalid_columns = invalid_cols,
        data = head(dt, 10)  # Show all columns as fallback
      )
    }
  }
  
  return(result)
}

#* Root endpoint
#* @get /
function() {
  list(
    message = "Hello world! Welcome to the R Data API",
    endpoints = list(
      health = "/health - Check API health and get basic info",
      data = "/data - Get all data",
      filtered = "/data?columns=name,age - Get specific columns"
    ),
    available_columns = names(dt)
  )
}