# Install the data.table package from CRAN
install.packages("data.table", repos = "https://cran.rstudio.com/")

# Load the package
library(data.table)

# Print Hello world!
print("Hello world!")

# Optional: Show that data.table is working
cat("data.table version:", as.character(packageVersion("data.table")), "\n")

# Read CSV file into a data.table object
cat("\nReading CSV file into data.table...\n")
dt <- fread("sample_data.csv")

# Print the head of the data.table
cat("\nFirst few rows of the data.table:\n")
print(head(dt))